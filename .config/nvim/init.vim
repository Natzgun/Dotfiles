" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath
" source ~/.vimrc

syntax enable
set mouse=a
set number
" set numberwidth=2
set clipboard=unnamed
set showcmd
set ruler
set encoding=UTF-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set ma
set noshowmode

" -----------------------------------------
" Plugins
"

call plug#begin()
" Themes
" Plug 'morhetz/gruvbox'
" Plug 'ellisonleao/gruvbox.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'EdenEast/nightfox.nvim' " nightFOx
" Plug 'folke/tokyonight.nvim'
Plug 'tiagovla/tokyodark.nvim' 
Plug 'Shatur/neovim-ayu'

Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons' " Developer Icons
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs' " Autopairs
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Syntax support
" Plug 'sheerun/vim-polyglot'
" Indent guides
Plug 'Yggdroot/indentLine'
Plug 'tribela/vim-transparent'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'mhinz/vim-startify'
Plug 'christoomey/vim-tmux-navigator'
" Copilot
" Plug 'github/copilot.vim'
" React
" Plug 'SirVer/ultisnips'
" Plug 'mlaursen/vim-react-snippets'

call plug#end()

so ~/.config/nvim/plug-config/treesitter.lua
" so ~/.config/nvim/plug-config/nightfox.lua

" colorscheme gruvbox-material
" let g:gruvbox_contrast_dark = "soft"
" let g:deoplete#enable_at_startup = 1
" let g:jsx_ext_required = 0

" Important!!
" if has('termguicolors')
"   set termguicolors
" endif

" For dark version.
set background=dark

" For light version.
" set background=light

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'medium'

 " For better performance
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

" -----------------------------------------
" Keymaps

let mapleader=" "

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" ToggleTerm
:tnoremap <Esc> <C-\><C-n> " Exit terminal mode
tnoremap <silent><A-1> <Cmd>exe v:count1 . "ToggleTerm direction=float direction=horizontal size=20"<CR>
tnoremap <silent><A-2> <Cmd>exe v:count1 . "ToggleTerm direction=float direction=vertical size=50"<CR>
tnoremap <silent><A-3> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
nnoremap <A-1> :ToggleTerm direction=horizontal size=10<cr>
nnoremap <A-2> :ToggleTerm direction=vertical size=40<cr>
nnoremap <A-3> :ToggleTerm direction=float<cr>

" Quit and Save
nnoremap <C-q> :q!<CR>
nnoremap <C-s> :w<CR>
" Easymotion
nmap <Leader>s <Plug>(easymotion-s2)
" NerdTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Split Navigation
map <C-v> <C-W>v
map <C-x> <C-W>s

" GoTo code navigation.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remap escape
nnoremap <C-c> <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap jj <Esc>
inoremap kk <Esc>

" -----------------------------------------
" Plugins-Config

" Startify
let g:startify_custom_header =
          \ 'startify#center(startify#fortune#cowsay())'
" ToggleTerm
lua require("toggleterm").setup()

" Coc
" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Seleccionar la sugestión con enter.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"  Tags rainbow
let g:rainbow_active = 1
