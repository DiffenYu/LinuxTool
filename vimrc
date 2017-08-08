" Install curl
" On CentOS
"    sudo yum install curl
" Clone Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'autoload_cscope.vim'
Plugin 'majutsushi/tagbar'
Plugin 'DoxygenToolkit.vim'
"Plugin 'c.vim'
"Plugin 'mbriggs/mark.vim'
"Plugin 'ShowMarks'
Plugin 'Conque-GDB'
Plugin 'kshenoy/vim-signature'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'aklt/plantuml-syntax'
"Plugin 'ShowTrailingWhitespace'
Plugin 'junegunn/fzf'

"Usage can refer to http://zuyunfei.com/2013/04/17/killer-plugin-of-vim-surround/"
Plugin 'tpope/vim-surround'

"Expended the '.' operation
Plugin 'tpope/vim-repeat'

Plugin 'raimondi/delimitmate'

Plugin 'tpope/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'chiel92/vim-autoformat'

"Plugin 'thinca/vim-quickrun'

"Switch between file *.c <-> *.h or file under curser, have limitation
"Plugin 'a.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'easymotion/vim-easymotion'
Plugin 'Valloric/YouCompleteMe'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'klen/python-mode'

" highlight CSS3
Plugin 'hail2u/vim-css3-syntax'
"Plugin 'rstacruz/vim-ultisnips-css'

" highlight HTML5
Plugin 'othree/html5.vim'

" Improved javaScript indentation and syntax support in Vim
Plugin 'pangloss/vim-javascript'
" lean & mean status/tabline for vim that's light as air
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes' "https://github.com/vim-airline/vim-airline/wiki/Screenshots Usage: ':Airline distinguished ':Airline dark'

"Plugin 'Valloric/YouCompleteMe'
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
" " To ignore plugin indent changes, instead use:
"filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Display line num
set nu
set ignorecase

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a m ap leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


" Fast saving
"nmap <leader>w :w!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
set t_Co=256
syntax on
syntax enable
set hlsearch

hi IncSearch            ctermfg=Black           ctermbg=DarkGrey
hi Search               ctermfg=Black           ctermbg=DarkGrey

colorscheme desert
"colorscheme murphy
"set background=dark
set nocompatible "disable some compatible with vi
set completeopt=preview,menu
"colorscheme default

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set showcmd

autocmd InsertLeave * se nocul
autocmd InsertLeave * se cul
set cursorline "highlight curent line
set magic "set magic effect
set ruler

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"indent all
map <F12> gg=G


"""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \Line:\ %l
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \Line:\ %l

""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""
"let g:airline_theme='base16'
"let g:airline_theme='badwolf'
let g:airline_theme='laederon'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MutiTab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Open new tab pane add alt as prefix
map <F4> :tabnew<CR>
"Close current tab pane
map <F6> :tabc<CR>
map <F2> :tabp<CR>
map <F3> :tabn<CR>
"Alt + num to switch tab pane
"can't work1gtgt
""map <A-1> 1gt
"map <A-2> 2gt
"map <A-3> 3gt
"map <A-4> 4gt
"map <A-5> 5gt
"map <A-6> 6gt
"map <A-7> 7gt
"map <A-8> 8gt
"map <A-9> 9gt
"map <A-0> :tablast<CR>
"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a NERDTree aumatically when vim starts up
"autocmd vimenter * NERDTree

"map a specific key or shortcut to open NERDTree
map <F8> :NERDTreeToggle<CR>

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDTreeDirArrows = 1

" NERDTress File highlighting
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction
"
"call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '/home/media/ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

""""""""""""""""""""""""""""""
" => cscope & ctags
""""""""""""""""""""""""""""""
set tags=tags;
set autochdir

nmap <C-_>w :!find ${PWD}/ -name "*.h" -o -name "*.c" -o -name "*.cpp" > ${PWD}/cscope.files; cscope -bkq -i ${PWD}/cscope.files; ctags -R;<CR><CR>

" Add any database in current directory
"Don't need to use code below due to the cscope.out will be automatically added by /etc/vimrc.
if filereadable("cscope.out")
        "cs add cscope.out
else
        "cs add /home/media/workspace/dingfeng/mediasdk/cscope.out
        "cs add /home/media/workspace/umd/Source/dxva/cscope.out
endif


":help cscope-suggestion

set cspc=1
"set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> "query the symbol
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR> "query definition
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> "query function call this funciton
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> "query character string
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> "query via egrep mode
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR> "query this file
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR> "query files include this file
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> "query functions called by this function

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

"nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one

"nmap <C-Space><C-Space>s
            "\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>g
            "\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>c
            "\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>t
            "\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>e
            "\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>i
            "\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space><C-Space>d
            "\:vert scs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conque-GDB
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Read below file to see the usage.
"vim ~/.vim/bundle/Conque-GDB/doc/conque_gdb.tx
"Simple example
":ConqueGdb ./ffmpeg_g
"set args xxx
"b main
"r
"let g:ConqueGdb_SrcSplit = 'left'
"let g:ConqueGdb_SrcSplit = 'below'
let g:ConqueGdb_SrcSplit = 'above'
let g:ConqueGdb_SaveHistory = 1
let g:ConqueGdb_Leader = ';'
nnoremap <silent> <leader>Y :ConqueGdbCommand y<CR>
nnoremap <silent> <leader>N :ConqueGdbCommand n<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set foldmethod=indent
set foldmethod=syntax
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-indent-guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto load begin with vim
let g:indent_guides_enable_on_vim_startup=1
" indent start from level 2
let g:indent_guides_start_level=2
" color block width
let g:indent_guides_guide_size=1
" quick key to open/close the indent guide
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F7> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ShowMarks setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1

" For showmakrs plugin
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
"map  <Leader>mt   - open/close ShowMarks plugin
"map  <Leader>mo   - enforce open ShowMarks plugin
"map  <Leader>mh   - clean the mark of current line
"map  <Leader>ma   - clean the marks of current buffer
"map  <Leader>mm   - mark the current line use next usable mark name



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quick run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:quickrun_config = {
            \   "_" : {
            \       "outputter" : "message",
            \   },
            \}

let g:quickrun_no_default_key_mappings = 1
"Usage :Q<Enter>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>tpope/vim-surround'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Normal mode
"-----------
"ds  - delete a surrounding
"cs  - change a surrounding
"ys  - add a surrounding
"yS  - add a surrounding and place the surrounded text on a new line + indent it
"yss - add a surrounding to the whole line
"ySs - add a surrounding to the whole line, place it on a new line + indent it
"ySS - same as ySs

"Visual mode
"-----------
"s   - in visual mode, add a surrounding
"S   - in visual mode, add a surrounding but place text on new line + indent it

"Insert mode
"-----------
"<CTRL-s> - in insert mode, add a surrounding
"<CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
"<CTRL-g>s - same as <CTRL-s>
"<CTRL-g>S - same as <CTRL-s><CTRL-s>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion/vim-easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" repeat the last operation, similar with the repeat plugin
map <Leader><leader>. <Plug>(easymotion-repeat)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a.vim (easy switch between src and head file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"This is a mirror of http://www.vim.org/scripts/script.php?script_id=31

"A few of quick commands to swtich between source files and header files quickly.

":A switches to the header file corresponding to the current file being edited (or vise versa)
":AS splits and switches
":AV vertical splits and switches
":AT new tab and switches
":AN cycles through matches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
":IHT new tab and switches
":IHN cycles through matches
"<Leader>ih switches to file under cursor
"<Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
"<Leader>ihn cycles through matches

"E.g. if you are editing foo.c and need to edit foo.h simply execute :A and you will be editting foo.h, to switch back to foo.c execute :A again.

"Can be configured to support a variety of languages. Builtin support for C, C++ and ADA95


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => markdown releated
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airblade/vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"jump to next hunk(change): ]c
"jump to previous hunk(change): [c
"stage the hunk with <Leader>hs or
"undo it with <Leader>hu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => aklt/plantuml-syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin 'ShowTrailingWhitespace'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"strip all trailing whitespace in the current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin 'c.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:C_MapLeader = ','
let g:C_MapLeader = '\'

"use __printf __aloge + SPACE to quick insert format line
iabbr __printf printf("[dingfeng][%s %s %d ]\n", __FUNCTION__, __FILE__, __LINE__);
iabbr __aloge ALOGE("[xxx][%s %d ]\n", __FUNCTION__, __LINE__);

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin 'Valloric/YouCompleteMe'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk


" Smart way to move between windows(seems C-h is not well in mobaxterm)
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

set mouse=a
nnoremap <leader>es :set mouse=a <CR>
nnoremap <leader>ds :set mouse=  <CR>
set selection=exclusive
set selectmode=mouse,key
set scrolloff=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :cn<CR>
map <leader>b :cp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => chiel92/vim-autoformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"func FormatCode(style)
    "let firstline=line(".")
    "let lastline=line(".")
    "" Visual mode
    "if exists(a:firstline)
        "firstline = a:firstline
        "lastline = a:lastline
    "endif
    "let g:formatdef_clangformat = "'clang-format --lines='.a:firstline.':'.a:lastline.' --assume-filename='.bufname('%').' -style=" . a:style . "'"
    "let formatcommand = ":" . firstline . "," . lastline . "Autoformat"
    "exec formatcommand
"endfunc
"clang-format for formating cpp code
nnoremap <leader>cf :call FormatCode("Chromium")<cr>
nnoremap <leader>lf :call FormatCode("LLVM")<cr>
vnoremap <leader>cf :call FormatCode("Chromium")<CR>
vnoremap <leader>lf :call FormatCode("LLVM")<cr>
let g:autoformat_verbosemode = 1

"if &diff
    "colorscheme default
    ""colorscheme murphy
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin 'DoxygenToolkit.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_briefTag_funcName = "no"

"for C++ style, change the '@' to '\'
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre =   "\\brief    "
let g:DoxygenToolkit_detailsTag_pre = "\\details  "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre =   "\\param    "
let g:DoxygenToolkit_returnTag =      "\\return   "
let g:DoxygenToolkit_throwTag_pre = "\\throw " " @exception is also valid
let g:DoxygenToolkit_fileTag = "\\file "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_versionTag = "\\version "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
"let g:DoxygenToolkit_authorName = "xxx@gmail.com"
let g:doxygen_enhanced_color = 1
"let g:load_doxygen_syntax = 1

"For mods project
let g:DoxygenToolkit_startCommentTag = "//! "
let g:DoxygenToolkit_interCommentTag = "//! "
