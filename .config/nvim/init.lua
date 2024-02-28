--------------------
-- EDITOR
--------------------
-- UI
vim.opt.colorcolumn = "80" -- set color column to 80 characters (highlight column after 80 characters)
vim.opt.cursorline = true -- highlight current line
vim.opt.number = true -- set numbered lines (line number in editor)
vim.opt.relativenumber = true -- set relative numbered lines (relative line number in editor)
vim.opt.scrolloff = 8 -- set scrolloff to 8 lines (keep 8 lines above and below cursor)
vim.opt.signcolumn = "yes" -- always show sign column (left)
vim.opt.termguicolors = true -- enable 24-bit RGB colors 
vim.cmd [[highlight ColorColumn ctermbg=235 guibg=#2E3440]] -- set color column color


-- smart case search
vim.opt.smartcase = true
-- Set other options as needed
vim.o.ignorecase = true
vim.o.incsearch = true


-- Editing

-- tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
--
vim.opt.wrap = false -- don't wrap lines
vim.opt.swapfile = false -- don't create swap files
vim.opt.hlsearch = true -- highlight search results 
vim.opt.completeopt = {"menuone", "noinsert"} -- set completion options (autocomplete: show menu but don't insert)
vim.opt.list = true -- show whitespace characters
vim.opt.listchars:append("trail:•") -- show trailing whitespace as •

vim.g.nvim_tree_hide_dotfiles = 0 -- show dotfiles in nvim-tree
vim.g.mapleader = " " -- set leader key to space

--------------------
-- Plugins
--------------------

local Plug = require 'user-custom.vimplug'

Plug.begin('~/.config/nvim/plugged')

Plug 'folke/tokyonight.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'

Plug.ends()

--------------------
-- Plugins Config
--------------------

vim.cmd [[colorscheme tokyonight]] -- set colorscheme to tokyonight
require('plugin-configs.barbar') -- barbar config
require('plugin-configs.lspconfig') -- lspconfig config
require('plugin-configs.telescope') -- telescope config
require('plugin-configs.tree') -- nvim-tree config

--------------------
-- Mappings
--------------------
-- Map <C-s> to toggle NvimTree
vim.api.nvim_set_keymap('n', '<leader>1', ':NvimTreeToggle<CR>', {
    noremap = true,
    silent = true
})
