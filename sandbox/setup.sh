#!/usr/bin/env bash
# setup.sh - provision a fresh Debian OrbStack machine as a coding sandbox.
# Run as root inside the machine (the sandbox wrapper does this for you).
set -euo pipefail

GO_VERSION="${GO_VERSION:-1.26.0}"

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
    git curl wget ca-certificates gnupg jq ripgrep less procps make unzip \
    chromium fonts-liberation

# --- Go toolchain ---
arch="$(dpkg --print-architecture)" # arm64 on Apple silicon
curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${arch}.tar.gz" \
  | tar -C /usr/local -xz
ln -sf /usr/local/go/bin/go /usr/local/bin/go
ln -sf /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# Go dev tools, installed system-wide
GOBIN=/usr/local/bin go install github.com/air-verse/air@latest
GOBIN=/usr/local/bin go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
GOBIN=/usr/local/bin go install github.com/pressly/goose/v3/cmd/goose@latest
GOBIN=/usr/local/bin go install github.com/go-jet/jet/v2/cmd/jet@latest
GOBIN=/usr/local/bin go install github.com/a-h/templ/cmd/templ@latest
GOBIN=/usr/local/bin go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@v2.4.1
rm -rf /root/go /root/.cache/go-build

# --- Tailwind standalone CLI (Linux build; Makefile's is darwin) ---
case "$arch" in
  arm64) tw_asset=tailwindcss-linux-arm64; mp_asset=mailpit-linux-arm64.tar.gz ;;
  amd64) tw_asset=tailwindcss-linux-x64;   mp_asset=mailpit-linux-amd64.tar.gz ;;
esac
curl -fsSL -o /usr/local/bin/tailwindcss \
  "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/${tw_asset}"
chmod +x /usr/local/bin/tailwindcss

# --- Node 22 + package managers ---
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs
corepack enable

# --- Claude Code ---
npm install -g @anthropic-ai/claude-code

# --- Git defaults (system-wide, applies to the login user) ---
git config --system --add safe.directory /workspace
git config --system user.name  "Phase Software AB Sandbox"
git config --system user.email "no-reply@phase.se"

# --- Browser env for Playwright/Puppeteer reuse ---
cat > /etc/profile.d/sandbox.sh << 'EOF'
export CHROME_BIN=/usr/bin/chromium
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
EOF

# --- PostgreSQL 17, pinned via the official PGDG repo ---
apt-get install -y postgresql-common
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
apt-get install -y postgresql-17 postgresql-client-17
systemctl enable --now postgresql
# Superuser role + default db for the login user (peer auth on localhost socket)
if [ -n "${SETUP_USER:-}" ]; then
    sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname='${SETUP_USER}'" | grep -q 1 \
      || sudo -u postgres createuser --superuser "${SETUP_USER}"
    sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='${SETUP_USER}'" | grep -q 1 \
      || sudo -u postgres createdb -O "${SETUP_USER}" "${SETUP_USER}"
fi

# --- Egress firewall: allow internet, block LAN (static nftables) ---
# Accepts OrbStack's internal ranges before the private-range reject:
# 192.168.138.0/23 = "IP range" in OrbStack Settings > Network (default),
# 198.18.0.0/15 = OrbStack machine network. If you change that setting,
# update the accept line to match. Traffic to other machines/host in these
# ranges is still blocked one layer down by --isolate-network.
apt-get install -y nftables
cat > /etc/nftables.conf << 'EOF'
#!/usr/sbin/nft -f
flush ruleset
table inet sandbox {
  chain output {
    type filter hook output priority 0; policy accept;
    oifname "lo" accept
    ct state established,related accept
    meta l4proto ipv6-icmp accept
    ip daddr { 192.168.138.0/23, 198.18.0.0/15 } accept comment "orbstack internal"
    ip daddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16,
               169.254.0.0/16, 100.64.0.0/10 } counter reject
    ip6 daddr { fc00::/7, fe80::/10 } counter reject
  }
}
EOF
systemctl enable --now nftables

# --- Project-specific extras (EDIT TO TASTE) ---
# apt-get install -y redis-server

apt-get clean
echo "sandbox provisioned: go $(go version | cut -d' ' -f3), node $(node --version)"
