require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "pyright" },
}

local lspconfig = require("lspconfig")
vim.g.coq_settings = { ['auto_start'] = true, ['display.icons.mode'] = 'none'  }
local coq = require("coq")

lspconfig.pyright.setup(coq.lsp_ensure_capabilities({
  default_config = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname)
    end,
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          autoImportCompletions = true,
          typeCheckingMode = 'strict',
          useLibraryCodeForTypes = true
        },
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    },
  },
  docs = {
    description = [[https://github.com/microsoft/pyright
    `pyright`, a static type checker and language server for python
    ]],
  },
}))

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.pylint.with({
            extra_args = { "--disable=missing-function-docstring,missing-class-docstring,missing-module-docstring" }
        }),
    },
})
