# Agentic Sandboxes

Each sandbox is an OrbStack [isolated machine](https://docs.orbstack.dev/machines/isolated): no Mac files shared except one mounted folder, no access to the macOS host or your LAN (`--isolate-network`), internet allowed, SSH agent forwarding off. Built for `claude --dangerously-skip-permissions`. By maintaining a *golden base machine* that is built once and then only cloned thereafter, creating another sandbox (with shared kernel) only takes seconds.

## Usage

```bash
# build the golden base (~a few min)
sandbox base

# create sandboxes
sandbox new api-v1
sandbox new api-v2

# start a session
sandbox shell api-v1
claude --dangerously-skip-permissions

# database
createdb sandboxdb
export DATABASE_URL=postgres://$USER@localhost:5432/sandboxdb
```

## Verify isolation inside sandbox

```bash
curl -sS https://github.com -o /dev/null -w '%{http_code}\n'  # 200
curl -m 3 http://192.168.1.1        # blocked (LAN)
curl -m 3 http://host.orb.internal  # blocked (Mac)
ls /mnt/mac 2>&1                    # nothing shared
```
