" vim: foldmethod=marker :
" {{{ Basic Config
"
set nocompatible

" Include pathogen
call pathogen#infect()
call pathogen#helptags()

" PIV PHP Folding
let g:DisableAutoPHPFolding = 1

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

let mapleader=','

" Whitespace stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list listchars=tab:▸\ ,eol:¬,trail:·
set noeol
set autoindent

"folding settings
set foldnestmax=1
set foldnestmax=5

" Enable formatting of comments, and one letter words.
" see :help fo-table
set formatoptions=qrc1

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Window settings
set wrap
set lbr
set textwidth=0
set cursorline

" Use modeline overrides
set modeline
set modelines=10

" Status bar
set laststatus=2
set statusline=%t\ %h%m%r%w\ [%{strlen(&ft)?&ft:'none'}\|%{&ff}\|%{strlen(&fenc)?&fenc:&enc}]%=[%l,%L,\ %c]

" Default color scheme
set guifont=Source\ Code\ Pro:h13
set background=light
let g:solarized_visibility='low'
let g:solarized_contrast='high'
color solarized

" Context-dependent cursor in the terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7""

" Swap files. Generally things are in version control
" don't use backupfiles either.
set noswapfile
set nobackup
set nowritebackup

" Persistent undos
if !&diff
  set undodir=~/.vim/backup
  set undofile
endif

" }}}

" {{{ Searching
"
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
nnoremap / /\v
vnoremap / /\v
set grepprg=ack\ --column
set grepformat=%f:%l:%c:%m

" Clear search highlighting
map <Leader><Space> :nohl<CR>

" }}}

" Spell checking. configure the language and turn off spell checking.
set spell spelllang=en_us
set nospell

" Use the system clipboard
set clipboard=unnamed

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*.pyc,node_modules/*

" Autoclose terminal compatibility
if !has('gui_running')
	let g:AutoClosePreservDotReg = 0
endif

" Get rid of side scrollbars
set guioptions-=L
set guioptions-=r

" Split explorer nerdtree
let NERDTreeHijackNetrw=1

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" {{{ Autocommands
"
" Save on blur
au FocusLost * :wa

" Save on blur for terminal vim
au CursorHold,CursorHoldI * silent! wa

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" }}}

" {{{ Filetypes
"
" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" make uses real tabs
au FileType make setl noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" Map .twig files as jinja templates
au BufRead,BufNewFile *.{twig}  set ft=htmljinja

" Map *.coffee to coffee type
au BufRead,BufNewFile *.coffee  set ft=coffee

" Highlight JSON like Javascript
au BufNewFile,BufRead *.json set ft=javascript

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setl softtabstop=4 shiftwidth=4 tabstop=4 textwidth=90 expandtab
au FileType rst setl textwidth=80

" Make ruby use 2 spaces for indentation.
au FileType ruby setl softtabstop=2 tabstop=2 expandtab

" PHP settings
au FileType php setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 noexpandtab

" Javascript settings
au FileType javascript setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 noexpandtab

" Coffeescript uses 2 spaces too.
au FileType coffee setl softtabstop=2 shiftwidth=2 tabstop=2 expandtab

" }}}

" {{{ Keybindings
"
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Remap j/k for long line situations
nmap j gj
nmap k gk

" Remap keys for split window ease of use.
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" TagBar
nmap <F8> :TagbarToggle<CR>

" Adjust viewports/splits to be the same size.
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

" Lazy save / save + exit
map <Leader>w :w<CR>
map <Leader>q :q<CR>

" I can't type, fix common mistakes.
cmap W<CR> w<CR>
cmap Wq<CR> wq<CR>
cmap Q<CR> q<CR>
cmap Qa<CR> qa<CR>

" Move to occurances
map <Leader>f [I:let nr = input("Which one:")<Bar>exe "normal " . nr . "[\t"<CR>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" }}}

" {{{ Custom commands
"

" XML Tidying
:command Txml :%!tidy -q -i -xml

" CTags
" Generate ctags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Go to the next tag.
map <C-\> :tnext<CR>

" CtrlP Ctags
nnoremap <Leader>. :CtrlPTag<CR>

" }}}

" {{{ Plugin config
"
" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" CtrlP
let g:ctrlp_extensions = ['tag']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'

" SaveSession 
let g:session_autosave = 'yes'

" Restore Windows & Folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$']
map <Leader>n :NERDTreeToggle<CR>

" Leader-/ to toggle comments
map <Leader>/ <plug>NERDCommenterToggle<CR>
imap <Leader>/ <Esc><plug>NERDCommenterToggle<CR>i

" RagTag
let g:ragtag_global_maps = 1

" Enable syntastic syntax checking
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_php_checkers=['php']

" Ack plugin
map <Leader>a :Ack<Space>

" Non Obtrusive JSHint
map <leader>jh :JSHintToggle<CR>

" cakephp snippets
:set ft=php.cakephp

" }}}

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1
