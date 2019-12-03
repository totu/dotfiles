" trial stuff
nnoremap <c-p> :!black %:p<cr><cr>
nnoremap <leader>rt <c-w>o0m70v$h"*y`7:delmarks 7<CR>:vs<CR>:term<CR>it -t "<C-\><C-n>pa" <C-\><C-n><c-w>h:let @"=expand("%:p")<cr><c-w>lpi<cr>
nnoremap <leader>rf <c-w>o:let @"=expand("%:p")<cr>:vs<CR>:term<CR>it <C-\><C-n>pi<cr>
tnoremap <Esc> <C-\><C-n>

"required Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" insert plugins
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mileszs/ack.vim'
Plugin 'w0rp/ale'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'morhetz/gruvbox'
Plugin 'wezm/fzf.vim', { 'branch': 'rg' }
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'airblade/vim-gitgutter'
Plugin 'psliwka/vim-smoothie'
Plugin 'mtdl9/vim-log-highlighting'

" end vundle stuff
call vundle#end()            " required
filetype plugin indent on    " required

if (has("termguicolors"))
 set termguicolors
endif

" why I suck section
abbrev spadde spade
abbrev Commetn Comment
abbrev Comemtn Comment

" Live edit preview
set inccommand=nosplit

" Default settings stuff
set cot=menuone,longest,preview    " pop up completion <c-n> / <c-p>
set tags+=.git/tags
nnoremap <F3> :!ctags -Rf .git/tags --tag-relative --extra=+f --exclude=.git .<CR><CR>
nnoremap <c-g> <c-]>
au BufNewFile,BufRead *.rc set filetype=sh
au BufNewFile,BufRead dump set filetype=log
au BufNewFile,BufRead qc set filetype=log
au BufNewFile,BufRead *.log.* set filetype=log
au BufNewFile,BufRead *.rjson set filetype=json
set t_Co=256
set virtualedit=block
set splitbelow splitright
set ignorecase
set encoding=utf-8
set mouse=a
set linespace=1
syntax on
set smartcase
set backspace=2
set tabstop=4
set shiftwidth=4
set hidden
set nowrap
set autoindent
set expandtab
set showmatch
set incsearch
"set background=dark
colorscheme gruvbox
if g:colors_name == "gruvbox"
highlight Normal ctermbg=0 guibg=0
"List other overrides here
endif

" yank filename
noremap <c-s> :let @"=expand("%:p")<cr>
noremap <c-d> :norm oResource<cr>:norm 10a <cr>pBd5f/<cr>

" vim-tmux-navigator config
let g:tmux_navigator_no_mappings = 1    " defaults suck ass
map <c-l> :TmuxNavigateRight<cr>
map <c-h> :TmuxNavigateLeft<cr>
map <c-k> :TmuxNavigateUp<cr>
map <c-j> :TmuxNavigateDown<cr>

" Set <leader> to space instead of ,
" maybe should be <space>?, but work for now
let mapleader=" "

" Write readonly as root
cmap w!! w !sudo tee % > /dev/null

" Make searching great again
set path+=**    " this makes :find work like actual search tool
set wildmenu    " also helps
set wildmode=longest,list
set wildignore+=*.pyc,*.pcapng
set rtp+=~/.fzf

" find for visual selection
vnoremap # y/<C-R>"<CR>

" double space to remove hilighting
nnoremap <leader><space> :nohlsearch<CR>

" Fuzzy find
nnoremap <leader>F :FZF<CR>
" There used to be normal find here, but now its gone
nnoremap <leader>f :FZF<CR>

" Shitty way of marking starting position and coming back from Robot definition
let s:orig = 0
function! MarkStart()
    if s:orig == 0
        let s:orig = 1
        normal mZ
    endif
endfunction

function! JumpBackToStart()
    let s:orig = 0
    normal 'Zzz
endfunction

" Find where robot keyword is defined
" Ag works fine for most part
map <F12> <esc>:Gcd<CR>:call MarkStart()<CR>gvy:Ag <C-R>"<cr>

" But sometimes if fucks up with symlinks, which is why Ack is here
map <F2> <esc>:Gcd<CR>:call MarkStart()<CR>gvy:Ack "^<C-R>""<cr>

" Back to where first search took place
map <leader>q :call JumpBackToStart()<CR>

" Copy current line to clip-board
nnoremap <C-Y> 0m70v$h"*y`7:delmarks 7<CR>

" Make copen menu act like a proper functional member
" of society and close after it is used
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> <Esc> :cclose<CR>

" buffers
map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
nmap <tab> :b#<CR>
nnoremap <leader>e :enew<CR>
nnoremap <leader>x :%!grep \\-\\-test<CR>:w<CR>:%!sort %<CR>:w<CR>
nnoremap <leader>l :e tests/results/stdout.log<CR>
nnoremap <leader>j :%!python -m json.tool<CR>
nnoremap <leader>r :%!python -m robot.tidy %:p<CR>

" row numbering switching shit
set relativenumber number
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber  number

" remove trailing whitespace on save
autocmd BufWritePre * call Preserve("%s/\\s\\+$//e")

" make ctrl+space insert 4 spaces
inoremap <C-Space> <Space><Space><Space><Space>

" in terminal sometimes ctrl+space isn't ctrl+space,
" but instead nul or ctrl-@ for some reason
inoremap <Nul> <Space><Space><Space><Space>
inoremap <C-@> <Space><Space><Space><Space>

" reload current file
nnoremap <leader><S-r> :e! %<CR>
nnoremap <F10> :Gblame<CR>
nnoremap <F9> :GitGutterSignsToggle<CR>

autocmd BufWritePost * GitGutter

" more useful from ALE, also only when asked
let g:ale_lint_on_enter = 1
let g:ale_python_flake8_executable = 'python3'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" config for the commenter plugin
autocmd FileType robot setlocal commentstring=#\ %s

" rg ''hack''
" no idea if this even does anything anymore
" I've also hacked stuff inside the FZF bundle
if executable('rg')
    " Use ag over grep
    let g:ackprg = 'rg -f --vimgrep --no-heading --ignore-case 2>/dev/null'
    set grepprg=rg\ -f\ --vimgrep\ --no-heading\ --ignore-case\ 2>/dev/null
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg -f --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
endif

" Execute a command while preserving cursor position and history.
function! Preserve(command)
    let _s=@/         " Save search history.
    let l = line('.') " Save current line.
    let c = col('.')  " Save current column.
    execute a:command
    let @/=_s         " Reset search history.
    call cursor(l, c) " Reset cursor position.
endfunction

" Reindent the file
nnoremap <Leader>= :call Preserve("normal gg=G")<CR>zz

" Try to stay 5 rows away from borders
set scrolloff=5

" :Q
command! Q :qa!

" Bughunting and ops stuff, once you’ve gotten the hang of things. The only “new” info you ever learn about a
" production system is that it is broken or, even worse, that it is somehow managing to deliver value despite
" having the software equivalent of hyperdimensional aggressive bone cancer. Instead of merely not affording
" chances to learn or explore, this work actively punishes you for digging into the abyss.

