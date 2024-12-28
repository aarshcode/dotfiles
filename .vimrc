" ====================================
"    Encoding & Compatibility
" ====================================

" Set UTF-8 as the default encoding
set encoding=utf-8

" Switch off Vi compatibility mode
set nocompatible

" ====================================
"    Basic Settings
" ====================================
" Use 'retrobox' color scheme
" colorscheme desert
" colorscheme slate
colorscheme retrobox

" Enable cursorline for current line highlight
set cursorline

" Enable command-line completion menu
set wildmenu

" Show the ruler (line/column number in the statusline)
set ruler

" Scroll settings to keep context
set scrolloff=3
set sidescrolloff=5

" Ask for confirmation when quitting or making changes
set confirm

" Always show line and column numbers in statusline
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Enable line break at word boundaries
set linebreak

" Show the current vim command in use
set showcmd

" This will keep showing the current command until a new command is entered
augroup ShowCommand
  autocmd!
  autocmd CmdlineChanged * redrawstatus
augroup END

" ====================================
"    Mouse & Interface
" ====================================

" Enable mouse support for all modes
set mouse=a

" Enable filetype-specific plugins and indentation
filetype plugin indent on

" ====================================
"    Indentation & Tabs
" ====================================

" Set the width of a tab character
set tabstop=4

" Set indentation width for shift commands
set shiftwidth=2

" Use spaces instead of tabs for indentation
set expandtab

" ====================================
"    Syntax and Highlighting
" ====================================

" Enable syntax highlighting
syntax on

" Disable Vim's startup message
set shortmess+=I

" ====================================
"    Line Numbers & Status Line
" ====================================

" Show absolute line numbers
set number

" Show relative line numbers in normal mode
set relativenumber

" Always show statusline, even with one window
set laststatus=2

" ====================================
"    Search Settings
" ====================================

" Case-insensitive search, but case-sensitive if uppercase is used
set ignorecase
set smartcase

" Incremental search (search as you type)
set incsearch

" ====================================
"    Backspace & Buffer Settings
" ====================================

" Make backspace work more intuitively
set backspace=indent,eol,start

" Allow hiding buffers with unsaved changes
set hidden

" Use same register for clipboard and for vim copy paste
set clipboard=unnamed

" ====================================
"    Key Mappings & Shortcuts
" ====================================

" Disable 'Q' key mapping in normal mode (Ex mode)
nmap Q <Nop>

" Disable the audible bell (visual bell instead)
set noerrorbells visualbell t_vb=

" Prevent usage of arrow keys for movement
" In normal mode
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

" In insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Enable quick buffer switching
map <C-K> :bprev<CR>
map <C-J> :bnext<CR>


