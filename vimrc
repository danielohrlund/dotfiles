" vim config

" Requires vim-plug:
" `mkdir -p ~/.vim/autoload`
" `curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
"
" `mkdir -p ~/.vim/undodir` for persistent undo.

" Enable plugins
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

if !has("nvim")
    " Sensible defaults
    Plug 'tpope/vim-sensible'
endif
" Git integration
Plug 'tpope/vim-fugitive'
" Nice theme
Plug 'altercation/vim-colors-solarized'
" Better navigation
Plug 'kien/ctrlp.vim'
" Better naviagtion
Plug 'tomtom/tcomment_vim'
" if v:version >= 703
"     " Autocomplete
"     Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
" endif
" Syntax checks
Plug 'benekastah/neomake'
" Class outlines
Plug 'majutsushi/tagbar'
if v:version >= 703
    " Better line numbering
    Plug 'myusuf3/numbers.vim'
endif
" Faster editing
Plug 'terryma/vim-multiple-cursors'
" Nicer statusline
Plug 'bling/vim-airline'
" Better undo
Plug 'mbbill/undotree'
" " Autocomplete for neovim
" Plug 'Shougo/deoplete.nvim'
" " Autocomplete
" Plug 'Shougo/neocomplete.vim'
" Better than grep
Plug 'rking/ag.vim'
" Better C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" Colorful parentheses
Plug 'kien/rainbow_parentheses.vim'
" Plug 'klen/python-mode'
" Autocomplete for haskell
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" " Nicer Haskell
" Plug 'bitc/vim-hdevtools'
" Nicer Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
" Better S-expression editing
Plug 'vim-scripts/paredit.vim', { 'for': ['clojure', 'scheme'] }
" Clojure syntax
" Plug 'vim-clojure-static', { 'for': ['clojure'] }
" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

Plug 'edkolev/tmuxline.vim'
" Better JavaScript syntax
Plug 'jelera/vim-javascript-syntax'
" Better JavaScript indent
Plug 'jason0x43/vim-js-indent'
" Syntax for JS frameworks
Plug 'othree/javascript-libraries-syntax.vim'
" Editorconig
Plug 'editorconfig/editorconfig-vim'

Plug 'elubow/cql-vim'

Plug 'tpope/vim-fireplace'

" Aligning things
Plug 'junegunn/vim-easy-align'

call plug#end()

let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

filetype plugin indent on

" General
set hlsearch
set smartcase
set viminfo='1000,<1000,s10,h,f1

" Text, tabs, indent
set expandtab
set shiftwidth=4
set tabstop=4
set linebreak
set smartindent
set wrap

" Enable persistent undo
if has('persistent_undo')
    set undodir=~/.vim/undodir
    set undofile
    set undoreload=10000
endif
set undolevels=1000

" Enable mouse
" if has("mouse")
"   set mouse=a
" endif

" Use system clipboard
set clipboard+=unnamed

" Airline
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Theme
syntax enable
set background=dark
let g:solarized_visibility = "high"
colorscheme solarized

" Neomake
autocmd! BufWritePost * Neomake
let g:syntastic_check_on_open=1

" Line numbers
set number

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
" Keep from overriding syntax checker
let g:ycm_register_as_syntastic_checker = 0

" Use Syntastic linting in Python
let g:pymode_lint = 0

" " Remember cursor position
" autocmd BufReadPost *
" \ if ! exists("g:leave_my_cursor_position_alone") |
" \ if line("'\"") > 0 && line ("'\"") <= line("$") |
" \ exe "normal g'\"" |
" \ endif |
" \ endif

" No folding
autocmd Syntax c,cpp,python normal zR

" Always enable editing (useful in vimdiff)
set noreadonly

" Align new rows with parentheses
autocmd Syntax c,cpp set cino=(0

autocmd Syntax clojure set colorcolumn=80
autocmd Syntax scala set colorcolumn=80
autocmd Syntax gitcommit set colorcolumn=50,72

" Save file using sudo
command Sudow w !sudo tee > /dev/null %

" Save/quit even when holding shift
command W w
command Q q
command WQ wq
command Wq wq

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Mark unwanted whitespace
set list
autocmd Syntax make,gitcommit set nolist

" delimit specific line width
autocmd Syntax c,cpp set colorcolumn=120
autocmd Syntax python set colorcolumn=80

" Clear search highlight.
nnoremap <silent> <c-i> :nohlsearch<CR><c-i>

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Clean up trailing whitespace.
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Format whole file.
nmap _= :call Preserve("normal gg=G")<CR>

" Enable rainbow parentheses for all buffers
au VimEnter * RainbowParenthesesActivate
au BufEnter * RainbowParenthesesLoadRound
au BufEnter * RainbowParenthesesLoadSquare
au BufEnter * RainbowParenthesesLoadBraces

" better C-t
nnoremap <C-t> :FZF<CR>

" space to find buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <space> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" C-s to find in buffers
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

nnoremap <silent> <C-s> :FZFLines<CR>

" Tmuxline config
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'x'    : '#(date)',
      \'z'    : '#H'}

let g:neomake_open_list = 2

let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^fact']
let g:clojure_align_subforms = 1
let g:clojure_syntax_keywords = {
    \   'clojureDefine': ['schema.core/defn', 'schema.core/def', 's/defn', 's/def']
    \ }

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Easy align
xmap ga <Plug>(EasyAlign)

nmap ga <Plug>(EasyAlign)
