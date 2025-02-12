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

-- Plug 'Mofiqul/dracula.nvim'
Plug('catppuccin/nvim', {['as'] = 'catppuccin' })
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvimtools/none-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

vim.call('plug#end')


-- theme setup
-- local dracula = require("dracula")
-- dracula.setup({
--   -- customize dracula color palette
--   colors = {
--     bg = "#282A36",
--     fg = "#F8F8F2",
--     selection = "#44475A",
--     comment = "#6272A4",
--     red = "#FF5555",
--     orange = "#FFB86C",
--     yellow = "#F1FA8C",
--     green = "#50fa7b",
--     purple = "#BD93F9",
--     cyan = "#8BE9FD",
--     pink = "#FF79C6",
--     bright_red = "#FF6E6E",
--     bright_green = "#69FF94",
--     bright_yellow = "#FFFFA5",
--     bright_blue = "#D6ACFF",
--     bright_magenta = "#FF92DF",
--     bright_cyan = "#A4FFFF",
--     bright_white = "#FFFFFF",
--     menu = "#21222C",
--     visual = "#3E4452",
--     gutter_fg = "#4B5263",
--     nontext = "#3B4048",
--     white = "#ABB2BF",
--     black = "#191A21",
--   },
--   -- show the '~' characters after the end of buffers
--   show_end_of_buffer = true, -- default false
--   -- use transparent background
--   transparent_bg = true, -- default false
--   -- set custom lualine background color
--   lualine_bg_color = "#44475a", -- default nil
--   -- set italic comment
--   italic_comment = true, -- default false
--   -- overrides the default highlights with table see `:h synIDattr`
--   overrides = {},
--   -- You can use overrides as table like this
--   -- overrides = {
--   --   NonText = { fg = "white" }, -- set NonText fg to white
--   --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
--   --   Nothing = {} -- clear highlight of Nothing
--   -- },
--   -- Or you can also use it like a function to get color from theme
--   -- overrides = function (colors)
--   --   return {
--   --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
--   --   }
--   -- end,
-- })

require('catppuccin').setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.cmd[[
    colorscheme catppuccin
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
