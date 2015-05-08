scriptencoding utf-8
set encoding=utf-8
set nocompatible " отключение режима совместимости с vi

let g:mapleader = "\<Space>" " по умолчанию это \

source ~/.vim/plugins.vim

" Main settings {{{
  set guifont=Ubuntu\ Mono\ 12
  set clipboard=unnamed,unnamedplus
  set number    " нумерация строк
  syntax enable " подсветка синтаксиса

  " Поддержка команд при включённой русской раскладке
  set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

  set lazyredraw                              " прирост производительности
  set backspace=indent,eol,start              " с чем будет работать клавиша backspace
  set virtualedit=onemore                     " возможность перемещения за конец строки
  set undolevels=5000                         " максимальное количество уровней отмены изменений
  set viminfo='1000,f1                        " сохранение глобальных меток
  set fileencodings=utf-8,cp1251,koi8-r,cp866 " приоритет подбора возможных кодировок файла
  set autoread                                " автоматически перезагружать файлы, изменённые извне
  set noswapfile                              " отключить своп-файлы
  set hidden                                  " сворачивать в буфер, вместо закрытия
  set shortmess+=I                            " отключить приветствие

  if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " удалять символ комментария при соединении двух закомментированных строк
  endif

  " загружать matchit.vim только если не установлена более новая версия
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  endif
" }}}
" gVim settings {{{
  if has("gui_running")       " если запущен gvim, то...
    winpos 0 0                " положение окна при запуске
    set guioptions-=T         " убрать панель инструментов
    set guioptions-=m         " убрать меню
    set guioptions-=l         " убрать левый скроллбар
    set guioptions-=L         " убрать левый скроллбар у сплита
    set guioptions-=r         " убрать правый скроллбар
    set guioptions-=R         " убрать правый скроллбар у сплита
    set guioptions-=e         " убрать GUI-табы
    set mousehide             " не показывать курсор во время печати
    set cursorline            " подсветка строки с курсором
    set linespace=0           " межстрочный интервал
    set guicursor=n:blinkon0  " отключить мигание курсора в нормальном режиме
  endif
" }}}
" Colorscheme {{{
  colorscheme jellybeans
  highlight SignColumn guibg=#0D0D0D ctermbg=233
  highlight SyntasticErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
  highlight SyntasticErrorLine guibg=#0D0D0D ctermbg=232
  highlight SyntasticWarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
  highlight SyntasticWargningLine guibg=#171717

  highlight ColorColumn ctermbg=52 guibg=#251515
  call matchadd('ColorColumn', '\%81v', 100)
" }}}
" Search {{{
set ignorecase      " игнорировать регистр при поиске
set incsearch       " перескакивать на найденный текст в процессе набора
set hlsearch        " подсвечивать найденное
set ignorecase      " игнорировать регистр букв при поиске
set smartcase       " включить умное распознование регистра
set gdefault        " включает флаг g в командах замены, типа :%s/a/b/
set showmatch

" Очистить подсветку поиска по нажатию <Esc><Esc>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
" }}}
" Indents and tabulation {{{
set expandtab     " замена таб-символов пробелами
set shiftwidth=2  " размер сдвига при нажатии << или >>
set softtabstop=2 " удаление tab-символов как пробелов
set tabstop=2
set nowrap
set nolinebreak
set tw=0          " отключение автопереноса длинных строк
set autoindent    " автоматический отступ
set smartindent   " включает умную расстановку отступов
set smarttab
set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×
set scrolloff=999 " держать курсор на определённом расстоянии от нижнего края
set list
" }}}
" Folding {{{1
set foldenable
set foldmethod=manual

" Toggle folding
nnoremap \ za
vnoremap \ za

nmap <leader>tf :call ToggleFolding()<CR>
function! ToggleFolding() " {{{
  if &fdc==1
    set fdc=0
  else
    set fdc=1
  endif
endfunction " }}}
" }}}1
" Wildmenu {{{
  set wildmenu    " включить меню выбора
  set wildcharm=<Tab>   " переключение элементов меню
  set wildmode=list:longest,full " отображать меню в виде полного списка

  " Файлы, которые будут игнорироваться в wildmenu
  if has("wildignore")
    set wildignore+=*.a,*.o,*.pyc
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=*.avi,*.mp4,*.mp3,*.ogg
    set wildignore+=*.zip,*.rar,*.tar,*.iso,*.7z,*.bz2
    set wildignore+=*.pdf,*.djvu,*.doc,*.odt,*.xsl,*.rtf
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
  endif
" }}}
" Key mappings {{{1
  nnoremap <Leader>vi :tabedit $MYVIMRC<CR>
  nnoremap <Leader>tl :set list! list?<CR>
  nnoremap <Leader>tt :set expandtab! expandtab?<CR>
  nnoremap <Leader>tp :set paste! paste?<CR>
  nnoremap <leader>w :w<CR>

  " Удалить все лишние пробелы в конце каждой строки
  nnoremap <Leader>dw :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G

  " Выделить весь текст
  noremap vA ggVG

  " Y копирует от курсора и до конца строки
  nnoremap Y y$

  " Если строка длинная и включён автоматический перенос то
  " перемещаемся на следующую/предыдущую псевдостроку с помощью j и k
  noremap j gj
  noremap k gk

  " Когда перемещаемся по результатам поиска, то держим их центре экрана
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz

  " Создаем пустой сплит относительно текущего
  nnoremap <Leader>sh :leftabove  vnew<CR>
  nnoremap <Leader>sl :rightbelow vnew<CR>
  nnoremap <Leader>sk :leftabove  new<CR>
  nnoremap <Leader>sj :rightbelow new<CR>
  nnoremap <Leader>ss :sp<CR> <c-w>j
  nnoremap <Leader>sv :vs<CR> <c-w>l
  nnoremap <Leader>sw <c-w>r
  nnoremap <Leader>sq :only<cr>

  " Открываем пустой сплит справа, если сплитов нет
  " если сплит есть, то перемещаемся на него
  nnoremap <silent><Tab> :call MoveOrOpenSplit()<CR>
  function! MoveOrOpenSplit() " {{{
    let curNr = winnr()
    wincmd w
    if winnr() == curNr
      exe 'vsplit'
      wincmd w
    endif
  endfunction " }}}

  nnoremap <silent> Q :call CloseSplitOrDeleteBuffer()<CR>
  nnoremap <silent> Й :call CloseSplitOrDeleteBuffer()<CR>
  function! CloseSplitOrDeleteBuffer() " {{{
    let curNr = winnr()
    let curBuf = bufnr('%')
    wincmd w
    if winnr() == curNr
      exe 'bdelete'
    elseif curBuf != bufnr('%')
      wincmd W
      exe 'bdelete'
    else
      wincmd W
      wincmd c
    endif
  endfunction " }}}

  command! Q call DeleteEmptyBuffer()
  function! DeleteEmptyBuffer() " {{{
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
      if bufexists(i) && bufname(i) == ''
        call add(empty, i)
      endif
      let i += 1
    endwhile
    if len(empty) > 0
      exe 'bdelete' join(empty)
    endif
  endfunction " }}}

  nnoremap <silent> <Leader>dh :call DeleteHiddenBuffers()<CR>
  function! DeleteHiddenBuffers()
      let tpbl=[]
      call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
      for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
          silent execute 'bwipeout' buf
      endfor
  endfunction

  nnoremap <silent> <Leader>tn :call ToggleWrap()<CR>
  function! ToggleWrap() " {{{
    if exists("g:toggle_wrap")
      unlet g:toggle_wrap
      set nowrap
      set nolbr
      set tw=0
    else
      let g:toggle_wrap = 1
      set wrap              " включить перенос длинных строк
      set lbr               " включить перенос целых слов
      set tw=85             " максимальная длина строки
      if has("linebreak")   " если встретился перенос строки, то
        let &sbr = nr2char(8618).' '  " показать ↪ в начале следующей строки
      endif
    endif
  endfunction " }}}
" }}}
" Autocommands {{{
  augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,plugins.vim so $MYVIMRC
  augroup END

  " Отключение мигания и звуков
  autocmd GUIEnter * set vb t_vb= " gVim
  autocmd VimEnter * set vb t_vb= " vim

  " Rabl support
  autocmd BufRead,BufNewFile *.rabl setf ruby
" }}}

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
