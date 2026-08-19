return {
  "nvim-treesitter/nvim-treesitter",
  -- The current setup/install API is provided by the main branch.
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local languages = {
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
    }

    require("nvim-treesitter").setup()
    require("nvim-treesitter").install(languages)
    require("nvim-ts-autotag").setup()

    local language_set = {}
    for _, language in ipairs(languages) do
      language_set[language] = true
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local language = vim.treesitter.language.get_lang(args.match)
        if not language_set[language] then
          return
        end

        if not pcall(vim.treesitter.start, args.buf, language) then
          return
        end

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
