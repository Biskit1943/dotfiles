" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/gnupg.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'
Plug 'ryanoasis/vim-devicons'
" Initialize plugin system
call plug#end()


let mapleader="\<SPACE>"
" Use ; for commands.
nnoremap ; :
" Use Q to execute default register.
nnoremap Q @q

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set nostartofline       " Do not jump to first character with page commands.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set termguicolors

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
    set scrolloff=5     " Show next 3 lines while scrolling.
endif

if !&sidescrolloff
    set sidescrolloff=8 " Show next 5 columns while side-scrolling.
endif

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\|\t/

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Nerdtree
autocmd StdinReadPre * let s:std_in=1
" Open nerdtree if no file specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open nerdtree on directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim when the last open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>
"Switch between different windows by their direction`
no <C-j> <C-w>j| "switching to below window
no <C-k> <C-w>k| "switching to above window
no <C-l> <C-w>l| "switching to right window
no <C-h> <C-w>h| "switching to left window

" Lightline
set background=dark
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'
"let g:airline_left_sep = ' '
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = '|'
let g:airline_theme= 'base16'

" Language server
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Theme
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default-dark

" Borrowed from https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" Fits well for dark schemes
let g:colors = {
      \ 'brown': ["#905532", 95],
      \ 'aqua': ["#3AFFDB", 86],
      \ 'blue': ["#689FB6", 73],
      \ 'darkBlue': ["#44788E", 66],
      \ 'purple': ["#834F79", 93],
      \ 'red': ["#AE403F", 131],
      \ 'darkRed': ["#97050C", 88],
      \ 'beige': ["#F5C06F", 215],
      \ 'yellow': ["#F09F17", 214],
      \ 'orange': ["#D4843E", 172],
      \ 'orange2': ["#DD5E1C", 166],
      \ 'darkOrange': ["#F16529", 202],
      \ 'pink': ["#CB6F6F", 167],
      \ 'lightGreen': ["#8FAA54", 107],
      \ 'green': ["#31B53E", 71],
      \ 'white': ["#FFFFFF", 231],
      \}

"
" vim-devicons
"

" Do not show brackets around icons in NERDTree
let g:webdevicons_conceal_nerdtree_brackets = 1

" Do not put extra whitespace before icon
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''

" Do not overwrite airline.section_y with custom fileformat indicator
" BUG: unfortunately, vim-devicons overrites section instead of appending
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Show icons for directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Use different icons for opened and closed folder
let g:DevIconsEnableFoldersOpenClose = 1

" Colorize devicons
let g:devicons_colors = {
      \ 'brown': ['', '', ''],
      \ 'aqua': [''],
      \ 'blue': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'purple': ['', '', '', '', '', '', ''],
      \ 'red': ['', '', '', '', '', ''],
      \ 'beige': ['', '', '', ''],
      \ 'yellow': ['', 'λ', ''],
      \ 'orange': ['', '', ''],
      \ 'darkOrange': ['', '', '', ''],
      \ 'pink': ['', ''],
      \ 'green': ['', '', '', '', '', '', '', '', ''],
      \ 'white': ['', '', '', '', ''],
      \ }
augroup aug_vim_devicons
  au!

  " Apply devicons coloring only for NERDtree buffer
  for color in keys(g:devicons_colors)
    exec 'autocmd FileType nerdtree syntax match devicons_' . color . ' /\v' . join(g:devicons_colors[color], '.|') . './ containedin=ALL'
    exec 'autocmd FileType nerdtree highlight devicons_' . color . ' guifg=' .g:colors[color][0] . ' ctermfg=' . g:colors[color][1]
  endfor
augroup END
