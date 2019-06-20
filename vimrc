set nocompatible                  " be iMproved

" ======== plugin manager -- I guess this changes yearly now==========

" install plugin manager of the week if fresh system
let iCanHazPlugins=1
let plug=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug)
  echon "Right now you thanks previous you..."
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let iCanHazPlugins=0
endif

call plug#begin('~/.vim/plugged')

"" Plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'valloric/youcompleteme'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline-themes'
Plug 'godoctor/godoctor.vim'
Plug 'benekastah/neomake'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" langs
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go'
Plug 'wting/rust.vim'
Plug 'stephpy/vim-yaml'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-markdown'

" colors
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-wombat-scheme'

call plug#end()             " required
filetype plugin indent on   " required

"install above bundles if fresh system
if iCanHazPlugins == 0
  echo "Installing yo shit, please ignore key map error messages"
  echo ""
  :PlugInstall
endif

set encoding=utf-8                "b/c Pike won

set number                        "Line numbers within relative
set relativenumber                "awesome-sauce
set backspace=indent,eol,start    "it's 2014 we can use backspace meow
set history=1000                  "know your history
set showcmd                       "show incomplete commands
set showmode                      "show current mode
set visualbell                    "stop yelling at me
set autoread                      "reload files changed outside vim
set t_Co=256                      "why god?
set term=xterm-256color           "colors
set re=1                          "rubys were slow :(
set ttyfast                       "speeds
set lazyredraw                    "rabbits
set noswapfile                    "yes I made those changes
set nobackup                      "no I don't need 7 trillion copies
set nowb                          "stop yelling at me

if executable('/usr/bin/ruby')
  let g:ruby_path="/usr/bin/ruby"   "ruby is bad and should feel bad
endif

" remappings
let mapleader=","                  "remap leader to ,
set pastetoggle=<F2>               "quit indenting yo shit
noremap <silent> <leader>l :noh<CR> 
noremap <silent> <leader>d :bd<CR>

"" splits                          "only you can prevent emacs pinky
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-=> <C-W>=

set splitbelow                    "naturally go right and down
set splitright
set diffopt+=vertical             "always use vertical diffs

"" ====== Search Settings ======

set incsearch                     "get next match while typing
set hlsearch                      "highlighting
set viminfo='100,f1               "save 100 marks, caps

"" ====== Indentation =====

set autoindent                    "why would you not want this? masochist!
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2                     "because 2 spaces is objectively the best
set expandtab

augroup vimrcEx
  autocmd!

  "" When editing a file, always jump to the last known cursor position.
  "" Don't do it for commit messages, when the position is invalid, or when
  "" inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
	\ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

  "" Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  "" For all text files set 'textwidth' to 78 characters.
  autocmd FileType text,markdown,gitcommit setlocal textwidth=78

  "" Enable spellchecking for Markdown
  autocmd FileType text,markdown,gitcommit setlocal spell

  "" neomake
  autocmd! BufWritePost * Neomake!
augroup END

set nowrap                          " let a line be a line
set linebreak                       " stahp

"" ====== Folding ==========
set foldmethod=indent               " too lazy to tag
au BufRead * normal zR

" ====== completion ======
set wildmode=list:longest  

" ====== scrolling ========
set scrolloff=8                       "keep a reasonable padding at edges
set sidescrolloff=15
set sidescroll=1

" ====== airline ==========
set laststatus=2                      "always display statusline in all windows
set noshowmode                        "hide default mode text
if ! has('gui_running')               "fix the slowness of powerline
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

let g:airline_theme = 'gruvbox'
let g:airline_section_x = ''                      "who cares if utf8?
let g:airline_section_y = '%{&filetype}'          "put ^ here
let g:airline#extensions#whitespace#enabled = 0   "shut up I have gofmt
let g:airline#extensions#hunks#enabled = 0        "wat

" ====== bufferline ===
let g:bufferline_echo = 0            "louuuuud noises

" ====== ag / ctrlp mods ========
if executable('ag')
  " use silver searcher for grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in CtrlP because ain't nobody got time fo dat
  let g:ctrlp_user_command = 'ag %s -l --nocolor --files-with-matches -g "" --ignore "vendor/" --ignore bundle/'

  "don't even have to leave to see new files!
  let g:ctrlp_use_caching = 0
endif

" ====== Vim-Note ======
let g:notes_directories = ['~/.notes']
let g:notes_suffix = '.md'
" let g:notes_list_bullets
" ====== Fugitive ======
set statusline+=%{FugitiveStatusline()}

" ====== NERDTree ======
map <F3> :NERDTreeToggle<CR>

" ====== GruvBox ======
let g:gruvbox_constrast_dark = 'hard'

" ====== Synstastic ======
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" ====== Theme ======
set list listchars=tab:»·,trail:·
set background=dark
colorscheme gruvbox
syntax on
" see through your computer's soul
"gitgutter color
hi clear SignColumn
" bg
hi Normal ctermbg=NONE guibg=NONE
" line numbers
hi CursorLineNr ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
" whack bg
hi NonText ctermbg=NONE guibg=NONE
" listchars (tab,EOL)
hi SpecialKey ctermbg=NONE guibg=NONE ctermfg=238 guifg=#444444

" =========== go stuffs ============
let g:neomake_go_enabled_makers = ['go']
let g:neomake_verbose=0

" nvim speed for escape
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
