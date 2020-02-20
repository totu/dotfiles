" trial stuff
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
Plugin 'junegunn/fzf.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'airblade/vim-gitgutter'
Plugin 'psliwka/vim-smoothie'
Plugin 'mtdl9/vim-log-highlighting'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'vim-scripts/scons.vim'
Plugin 'ekalinin/Dockerfile.vim.git'
Plugin 'yuki-ycino/fzf-preview.vim'
Plugin 'ryanoasis/vim-devicons'

" end vundle stuff
call vundle#end()            " required
filetype plugin indent on    " required

if (has("termguicolors"))
 set termguicolors
endif
if has("nvim")
  set inccommand=nosplit
endif


" why I suck section
abbrev spadde spade
abbrev Commetn Comment
abbrev Comemtn Comment

" Live edit preview
"set inccommand=nosplit

" Default settings stuff
set cot=menuone,longest,preview    " pop up completion <c-n> / <c-p>
set tags+=.git/tags
nnoremap <F3> :!ctags -Rf .git/tags --tag-relative --extra=+f --exclude=.git .<CR><CR>
nnoremap <c-g> <c-]>
au BufNewFile,BufRead *.rc set filetype=sh
au BufNewFile,BufRead dump set filetype=log
au BufNewFile,BufRead Jenkinsfile.* set filetype=Jenkinsfile
au BufNewFile,BufRead SConscript set filetype=scons
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
colorscheme gruvbox

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
nnoremap <leader>F :FzfPreviewProjectFiles<CR>
" There used to be normal find here, but now its gone
nnoremap <leader>f :FzfPreviewProjectFiles<CR>

" find usages
map <F2> <esc>:Gcd<CR>:call MarkStart()<CR>gvy:RG <C-R>"<cr>
" find definition (works only for robot kws)
map <F12> <esc>:Gcd<CR>:call MarkStart()<CR>gvy:RG ^<C-R>"<cr>

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
" clean critical_red.txt
nnoremap <leader>x :%!grep \\-\\-test<CR>:w<CR>:%!sort %<CR>:w<CR>
" open robot logs
nnoremap <leader>l :e tests/results/stdout.log<CR>
" run json lint from python on file
nnoremap <leader>j :%!python -m json.tool<CR>
" run robot tidy on file
nnoremap <leader>r :%!python -m robot.tidy %:p<CR>
" run python black on file
nnoremap <c-p> :!black %<cr><cr>

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
nnoremap <leader>e :enew<CR>
" show git blame (fugitive)
nnoremap <F10> :Gblame<CR>
" toggle fugitive marks (when large changes these lag)
nnoremap <F9> :GitGutterSignsToggle<CR>
autocmd BufWritePost * GitGutter

" more useful from ALE, also only when asked (or after save)
let g:ale_lint_on_enter = 1
let g:ale_python_flake8_executable = 'python3'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" config for the commenter plugin
autocmd FileType robot setlocal commentstring=#\ %s

" Best searching functions found thus far
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-case --follow --column --line-number --no-heading --color=always %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Map previous function to :RG
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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

" paste shit in ~/.reg.vim file
vmap <silent> ,y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.reg.vim<CR>
nmap <silent> ,y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.reg.vim<CR>
map <silent> ,p :sview ~/.reg.vim<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p
map <silent> ,P :sview ~/.reg.vim<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>P

" :Q to always exit
command! Q :qa!

" FZF in floating windows
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=20

  hi NormalFloat guibg=None
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
  endif

  " This is straigh up copy-and-paste from FzfPreview plugin.
  " It looks nice, but my search is 100x faster
  function! FloatingFZF()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:b_buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:b_buf, 0, -1, v:true, lines)
    call nvim_open_win(s:b_buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let s:f_buf = nvim_create_buf(v:false, v:true)
    call nvim_open_win(s:f_buf, v:true, opts)
    setlocal nocursorcolumn
    augroup fzf_preview_floating_window
      autocmd WinLeave <buffer> silent! execute 'bwipeout! ' . s:f_buf . ' ' . s:b_buf
    augroup END
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

" Bughunting and ops stuff, once you’ve gotten the hang of things. The only “new” info you ever learn about a
" production system is that it is broken or, even worse, that it is somehow managing to deliver value despite
" having the software equivalent of hyperdimensional aggressive bone cancer. Instead of merely not affording
" chances to learn or explore, this work actively punishes you for digging into the abyss.

