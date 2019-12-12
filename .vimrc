if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	    " Use Vim defaults (much better!)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set autoindent		    " always set autoindenting on
set smartindent         " always set smartindenting on
set number              " always show the number of each line
set cursorline          " always show current line highlight
set showmatch           " keep show process of match
set tabstop=4           " 
set shiftwidth=4        " 
set softtabstop=4       " 
" set backup		    " keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than 50 lines of registers
set history=50		    " keep 50 lines of command line history
set ruler		        " show the cursor position all the time

" set the untime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" keep plugin commands between vundle#begin/end
call vundle#begin()

" let Vundle manage Vundle,required
Plugin 'VundleVim/Vundle.vim'

" Python,on the other hand,requires indentation to indicate a code block
Plugin 'Yggdroot/indentLine'

" tree-type content not work
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_focus_on_files = 1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" o 打开关闭文件或目录
" e 以文件管理的方式打开选中的目录
" t 在标签页中打开
" T 在标签页中打开，但光标仍然留在 NERDTree
" r 刷新光标所在的目录
" R 刷新当前根路径
" X 收起所有目录
" p 小写，跳转到光标所在的上一级路径
" P 大写，跳转到当前根路径
" J 到第一个节点
" K 到最后一个节点
" I 显示隐藏文件
" m 显示文件操作菜单
" C 将根路径设置为光标所在的目录
" u 设置上级目录为根路径
" ctrl + w + w 光标自动在左右侧窗口切换
" ctrl + w + r 移动当前窗口的布局位置
" :tabc 关闭当前的 tab
" :tabo   关闭所有其他的 tab
" :tabp   前一个 tab
" :tabn   后一个 tab
" gT      前一个 tab
" gt      后一个 tab

" complete parentheses and quotes automatically
Plugin 'jiangmiao/auto-pairs'

" help you read the most complex code in the world by 
" highlighting different levels of parentheses in different colors
Plugin 'luochen1990/rainbow'	
let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle

" a light and configurable statusline/tabline plugin
Plugin 'itchyny/lightline.vim'
" easy configure color
set laststatus=2

if !has('gui_running')
set t_Co=256
endif

" colorscheme configuration
let g:lightline = {
	\ 'component_function':{
	\	'readonly':'LightlineReadonly',
	\},
	\}

function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

call vundle#end()

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
