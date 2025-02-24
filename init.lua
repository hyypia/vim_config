local set = vim.opt

set.number = true
set.mouse = 'a'
set.encoding = 'utf-8'
 -- set.noswapfile = true
set.tabstop = 4
-- set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true
set.scrolloff = 7
set.colorcolumn = '79'
set.updatetime = 300
-- set.nocompatible = true
set.cmdheight = 2           -- more space in the neovim command line for displaying messages
set.signcolumn = "yes"      -- always show the sign column, otherwise it would shift the text each time


-- Keymaps
local keyset = vim.keymap.set
-- jk to escape
keyset('i', 'jk', '<Esc>')

-- ctrl+s saving
keyset("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
keyset("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
keyset("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')

-- Visual
Plug('dracula/vim', { ['as'] = 'dracula' })
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'windwp/nvim-autopairs'

-- Code autocomplete and snippets (:CocInstall coc-pyright /
-- clangd / html / json / tsserver / sql-language-server)
Plug('neoclide/coc.nvim', {['branch'] = 'release'})
Plug('yaegassy/coc-ruff', {['do'] = 'yarn install --frozen-lockfile'})
Plug('yaegassy/coc-black-formatter', {['do'] = 'yarn install --frozen-lockfile'})
                                                        
vim.call('plug#end')

vim.cmd[[
    colorscheme dracula
    highlight ColorColumn ctermbg=60
    highlight LineNr ctermbg=140
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]]

require('configs.lualine')
require("nvim-treesitter.configs").setup({
    ensure_installed = { "python" },  -- install Python parser
    highlight = { enable = true },    -- enable syntax highlighting
})
require('nvim-autopairs').setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt" , "vim" },
})

-- Coc Keymaps
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
