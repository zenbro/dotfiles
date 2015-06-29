set encoding=utf-8
set nocompatible " отключение режима совместимости с vi
scriptencoding utf-8

filetype plugin indent on

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
  set cursorline                              " подсветка строки с курсором
  set diffopt=filler,vertical
  set foldmethod=manual
  set tags=./tags

  if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " удалять символ комментария при соединении двух закомментированных строк
  endif

  " загружать matchit.vim только если не установлена более новая версия
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  endif
" }}}
" gVim settings {{{
  if has('gui_running')       " если запущен gvim, то...
    winpos 0 0                " положение окна при запуске
    set guioptions-=T         " убрать панель инструментов
    set guioptions-=m         " убрать меню
    set guioptions-=l         " убрать левый скроллбар
    set guioptions-=L         " убрать левый скроллбар у сплита
    set guioptions-=r         " убрать правый скроллбар
    set guioptions-=R         " убрать правый скроллбар у сплита
    set guioptions-=e         " убрать GUI-табы
    set guioptions-=a         " отключить автоматическое копирование при выделении текста
    set mousehide             " не показывать курсор во время печати
    set linespace=0           " межстрочный интервал
    set guicursor=n:blinkon0  " отключить мигание курсора в нормальном режиме
  else
    " :help i_CTRL-V
    map Oa <C-Up>
    map Ob <C-Down>
  endif
" }}}
" Colorscheme {{{
  colorscheme jellybeans
  highlight SignColumn guibg=#0D0D0D ctermbg=233
  highlight SyntasticErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
  highlight SyntasticErrorLine guibg=#0D0D0D ctermbg=232
  highlight SyntasticWarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
  highlight SyntasticWargningLine guibg=#171717

  highlight ColorColumn ctermbg=232 guibg=#131313
  set colorcolumn=79
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
set textwidth=0   " отключение автопереноса длинных строк
set autoindent    " автоматический отступ
set smartindent   " включает умную расстановку отступов
set smarttab
set shiftround    " отступы с помощью >> всегда кратны двум
set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×
set scrolloff=999 " держать курсор на определённом расстоянии от нижнего края
set list
" }}}
" Wildmenu {{{
  set wildmenu    " включить меню выбора
  set wildcharm=<Tab>   " переключение элементов меню
  set wildmode=list:longest,full " отображать меню в виде полного списка

  " Файлы, которые будут игнорироваться в wildmenu
  if has('wildignore')
    set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
  endif
" }}}
" Key mappings {{{1
  " Toggle setting (:h unimpaired-toggling)
  nnoremap cof :set foldenable! foldenable?<CR>
  nnoremap coe :set expandtab! expandtab?<CR>

  nnoremap <Leader>vi :tabedit $MYVIMRC<CR>
  nnoremap <leader>w :w<CR>
  map <silent> <F8> :copen<CR>

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
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz

  " Создаем пустой сплит относительно текущего
  nnoremap <Leader>sh :leftabove  vnew<CR>
  nnoremap <Leader>sl :rightbelow vnew<CR>
  nnoremap <Leader>sk :leftabove  new<CR>
  nnoremap <Leader>sj :rightbelow new<CR>
  nnoremap <Leader>ss :split<CR> <c-w>j
  nnoremap <Leader>sv :vsplit<CR> <c-w>l
  nnoremap <Leader>sw <c-w>r
  nnoremap <Leader>sq :only<cr>
  nnoremap <C-h> <C-W>h
  nnoremap <C-j> <C-W>j
  nnoremap <C-k> <C-W>k
  nnoremap <C-l> <C-W>l

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
      if bufexists(i) && empty(bufname(i))
        call add(empty, i)
      endif
      let i += 1
    endwhile
    if len(empty) > 0
      exe 'bdelete' join(empty)
    endif
  endfunction " }}}

  " Bubble single lines (using unimpaired.vim)
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

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
      set nolinebreak
      set textwidth=0
    else
      let g:toggle_wrap = 1
      set wrap                       " включить перенос длинных строк
      set linebreak                  " включить перенос целых слов
      set textwidth=79               " максимальная длина строки
      if has("linebreak")            " если встретился перенос строки, то
        let &sbr = nr2char(8618).' ' " показать ↪ в начале следующей строки
      endif
    endif
  endfunction " }}}
" }}}
" Netrw {{{
  map <F1> :Explore<CR>
  map <F2> :edit .<CR>

  let g:netrw_list_hide= netrw_gitignore#Hide() . ',\(^\|\s\s\)\zs\.\S\+'
  let g:netrw_hide = 1 " show not-hidden files by default

  function! NetrwCustomSettings()
    setlocal nolist
    map <buffer> <F1> :Rexplore<CR>
    map <buffer> <F2> :Rexplore<CR>
    nmap <buffer> l <CR>
    nmap <buffer> h -
    nnoremap <buffer> ~ :edit ~/<CR>
    nnoremap <buffer> <silent> q :Rexplore<CR>
  endfunction

  augroup EnterNetrw
    autocmd!
    autocmd FileType netrw call NetrwCustomSettings()
  augroup END
" }}}
" Autocommands {{{
  " Отключение мигания и звуков
  augroup vimEnter
    autocmd!
    autocmd GUIEnter * set vb t_vb= " gVim
    autocmd VimEnter * set vb t_vb= " vim
  augroup END

  augroup fileTypeSpecific
    autocmd!
    " Rabl support
    autocmd BufRead,BufNewFile *.rabl setfiletype ruby

    " Make ?s part of words
    autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
    autocmd FileType json setlocal concealcursor=
  augroup END

  augroup quickFixSettings
    autocmd!
    autocmd FileType qf nnoremap <buffer> <silent> q :cclose<CR> |
          \ map <buffer> <silent> <F8> :cclose<CR>
  augroup END
" }}}
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
