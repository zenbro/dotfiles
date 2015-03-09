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

call neobundle#begin(expand('~/.vim/bundle/'))
" }}}
  NeoBundleFetch 'Shougo/neobundle.vim'
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
      imap <buffer> <C-j> <Plug>(unite_select_next_line)
      imap <buffer> <C-k> <Plug>(unite_select_previous_line)
      imap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
    endfunction

    nnoremap <silent> <leader><space> :<C-u>Unite -toggle -start-insert buffer file_rec/async:!<CR>
    nnoremap <silent> <leader>o :<C-u>Unite outline -start-insert<cr>
    nnoremap <silent> <leader>b :<C-u>Unite buffer -start-insert<cr>
    nnoremap <silent> <leader>y :<C-u>Unite history/yank<cr>
    nnoremap <silent> <leader>m :<C-u>Unite mark<cr>
    nnoremap <silent> <leader>p :<C-u>Unite -start-insert file_rec/git<cr>
    nnoremap <silent> <leader>. :<C-u>Unite -no-quit -keep-focus grep:%<cr>
    nnoremap <silent> <leader>/ :<C-u>Unite -no-quit -keep-focus grep:.<cr>
    nnoremap <silent> <leader>? :<C-u>Unite -no-quit -keep-focus grep:$buffers<cr>
    nnoremap <silent> K :<C-u>UniteWithCursorWord -no-quit -keep-focus grep:.<cr>
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
    map <F1> :VimFilerExplorer -winwidth=25 -auto-cd -toggle<cr>
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
    let g:neocomplete#force_overwrite_completefunc = 1

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
  NeoBundle 'Shougo/context_filetype.vim'
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

    " tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#show_tabs = 0
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#fnamecollapse = 1
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#buffer_min_count = 2

    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    let g:airline_left_sep          = '▸'
    let g:airline_right_sep         = '◂'
    let g:airline_theme             = 'jellybeans'
    let g:airline_section_z         = '%2p%% %2l/%L:%2v'
    let g:airline_exclude_preview = 0

    let g:airline#extensions#syntastic#enabled = 0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#whitespace#checks = ['trailing']
    let g:airline#extensions#whitespace#trailing_format = '%s'
    nnoremap <silent> <Leader>tw ::AirlineToggleWhitespace<CR>
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
    nnoremap <Leader>hh :SidewaysLeft<CR>
    nnoremap <Leader>ll :SidewaysRight<CR>
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
    let g:pymode_virtualenv = 1

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
  NeoBundle 'digitaltoad/vim-jade'
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
  NeoBundle 'sheerun/rspec.vim'
  NeoBundle 'thoughtbot/vim-rspec'
  " {{{
    let g:rspec_command = 'Dispatch bundle exec rspec {spec}'
    map <Leader>rt :call RunCurrentSpecFile()<CR>
    map <Leader>rs :call RunNearestSpec()<CR>
    map <Leader>rl :call RunLastSpec()<CR>
    map <Leader>ra :call RunAllSpecs()<CR>
  " }}}
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'tpope/vim-eunuch'
  NeoBundle 'tpope/vim-characterize'
  NeoBundle 'tpope/vim-speeddating'
  NeoBundle 'tpope/vim-sleuth'
  NeoBundle 'tpope/vim-abolish'
  NeoBundle 'tpope/vim-dispatch'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-indent'
  NeoBundle 'nelstrom/vim-textobj-rubyblock'
  NeoBundle 'itchyny/calendar.vim'
  " {{{
    let g:calendar_date_month_name=1
  " }}}
  NeoBundle 'xolox/vim-session'
  " {{{
    let g:session_autosave = 'yes'
    " let g:session_default_to_last = 1
    set sessionoptions-=tabpages
    set sessionoptions-=help
  " }}}
  NeoBundle 'xolox/vim-misc'
  NeoBundle 'xolox/vim-notes'
  " {{{
    let g:notes_directories = ['~/Dropbox/notes']
  " }}}
  NeoBundle 'tyru/open-browser.vim'
  " {{{
    let g:netrw_nogx = 1
    vmap gx <Plug>(openbrowser-smart-search)
  " }}}
  NeoBundle 'lyokha/vim-xkbswitch'
  " {{{
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchNLayout = 'us'
    let g:XkbSwitchILayout = 'us'
  " }}}
  NeoBundle 'katono/rogue.vim'
  NeoBundle 'nanotech/jellybeans.vim', { 'autoload' :
          \ { 'unite_sources' : 'colorscheme', }}

call neobundle#end()
" Autoinstall Plugins {{{
  if allPluginsInstalled == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :NeoBundleInstall
  endif
" }}}
" can be called only after neobundle#end
call unite#custom#source('file,file/new,buffer,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_fuzzy'])

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
