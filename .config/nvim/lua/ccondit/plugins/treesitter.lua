return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
				"angular",
				"arduino",
				"awk",
				"bash",
				"c",
				"cmake",
				"cpp",
        "css",
				"csv",
        "dockerfile",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"gpg",
				"go",
				"gomod",
				"gosum",
				"gowork",
        "graphql",
				"helm",
        "html",
				"java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
				"ninja",
				"objc",
				"perl",
				"php",
				"phpdoc",
				"pioasm",
        "prisma",
				"proto",
        "query",
				"r",
				"regex",
				"scala",
				"sql",
				"ssh_config",
        "svelte",
				"terraform",
        "tsx",
        "typescript",
				"udev",
        "vim",
        "vimdoc",
				"vue",
				"xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
