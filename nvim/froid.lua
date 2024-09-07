vim.filetype.add({ extension = { templ = "templ" } })

vim.opt.wrap = true

-- vim.keymap.set("n", "ü", "[")
-- vim.keymap.set("n", "ä", "{")
-- vim.keymap.set("n", "¨", "]")
-- vim.keymap.set("n", "à", "}")

-- Disable autoformat for templ files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "templ" },
  callback = function()
    vim.b.autoformat = false
  end,
})

return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("monokai-pro").setup({
        filter = "machine",
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },

  -- Git blame
  { "tpope/vim-fugitive" },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "html",
        "templ",
        "markdown",
      })
    end,
  },

  -- Apple PKL lang
  {
    "https://github.com/apple/pkl-neovim",
    lazy = true,
    event = "BufReadPre *.pkl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.cmd("TSInstall! pkl")
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      },
    },
  },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "html-lsp",
        "templ",
        "htmx-lsp",
        "tailwindcss-language-server",
        "clangd",
        "clang-format",
        "gopls",
      },
    },
  },

  -- disable inlay hints by default
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
}
