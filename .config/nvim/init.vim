" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/gnupg.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-syntastic/syntastic'
Plug '~/.local/share/nvim/plugged/redact_pass'
" Initialize plugin system
call plug#end()


" Unbind space from everything except the mapleader
noremap <Space> <Nop>
let mapleader="\<Space>"
let maplocalleader="\<Space>"
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
"Visual character indicator
set colorcolumn=80

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

" Lightline
set background=dark
set noshowmode
let g:lightline = {'colorscheme': 'solarized'}

" UrilSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" vimtex
let g:vimtex_compiler_progname = 'nvr'
