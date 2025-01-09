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
" set ruler

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
" augroup ShowCommand
"   autocmd!
"   autocmd CmdlineChanged * redrawstatus
" augroup END

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
set shiftwidth=4

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


" Map F5 to compile and run the current Java file
nnoremap <F5> :w<CR>:!javac % && java %:r<CR>



" Swp file path
set directory=$HOME/.vim/swp//

call plug#begin()

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'

call plug#end()

lua << EOF
require("nvim-autopairs").setup {}
EOF

lua << EOF

local lspconfig = require('lspconfig')

-- Determine the workspace folder for your project
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. "/.workspace/" .. project_name

-- Configure jdtls
lspconfig.jdtls.setup {
    cmd = {
        'jdtls',
        '-data', workspace_dir
    },
    root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = home .. '/.config/nvim/eclipse-java-google-style.xml',
                    profile = "GoogleStyle",
                },
            },
        },
    },
    init_options = {
        bundles = {}, -- Add paths to debug bundles here if needed
    },
}


local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- General LSP actions
  buf_map('n', 'gd', vim.lsp.buf.definition)         -- Go to definition
  buf_map('n', 'gD', vim.lsp.buf.declaration)        -- Go to declaration
  buf_map('n', 'gi', vim.lsp.buf.implementation)     -- Go to implementation
  buf_map('n', 'gr', vim.lsp.buf.references)         -- List references
  buf_map('n', 'K', vim.lsp.buf.hover)               -- Show hover documentation
  buf_map('n', '<C-k>', vim.lsp.buf.signature_help)  -- Show signature help
  buf_map('n', '<leader>rn', vim.lsp.buf.rename)     -- Rename symbol
  buf_map('n', '<leader>ca', vim.lsp.buf.code_action) -- Show code actions
  buf_map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end) -- Format code

  -- Diagnostics
  buf_map('n', '[d', vim.diagnostic.goto_prev)       -- Go to previous diagnostic
  buf_map('n', ']d', vim.diagnostic.goto_next)       -- Go to next diagnostic
  buf_map('n', '<leader>e', vim.diagnostic.open_float) -- Show diagnostics in a floating window
  buf_map('n', '<leader>q', vim.diagnostic.setloclist) -- Add diagnostics to the location list

  -- Workspace management
  buf_map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)    -- Add workspace folder
  buf_map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder) -- Remove workspace folder
  buf_map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end) -- List workspace folders
end

-- Attach the `on_attach` function to your LSP setup
require('lspconfig').jdtls.setup {
  on_attach = on_attach,
}


vim.diagnostic.config({
  virtual_text = true,  -- Show inline diagnostics
  signs = true,         -- Show signs in the gutter
  underline = true,     -- Underline problematic code
  update_in_insert = false, -- Update diagnostics while typing in insert mode
  severity_sort = true, -- Sort diagnostics by severity
})

EOF
