syntax on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'file:///Users/gmarik/path/to/plugin'
"t@github.com:scrooloose/nerdtree.gitPlugin 'file:///home/gmarik/path/to/plugin'
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'vim-scripts/a.vim'
Plugin 'scrooloose/nerdcommenter'

" Track the engine.
"Plugin 'SirVer/ultisnips'
"  
"  " Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsSnippetsDir='/home/quan/.vim/bundle/vim-snippets/UltiSnips'
"let g:UltiSnipsSnippetDirectories=['UltiSnips']
"let g:UltiSnipsExpandTrigger = '<Tab>'
"let g:UltiSnipsListSnippets = '<C-Tab>'
"let g:UltiSnipsJumpForwardTrigger = '<Tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

"let g:UltiSnipsUsePythonVersion = 3  
"  " If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_global_ycm_extra_conf=‘/Users/quan/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py’
Plugin 'majutsushi/tagbar'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'mhinz/vim-signify'

let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1



call vundle#end()            " required

filetype off

filetype plugin indent on

let mapleader=";"

set nu

set hlsearch

"show the line of cursor"
set cursorline

"show bracket match"
set showmatch 

set tabstop=4

set shiftwidth=2

set autoindent

set et

map <F2> :call CallTaglistOrBar()<CR>
function! CallTaglistOrBar()
  nmap <F2> :TagbarToggle<CR>
  let g:tagbar_vertical = 10
  let g:tagbar_compact = 1
  let g:tagbar_autoshowtag = 1
  let g:tagbar_iconchars = ['▸', '▾']
  autocmd vimenter * Tagbar
  wincmd w
  autocmd VimEnter * wincmd w
endfunction

nmap <F9> :TagbarToggle<CR>

autocmd vimenter * NERDTree
wincmd w
autocmd VimEnter * wincmd w

"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
:nn <Leader>1 1gt
:nn <Leader>2 2gt
:nn <Leader>3 3gt
:nn <Leader>4 4gt
:nn <Leader>5 5gt
:nn <Leader>6 6gt
:nn <Leader>7 7gt
:nn <Leader>8 8gt
:nn <Leader>9 9gt
:nn <Leader>n gt
:nn <Leader>j gT
:nn <Leader>0: tablast<CR>

nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap tm :tabmove<CR>
nnoremap to :tabonly<CR>

map tt :NERDTreeToggle<CR>
map ff :NERDTreeFind<CR>

cs add cscope.out
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set csverb
    set cspc=3
    "add any database in current dir
    if filereadable("cscope.out")
        cs add cscope.out
    "else search cscope.out elsewhere
    else
       let cscope_file=findfile("cscope.out", ".;")
       let cscope_pre=matchstr(cscope_file, ".*/")
       if !empty(cscope_file) && filereadable(cscope_file)
           exe "cs add" cscope_file cscope_pre
       endif
     endif
endif


let g:NERDTreeWinSize = 38
set history=200
let &colorcolumn="80"
"source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
"set rtp +='/usr/local/bin/fzf'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
Plugin 'flazz/vim-colorschemes'
colorscheme molokai

"command! -bang -nargs=* Ag
  "\ call fzf#vim#ag(<q-args>,
  "\                 <bang>0 ? fzf#vim#with_preview('up:60%')
  "\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  "\                 <bang>0)
"nnoremap <silent> <Leader>A :Ag<CR>
"
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

set hls
set laststatus=2
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
