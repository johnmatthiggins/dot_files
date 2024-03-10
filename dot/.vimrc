runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

set background=dark
let &t_ut=''

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set incsearch		" Incremental search

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

command Dspace %s/\s\+$//e
set backspace=2
set shell=/bin/zsh

set number
set relativenumber

set autoindent
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set nowrap
set tags=.tags

set list
set listchars=eol:¬,tab:--

set nocompatible
filetype off

call plug#begin()

Plug 'bronson/vim-trailing-whitespace'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier'
Plug 'romgrk/doom-one.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

call plug#end()
filetype plugin indent on
filetype plugin on

let g:ctrlp_custom_ignore = '^(\.git|node_modules|venv)'
let g:NERDTreeShowHidden = 1

fun! FormatCode()
    const ext = expand('%:e')
    if ext == "svelte" || ext == "jsx" || ext == "js"
        echo "Running Prettier..."
        :Prettier
    elseif ext == "go"
        :! go fmt %
    else
        echo "File format not recognized..."
    endif
endfunction

nnoremap <C-f> :call FormatCode()<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-t> :tabnew<CR>

set termguicolors
colorscheme doom-one
