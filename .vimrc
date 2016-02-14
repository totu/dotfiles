set nowrap
execute pathogen#infect()
syntax enable
set number
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set cursorline
set showmatch
let python_highlight_all = 1
filetype indent on
set incsearch
set hlsearch

" theme
set t_Co=256
set background=dark

let mapleader=" "
nnoremap <leader><space> :nohlsearch<CR>

" scrolling
nnoremap J gjzz
nnoremap K gkzz
nnoremap j gj
nnoremap k gk
nnoremap G Gzz
nnoremap gg ggzz

" buffers
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
nnoremap <c-e> :enew<CR>
nnoremap <leader>e :enew<CR>

" pretty json
nnoremap <leader>j :%!python -m json.tool<CR>

" CtrlP
nnoremap <c-t> :CtrlP<CR>
let ctrlp_switch_buffer=0
let g:ctrlp_working_path=0

" Nerd
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <C-n> :NERDTreeToggle<CR>

" airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:airline_theme='solarized'
"colorscheme solarized


" White spaceja naamaan
autocmd BufWritePre * :%s/\s\+$//e

func! WordProcessorMode()
    setlocal formatoptions=1
    setlocal noexpandtab
    map j gj
    map k gk
"    setlocal spell spelllang=fi
    set complete+=s
    set formatprg=par
    setlocal wrap
    setlocal linebreak
    set nocursorline
endfu
com! WP call WordProcessorMode()

set updatetime=1000
let g:vimchant_spellcheck_lang = 'fi'
