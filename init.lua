local set = vim.opt

set.number = true
set.mouse = 'a'
set.encoding = 'utf-8'
 -- set.noswapfile = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true
set.scrolloff = 7
set.colorcolumn = '79'
set.updatetime = 300
-- set.nocompatible = true
set.cmdheight = 2           -- more space in the neovim command line for displaying messages
set.signcolumn = "yes"      -- always show the sign column, otherwise it would shift the text each time

-- jk to escape
vim.keymap.set('i', 'jk', '<Esc>')

-- ctrl+s saving
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })

-- plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'Mofiqul/dracula.nvim'
-- Plug('catppuccin/nvim', {['as'] = 'catppuccin' })
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvimtools/none-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug('ms-jpq/coq_nvim', {['branch'] = 'coq'})
Plug('ms-jpq/coq.artifacts', {['branch'] = 'artifacts'})
Plug('ms-jpq/coq.thirdparty', {['branch'] = '3p'})

vim.call('plug#end')

require('configs.theme')

vim.cmd[[
    colorscheme dracula
    highlight ColorColumn ctermbg=60
    highlight LineNr ctermbg=140
]]


require("configs.lsp")
require('configs.lualine')

-- Use LSP for omnifunc for Python files
vim.cmd([[autocmd FileType python setlocal omnifunc=v:lua.vim.lsp.omnifunc]])


-- python keybidings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

require("nvim-treesitter.configs").setup({
    ensure_installed = { "python" },  -- install Python parser
    highlight = { enable = true },    -- enable syntax highlighting
})

require('nvim-autopairs').setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt" , "vim" },
})
