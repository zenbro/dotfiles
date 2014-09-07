set nocompatible    " отключение режима совместимости с vi
filetype plugin indent on
let mapleader = "\<Space>" " по умолчанию это \

" Autoinstall NeoBundle " {{{
  let allPluginsInstalled = 1
  let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
  if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let allPluginsInstalled = 0
  endif
" }}}
" NeoBundle init {{{
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))
" }}}
" Plugins " {{{1
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    },
        \ }
  NeoBundle 'Shougo/unite.vim'
  " {{{
    let g:unite_data_directory = $HOME . '/.vim/cache/unite'
    let g:unite_split_rule = 'botright'
    let g:unite_winheight = 15
    let g:unite_source_history_yank_enable = 1
    let g:unite_force_overwrite_statusline = 0
    let g:unite_source_rec_max_cache_files = 1000
    let g:unite_source_grep_max_candidates = 200
    let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
    call unite#filters#matcher_default#use(['matcher_fuzzy'])

    " https://github.com/ggreer/the_silver_searcher
    if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup --smart-case'
      let g:unite_source_grep_recursive_opt = ''
      let g:unite_source_grep_search_word_highlight = 1
      " Использовать ag для поиска файлов в проекте
      let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
    endif

    " Перемещение внутри буфера unite с помощью C-j и C-k
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      nmap <silent><buffer> ; <Plug>(unite_quick_match_default_action)
      imap <silent><buffer> ; <Plug>(unite_quick_match_default_action)
      nmap <buffer> <esc> <plug>(unite_exit)
      nmap <buffer> Q <plug>(unite_exit)
      imap <buffer> <C-j> <Plug>(unite_select_next_line)
      imap <buffer> <C-k> <Plug>(unite_select_previous_line)
      imap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
    endfunction

    nnoremap <silent> <leader><space> :<C-u>Unite -toggle -start-insert buffer file_rec/async:!<CR>
    nnoremap <silent> <leader>o :<C-u>Unite outline -start-insert<cr>
    nnoremap <silent> <leader>. :<C-u>Unite -no-quit -keep-focus grep:%<cr>
    nnoremap <silent> <leader>/ :<C-u>Unite -no-quit -keep-focus grep:.<cr>
    nnoremap <silent> <leader>? :<C-u>Unite -no-quit -keep-focus grep:$buffers<cr>
    nnoremap <silent> <leader>b :<C-u>Unite buffer -start-insert<cr>
    nnoremap <silent> <leader>y :<C-u>Unite history/yank<cr>
    nnoremap <silent> <leader>m :<C-u>Unite mark<cr>
    nnoremap <silent> <leader>p :<C-u>Unite -start-insert file_rec/git<cr>
    " Unite plugins {{{
    NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
    NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}}
    NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
    NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
    NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' :
                \ ['history/command', 'history/search']}}
    " }}}
  " }}}
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/vimfiler.vim'
  " {{{
    let g:vimfiler_data_directory = $HOME . '/.vim/cache/vimfiler'
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
    let g:vimfiler_force_overwrite_statusline = 0
    let g:vimfiler_time_format = '%d-%m-%Y %H:%M:%S'
    map <F3> :VimFilerExplorer -winwidth=25 -auto-cd -toggle<cr>
    map <F2> :e .<cr>

    autocmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
      nmap <buffer> s <Plug>(vimfiler_toggle_mark_current_line)
      setlocal nonumber
    endfunction
  " }}}
  NeoBundle 'Shougo/junkfile.vim'
  " {{{
    let g:junkfile#directory = $HOME . '/.vim/cache/junkfile'
  " }}}
  NeoBundle 'Shougo/neocomplete.vim'
  " {{{
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#data_directory = '~/.vim/cache'

    nmap <Leader>tc :NeoCompleteToggle<CR>

    " При нажатии Enter закрывать попап
    imap <expr><CR> pumvisible() ? "<C-r>=<SID>my_cr_function()<CR>" : "<Plug>delimitMateCR"
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
    endfunction

    " Обратный переход по элементам меню по Shift+Tab
    imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
    smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " }}}
  NeoBundle 'Shougo/neosnippet'
  " {{{
    let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#disable_runtime_snippets = { '_' : 1, }

    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
  " }}}
  NeoBundle 'honza/vim-snippets'
  NeoBundle 'scrooloose/syntastic'
  " {{{
    nnoremap <Leader>te :SyntasticToggleMode<CR>
    let g:syntastic_enable_signs        = 1   " включить пометки об ошибках на полях
    let g:syntastic_enable_highlighting = 1   " включить подсветку ошибок
    let g:syntastic_cpp_check_header    = 1   " включить подсветку в файлах C++
    let g:syntastic_enable_balloons     = 1   " включить всплывающие подсказки
    let g:syntastic_echo_current_error  = 1   " выводить в строке статуса текущую ошибку
    let g:syntastic_error_symbol        = '✘' " заменить символ ошибок
    let g:syntastic_warning_symbol      = '!' " заменить символ предупреждений
    let g:syntastic_ignore_files = ['\.py$']  " использовать только python-mode
  " }}}
  NeoBundle 'xuhdev/SingleCompile'
  " {{{
    map <F4> :SCChooseCompiler<CR>
    map <s-F5> :SCCompileRunAF
    map <F5> :SCCompileRun<CR>
    map <F6> :SCViewResult<CR>
  " }}}
  NeoBundle 'bling/vim-airline'
  " {{{
    set laststatus=2 " всегда отображать строку статуса
    set showcmd      " отображать вводимую команду

    let g:airline_left_sep          = '▸'
    let g:airline_right_sep         = '◂'
    let g:airline_theme             = 'jellybeans'
    let g:airline_section_z         = '%2p%% %2l/%L:%2v'
    let g:airline_enable_syntastic  = 0


    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#whitespace#checks = ['trailing']
    let g:airline#extensions#whitespace#trailing_format = '%s'
    nnoremap <silent> <Leader>tw ::AirlineToggleWhitespace<CR>
  " }}}
  NeoBundle 'bling/vim-bufferline'
  " {{{
    let g:airline#extensions#bufferline#enabled = 0
    let g:bufferline_echo = 1
    let g:bufferline_rotate = 1
    let g:bufferline_show_bufnr = 0
    let g:bufferline_fixed_index =  0
    let g:bufferline_active_buffer_left = '>'
    let g:bufferline_active_buffer_right = ''
  " }}}
  NeoBundle 'airblade/vim-rooter'
  NeoBundle 'mhinz/vim-startify'
  " {{{
    let g:startify_session_dir = '~/.vim/session'
    let g:startify_session_persistence = 1 " сохранять сессию на выходе
    let g:startify_change_to_vcs_root = 1  " менять текущий каталог на корневой каталог проекта

    let g:startify_list_order = [
            \ ['   Последние файлы:'],
            \ 'files',
            \ ['   Сохранённые сессии:'],
            \ 'sessions',
            \ ]

    " отображение случайного афоризма
    let g:startify_custom_footer =
            \ map(split(system('fortune truth life book genious time knowledge
            \ | cowsay -f stegosaurus'), '\n'), '"   ". v:val') + ['']

    map <F12> :Startify<CR>
  " }}}
  NeoBundle 'junegunn/vim-easy-align'
  " {{{
    let g:easy_align_ignore_comment = 0 " выравнивнивать комментарии
    vnoremap <silent> <Enter> :EasyAlign<cr>
  " }}}
  NeoBundle 'Raimondi/delimitMate'
  " {{{
    let delimitMate_expand_cr = 2
    let delimitMate_expand_space = 1 " было {|}, нажимаем пробел => { | }
  " }}}
  NeoBundle 'AndrewRadev/splitjoin.vim'
  NeoBundle 'AndrewRadev/switch.vim'
  " {{{
    nnoremap <silent> - :Switch<CR>
  " }}}
  NeoBundle 'AndrewRadev/sideways.vim'
  " {{{
    nnoremap <Leader>h :SidewaysLeft<CR>
    nnoremap <Leader>l :SidewaysRight<CR>
  " }}}
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " {{{
    let g:indent_guides_default_mapping = 0
    let g:indent_guides_enable_on_vim_startup = 1 " включён по умолчанию
    let g:indent_guides_start_level = 2           " с какого уровня начинать подсвечивать
    let g:indent_guides_exclude_filetypes = ['help', 'startify', 'unite', 'vimfiler', 'vimshell']

    nmap <silent> <Leader>ti <Plug>IndentGuidesToggle
  " }}}
  NeoBundle 'Lokaltog/vim-easymotion'
  " {{{
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_off_screen_search = 0
    nmap ; <Plug>(easymotion-s2)
  " }}}
  NeoBundle 'bkad/CamelCaseMotion'
  " {{{
    map <silent> w <Plug>CamelCaseMotion_w
    map <silent> b <Plug>CamelCaseMotion_b
    map <silent> e <Plug>CamelCaseMotion_e
    sunmap w
    sunmap b
    sunmap e

    omap <silent> iw <Plug>CamelCaseMotion_iw
    xmap <silent> iw <Plug>CamelCaseMotion_iw
    omap <silent> ib <Plug>CamelCaseMotion_ib
    xmap <silent> ib <Plug>CamelCaseMotion_ib
    omap <silent> ie <Plug>CamelCaseMotion_ie
    xmap <silent> ie <Plug>CamelCaseMotion_ie
  " }}}
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'kshenoy/vim-signature'
  " {{{
    let g:SignatureMarkerTextHL = 'Typedef'
    nnoremap <Leader>tm :SignatureToggle<CR>
  " }}}
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'tpope/vim-fugitive'
  " {{{
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gvdiff<CR>
    nnoremap <silent> <leader>gD :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gi :Git add -p %<CR>
  " }}}
  NeoBundle 'gregsexton/gitv'
  " {{{
    let g:Gitv_OpenHorizontal = 1
    nnoremap <silent> <leader>gv :Gitv<CR>
  " }}}
  NeoBundle 'airblade/vim-gitgutter'
  " {{{
    let g:gitgutter_max_signs = 250
    let g:gitgutter_realtime = 0
    nmap <silent> ]h :GitGutterNextHunk<CR>
    nmap <silent> [h :GitGutterPrevHunk<CR>
    nmap <silent> <Leader>gu :GitGutterRevertHunk<CR>
    nmap <silent> <Leader>gp :GitGutterPreviewHunk<CR><c-w>j
    nmap <silent> <Leader>tg :GitGutterToggle<CR>
  " }}}
  NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
  " {{{
    let g:gist_open_browser_after_post = 1
    nnoremap <leader>gg :Gist -l<CR>
  " }}}
  NeoBundle 'jimenezrick/vimerl'
  " {{{
    let erlang_show_errors = 0
  " }}}
  NeoBundle 'klen/python-mode'
  " {{{
    let g:pymode_run = 0
    let g:pymode_rope = 0
    let g:pymode_folding = 0
    let g:pymode_breakpoint = 0
    let g:pymode_options_max_line_length = 0
    let g:pymode_lint_ignore = 'E501'

    let g:pymode_lint_todo_symbol = 'DO'
    let g:pymode_lint_comment_symbol = ':('
    let g:pymode_lint_visual_symbol = 'RR'
    let g:pymode_lint_error_symbol = '✘'
    let g:pymode_lint_info_symbol = '!'
  " }}}
  NeoBundle 'othree/html5.vim'
  NeoBundle 'moll/vim-node'
  NeoBundle 'marijnh/tern_for_vim'
  NeoBundle 'zenbro/vim-javascript-syntax'
  NeoBundle 'othree/javascript-libraries-syntax.vim'
  "" {{{
    let g:used_javascript_libs = 'jquery,backbone,requirejs'
  "" }}}
  NeoBundle 'leshill/vim-json'
  NeoBundle 'kchmck/vim-coffee-script'
  " {{{
    let coffee_compiler = '/usr/bin/coffee'
    let coffee_linter   = '/home/i/.npm/coffeelint/0.6.1/package/bin/coffeelint'
    let coffee_compile_vert = 1
    let coffee_watch_vert   = 1
    let coffee_run_vert     = 1

    autocmd FileType coffee nmap <leader>js :CoffeeCompile<CR>
    autocmd FileType coffee nmap <leader>cw :CoffeeWatch<CR>
    autocmd FileType coffee nmap <leader>cl :CoffeeLint<CR>
  " }}}
  NeoBundle 'mattn/emmet-vim'
  " {{{
    let g:user_emmet_expandabbr_key = '<c-e>'
  " }}}
  NeoBundle 'tpope/vim-ragtag'
  " {{{
    let g:ragtag_global_maps = 1
  " }}}
  NeoBundle 'tpope/vim-rails'
  NeoBundle 'tpope/vim-rvm'
  NeoBundle 'sheerun/rspec.vim'
  NeoBundle 'tpope/vim-cucumber'
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'tpope/vim-eunuch'
  NeoBundle 'tpope/vim-characterize'
  NeoBundle 'tpope/vim-speeddating'
  NeoBundle 'tpope/vim-sleuth'
  NeoBundle 'tpope/vim-tbone'
  " {{{
    map <F1> :Tmux split-window -p 25<cr>
    imap <F1> <esc>:Tmux split-window -p 25<cr>

    nnoremap <leader>S :Tmux split-window<cr>
    nnoremap <leader>V :Tmux split-window -h<cr>
  " }}}
  NeoBundle 'benmills/vimux'
  " {{{
    let g:VimuxHeight = '20'
    nnoremap <leader>vp :VimuxPromptCommand<cr>
    nnoremap <leader>vl :VimuxRunLastCommand<cr>
    nnoremap <Leader>vq :VimuxCloseRunner<cr>
    nnoremap <Leader>vs :VimuxInspectRunner<CR>
    nnoremap <Leader>vx :VimuxInterruptRunner<cr>
    nnoremap <Leader>vz :VimuxZoomRunner<cr>
  " }}}
  NeoBundle 'christoomey/vim-tmux-navigator'
  let g:tmux_navigator_no_mappings = 1

  nnoremap <silent> h :TmuxNavigateLeft<cr>
  nnoremap <silent> j :TmuxNavigateDown<cr>
  nnoremap <silent> k :TmuxNavigateUp<cr>
  nnoremap <silent> l :TmuxNavigateRight<cr>
  " {{{ NeoBundle 'edkolev/tmuxline.vim'
  "   let g:tmuxline_powerline_separators = 0
  "   let g:tmuxline_separators = {
  "         \ 'left' : '▸',
  "         \ 'left_alt': '>',
  "         \ 'right' : '◂',
  "         \ 'right_alt' : '<',
  "         \ 'space' : ' '}
  "
  "   let g:airline#extensions#tmuxline#enabled = 1 }}}
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-indent'
  NeoBundle 'nelstrom/vim-textobj-rubyblock'
  " {{{
    runtime macros/matchit.vim
  " }}}
  NeoBundle 'tyru/open-browser.vim'
  " {{{
    let g:netrw_nogx = 1
    nmap gx <Plug>(openbrowser-smart-search) 
    vmap gx <Plug>(openbrowser-smart-search) 
  " }}}
  NeoBundle 'lyokha/vim-xkbswitch'
  " {{{
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchNLayout = 'us'
    let g:XkbSwitchILayout = 'us'
  " }}}
  NeoBundle 'nanotech/jellybeans.vim', { 'autoload' :
          \ { 'unite_sources' : 'colorscheme', }}
" }}}
" Autoinstall Plugins {{{
  if allPluginsInstalled == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :NeoBundleInstall
  endif
" }}}
" Autoreload vimrc {{{
  augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC
  augroup END
" }}}
" Main settings {{{
  set gfn=Ubuntu\ Mono\ 12

  syntax enable " подсветка синтаксиса
  set nu " нумерация строк

  " Отключение мигания и звуков
  autocmd GUIEnter * set vb t_vb= " gVim
  autocmd VimEnter * set vb t_vb= " vim

  " Поддержка команд при включённой русской раскладке
  set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

  set lz                         " включает lazyredraw, даёт прирост производительности
  set backspace=indent,eol,start " с чем будет работать клавиша backspace
  set virtualedit=onemore        " возможность перемещения за конец строки
  set clipboard=unnamed
  set undolevels=5000            " максимальное количество уровней отмены изменений
  set viminfo='1000,f1           " сохранение глобальных меток
  set fileencodings=utf-8,cp1251,koi8-r,cp866 " приоритет подбора возможных кодировок файла
  set encoding=utf-8 " кодировка по умолчанию
  set autoread       " автоматически перезагружать файлы, изменённые извне
  set noswapfile     " отключить своп-файлы
  set hidden         " сворачивать в буфер, вместо закрытия
" }}}
" gVim settings {{{
  if has("gui_running")         " если запущен gvim, то...
    winpos 0 0                " положение окна при запуске
    set guioptions-=T         " убрать панель инструментов
    set guioptions-=m         " убрать меню
    set guioptions-=l         " убрать левый скроллбар
    set guioptions-=L         " убрать левый скроллбар у сплита
    set guioptions-=r         " убрать правый скроллбар
    set guioptions-=R         " убрать правый скроллбар у сплита
    set mousehide             " не показывать курсор во время печати
    set cursorline            " подсветка строки с курсором
    set linespace=0           " межстрочный интервал
    set guicursor=n:blinkon0  " отключить мигание курсора в нормальном режиме
    autocmd FileType ruby Rvm " автоматически подключать rvm
  else                          " если запущен vim, то...
    set term=screen-256color
  endif
" }}}
" Colorscheme {{{
  colorscheme jellybeans
  highlight SignColumn guibg=#0D0D0D ctermbg=233
  highlight SyntasticErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
  highlight SyntasticErrorLine guibg=#0D0D0D ctermbg=232
  highlight SyntasticWarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
  highlight SyntasticWargningLine guibg=#171717
" }}}
" Search {{{
set ic              " игнорировать регистр при поиске
set incsearch       " перескакивать на найденный текст в процессе набора
set hls             " подсвечивать найденное
set ignorecase      " игнорировать регистр букв при поиске
set smartcase       " включить умное распознование регистра
set gdefault        " включает флаг g в командах замены, типа :%s/a/b/

" Очистить подсветку поиска по нажатию <Esc><Esc>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
" }}}
" Indents and tabulation {{{
set expandtab       " замена таб-символов пробелами
set shiftwidth=2    " размер сдвига при нажатии << или >>
set softtabstop=2   " удаление tab-символов как пробелов
set nowrap
set nolbr
set tw=0            " отключение автопереноса длинных строк
set autoindent      " автоматический отступ
set smartindent     " включает умную расстановку отступов
set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×
set scrolloff=999   " держать курсор на определённом расстоянии от нижнего края
autocmd BufRead * set tabstop=2 " размер табуляции
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
  set wcm=<Tab>   " переключение элементов меню
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
  nnoremap <Leader>ds :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G

  " Выделить весь текст
  noremap vA ggVG

  " Y копирует от курсора и до конца строки
  nnoremap Y y$

  " Перемещение курсора в режиме вставки
  inoremap <C-h> <left>
  inoremap <C-l> <right>

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

  command! Q call DeleteEmptyBuffers()
  function! DeleteEmptyBuffers() " {{{
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
" }}}1
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
