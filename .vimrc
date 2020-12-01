scriptencoding utf-8
" ^^ this should always be the first line

au ColorScheme * hi TabLine     ctermbg=239 ctermfg=white
au ColorScheme * hi TabLineFill ctermbg=239

filetype plugin indent on
syntax on
set nocompatible               " start with Vim defaults
set backspace=indent,eol,start " allow backspacing over lots of stuff
set autoindent                 " autoindent is good
set noet ts=4 sw=4             " tab size and stuff
set ruler                      " show the cursor position all the time
set wildmenu                   " show list of options ("Android style") when tab-completing in vim commands
set modeline                   " first and last 5 lines of files for vim commands e.g. /* vim: tw=60 ts=2 */
set viminfo='20,\"500          " keep .viminfo file
set mouse=a
set nobackup writebackup noswapfile
set ignorecase noincsearch nohlsearch " default search options

set t_Co=256

colorscheme xoria256

"au ColorScheme * hi TabLine      ctermfg=White  ctermbg=Black
"au ColorScheme * hi TabLineSel   ctermfg=Black  ctermbg=White
"au ColorScheme * hi TabLineFill  ctermfg=White  ctermbg=Black

" highlight BOL and EOL whitespace, and whitespace errors in a friendly helpful way  :)
au Syntax * syn match Error /\v\t +/ containedin=ALL | syn match Error /\v +\t/ containedin=ALL
au Syntax * syn match spacefooBOL /\v^ +/ containedin=ALL
au Syntax * syn match whitespaceEOL /\v\s+$/ containedin=ALLBUT,spacefooBOL

" color chart : http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
au BufEnter * highlight whitespaceEOL ctermbg=Red guibg=Red
au BufEnter * highlight spacefooBOL ctermbg=233 guibg=#121212
au BufEnter * highlight NonText ctermfg=237
au BufEnter * highlight SpecialKey ctermfg=237

" show tabs even cooler!
if has('multi_byte')
	" › » ⟫ ≻ ⦒ ⊢ → ― ⊩ ⋅ ⋯ ▸ ▹ ↲ ↩ ¬
	set list listchars=tab:⦒―,nbsp:⋯,extends:▸
else
	set list listchars=tab:>-,nbsp:~,extends:>
endif

" try for transparent background!
hi Normal ctermbg=none

" highlight the 81st column
set colorcolumn=81
hi ColorColumn ctermbg=233

" reverse line ordering
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl
command W w

" cut, copy, paste
map <C-c> "+yy
map <C-v> "+p
map <C-x> "+dd
imap <C-c> <esc>"+yya
imap <C-v> <esc>"+pa
imap <C-x> <esc>"+dda
vmap <C-c> "+y
vmap <C-v> d"+P
vmap <C-x> "+d

" ctrl+w needs to work in insert mode
imap <C-w><C-w> <esc><C-w><C-w>a

" ctrl-p for pasting to a new line
nnoremap <C-p> o<Space><BS><Esc>p
nnoremap <C-P> O<Space><BS><Esc>p

" Auto-complete on Ctrl+Space
inoremap <C-@> <C-P>
inoremap <C-Space> <C-P>

" use Ctrl+T plus arrow to change tabs: up = first, down = last, left = previous, right = next
" this is useful in situations where ctrl+pgup and pgdown are taken by the WM
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" move screen down (Ctrl+e) and up (Ctrl+y)
inoremap <C-e> <Esc><C-e>i
inoremap <C-y> <Esc><C-y>i

" configure a few things for NERDTree (directory browsing plugin)
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 25 " default is 31

" also, any filetype that turns on a specific textwidth should be overwritten immidiately, because it's freaking annoying
autocmd FileType * setlocal textwidth=0

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
			\ if ! exists("g:leave_my_cursor_position_alone") |
			\     if line("'\"") > 0 && line ("'\"") <= line("$") |
			\         exe "normal g'\"" |
			\     endif |
			\ endif

" get a fancy titlebar string
autocmd BufEnter * let &titlestring = $USER . "@" . hostname() . " - " . expand("%:h") . " - " . expand("%:t")

" setup a title in screen and any variation of an xterm
if &term == "screen" || &term =~ "^xterm.*"
	set t_ts=]0;
	set t_fs=
	set title
endif

" version 7.0 is where they added numberwidth, which defaults to 8 in 6.0 with no way to change it, so it's ugly.
if version >= 700
	set number numberwidth=4
	set spelllang=en
	" always show the tabline
	set showtabline=2
	set tabpagemax=100
endif

" CTRL-L to run parser (syntax) check
au FileType c noremap <C-L> :!gcc -fsyntax-only %<CR>
au FileType cpp noremap <C-L> :!g++ -fsyntax-only %<CR>
au FileType go noremap <C-L> :!gofmt -d -e -s %<CR>
au FileType markdown noremap <C-L> :!markdown %<CR>
au FileType php noremap <C-L> :!php -l %<CR>
au FileType scss.css noremap <C-L> :!sass --no-cache --check %<CR>
au FileType sh noremap <C-L> :!sh -n %<CR>

" enable spell checking automatically for certain file types
au FileType markdown set spell
au FileType gitcommit set spell
au BufEnter *MSG set spell

" enable folding for a few file types, but unfold everything by default
set foldmethod=syntax
set foldlevelstart=99
let php_folding=1
let g:sh_fold_enabled=7
let g:vimsyn_folding='af'
let g:xml_syntax_folding=1

" the javascript formatting we've added has labels highlighted the same as keywords like "return" which makes it harder to spot errors, so this makes it match Perl's highlighting instead and do them as strings (which is more technically correct)
hi link javaScriptLabel String

" syntax highlighing
let &rtp .= ',' . '/usr/lib/go/misc/vim'
au! BufRead,BufNewFile *.phm set filetype=php " PHP Hypertext Model
au! BufRead,BufNewFile *.pht set filetype=php " PHP Hypertext Template
au! BufRead,BufNewFile *.phc set filetype=php " PHP Hypertext Controller
au! BufRead,BufNewFile *.scad set filetype=openscad
au! BufRead,BufNewFile *.jscad set filetype=javascript

" toggle cursorline with Ctrl+M
noremap <silent> <C-M> :set cursorline!<CR>
