set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nohlsearch
set cursorline
set colorcolumn=80
set signcolumn=yes
set scrolloff=8
set termguicolors
set completeopt=menuone,noinsert
set list listchars+=trail:*
highlight ColorColumn ctermbg=235 guibg=#2E3440

let g:nvim_tree_hide_dotfiles = 0
let mapleader = "\\"

"""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
" Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'
call plug#end()


""""""""""""""""""""""""
" LUA
""""""""""""""""""""""""
lua require("plugin_configs.lspconfig")

"""""""""""""""""""""""""
" THEME
"""""""""""""""""""""""""
" colorscheme gruvbox
colorscheme tokyonight

""""""""""""""""""""""""
" TREE
""""""""""""""""""""""""
lua require("plugin_configs.tree")

""""""""""""""""""""""""
" TELESCOPE
""""""""""""""""""""""""
lua require("plugin_configs.telescope")


""""""""""""""""""""""""
" BARBAR
""""""""""""""""""""""""
lua require("plugin_configs.barbar")

""""""""""""""""""""""""
" KEYBINDINGS
""""""""""""""""""""""""

nnoremap <C-s> :NvimTreeToggle<CR>
nnoremap <C-t> :Telescope<CR>
