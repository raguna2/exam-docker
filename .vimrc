set number
syntax on
" set ruler
inoremap <silent> jj <ESC>
set scrolloff=5
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set list                " 不可視文字の可視化
set foldcolumn=4
set foldmethod=indent "(インデントで折りたたみを自動作成してくれる)
set tabstop=2
set softtabstop=4
set shiftwidth=2
set expandtab
set smarttab
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" vを二回で行末まで選択
vnoremap v $h
noremap j gj
noremap k gk
noremap w b
noremap b w

"yankの履歴を辿れるマッピング
" yankround.vim {{{
"" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"" 履歴取得数
let g:yankround_max_history =30
""履歴一覧(kien/ctrlp.vim)
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}
"shift+hで左端まで移動
noremap <S-h> ^
"shift+lで右端まで移動
noremap <S-l> $
"ノーマルモードで改行可能に
nnoremap <CR> A<CR><ESC>
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT
set visualbell t_vb=
set noerrorbells
set cursorline

"検索で現在カーソルの当たっている行を画面中央にくるようにスクロール
nmap n nzz
"前方向に検索の場合
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
"下記のおかげでクリップボードをコピペ可能に
set clipboard=unnamed,autoselect
""NERDTreeをctr+eで開けるようにする
"map <silent><C-e> <plug>NERDTreeToggle<CR>
map <silent><C-e> <plug>NERDTreeTabsToggle<CR>

"Pythonのシンタックスハイライトにいくつか追加する
if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save


"マウス操作が出来るようになる
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

if has('vim_starting')
   " 初回起動時のみruntimepathにneobundleのパスを指定する
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))
" インストールするプラグインをここに記述
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-surround'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/matchit.zip'
"コメントアウトめっさ楽にするやつ
NeoBundle 'tomtom/tcomment_vim'
let g:tcommentMapLeader1 = '<C-=>'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
" 行末の半角スペースを可視化　:FixWhitespaceで削除
NeoBundle 'bronson/vim-trailing-whitespace'
"自動でブラウザリロード
NeoBundle 'tell-k/vim-browsereload-mac'
"python等の言語の文法チェックを自動的にやってくれる
NeoBundle 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
"vim に非同期処理を提供してくれる
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
"括弧を自動的に閉じてくれるやつ
NeoBundle 'Townk/vim-autoclose'

"ifとかの終了宣言を自動で挿入してくれるやつ
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'open-browser.vim'
" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kien/ctrlp.vim'
call neobundle#end()
" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

" auto reload .vimrc自動でvimrcを再読込
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END