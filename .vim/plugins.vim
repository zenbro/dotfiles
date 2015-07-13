" Autoinstall vim-plug " {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.vim/plugged')

" Appearance
" ==========
  Plug 'nanotech/jellybeans.vim'
  Plug 'bling/vim-airline'
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
   let g:airline_exclude_preview = 1

   let g:airline#extensions#syntastic#enabled = 0
   let g:airline#extensions#whitespace#enabled = 0
   let g:airline#extensions#whitespace#symbol = '!'
   let g:airline#extensions#whitespace#checks = ['trailing']
   let g:airline#extensions#whitespace#trailing_format = '%s'
   nnoremap <silent> <Leader>tw ::AirlineToggleWhitespace<CR>
  " }}}
  Plug 'nathanaelkane/vim-indent-guides'
  " {{{
    let g:indent_guides_default_mapping = 0
    let g:indent_guides_enable_on_vim_startup = 1 " включён по умолчанию
    let g:indent_guides_start_level = 2           " с какого уровня начинать подсвечивать
    let g:indent_guides_exclude_filetypes = ['help', 'startify', 'unite', 'vimfiler', 'rogue']
    autocmd User Startified setlocal colorcolumn=0

    nmap <silent> <Leader>ti <Plug>IndentGuidesToggle
  " }}}
  Plug 'mhinz/vim-startify'
  " {{{
    let g:startify_list_order = ['sessions']
    let g:startify_session_persistence = 1
    let g:startify_session_delete_buffers = 1
    let g:startify_change_to_dir = 1
    let g:startify_change_to_vcs_root = 1
    let g:startify_custom_footer =
      \ map(split(system('fortune.rb'), '\n'), '"   ". v:val') + ['','']
    nnoremap <F12> :Startify<CR>
  " }}}
  Plug 'kshenoy/vim-signature'
  " {{{
    let g:SignatureMarkerTextHL = 'Typedef'
    let g:SignatureMap = {
      \ 'Leader'             :  "m",
      \ 'PlaceNextMark'      :  "m,",
      \ 'ToggleMarkAtLine'   :  "m.",
      \ 'PurgeMarksAtLine'   :  "m-",
      \ 'DeleteMark'         :  "dm",
      \ 'PurgeMarks'         :  "m<Space>",
      \ 'PurgeMarkers'       :  "m<BS>",
      \ 'GotoNextLineAlpha'  :  "",
      \ 'GotoPrevLineAlpha'  :  "",
      \ 'GotoNextSpotAlpha'  :  "",
      \ 'GotoPrevSpotAlpha'  :  "",
      \ 'GotoNextLineByPos'  :  "]'",
      \ 'GotoPrevLineByPos'  :  "['",
      \ 'GotoNextSpotByPos'  :  "]`",
      \ 'GotoPrevSpotByPos'  :  "[`",
      \ 'GotoNextMarker'     :  "[+",
      \ 'GotoPrevMarker'     :  "[-",
      \ 'GotoNextMarkerAny'  :  "]=",
      \ 'GotoPrevMarkerAny'  :  "[=",
      \ 'ListLocalMarks'     :  "m/",
      \ 'ListLocalMarkers'   :  "m?"
      \ }
  " }}}
  Plug 'tpope/vim-sleuth'
  Plug 'junegunn/limelight.vim'
  " {{{
    let g:limelight_default_coefficient = 0.7
    let g:limelight_conceal_ctermfg = 238
    nmap <silent> gl :Limelight!!<CR>
    xmap gl <Plug>(Limelight)
  " }}}

" Completion
" ==========
  Plug 'Shougo/neocomplete.vim'
  " {{{
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#data_directory = $HOME . '/.vim/cache'
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
  Plug 'Shougo/neosnippet'
  " {{{
    let g:neosnippet#snippets_directory = '~/.vim/snippets'
    let g:neosnippet#data_directory = $HOME . '/.vim/cache/neosnippet'

    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
  " }}}
  Plug 'Shougo/neosnippet-snippets'

" File Navigation
" ===============
  Plug 'Shougo/unite.vim'
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
  " }}}
  Plug 'Shougo/neomru.vim'
  " {{{
    let g:neomru#file_mru_path = $HOME . '/.vim/cache/neomru/file'
    let g:neomru#directory_mru_path = $HOME . '/.vim/cache/neomru/directory'
  " }}}
  Plug 'zenbro/mirror.vim'
  Plug 'kopischke/vim-fetch'

" Text Navigation
" ===============
  Plug 'Shougo/unite-outline'
  Plug 'Lokaltog/vim-easymotion'
  " {{{
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_off_screen_search = 0
    nmap ; <Plug>(easymotion-s2)
  " }}}
  Plug 'rhysd/clever-f.vim'
  " {{{
    let g:clever_f_across_no_line = 1
  " }}}

" Text Manipulation
" =================
  Plug 'tpope/vim-surround'
  Plug 'junegunn/vim-easy-align'
  " {{{
    let g:easy_align_ignore_comment = 0 " выравнивнивать комментарии
    vnoremap <silent> <Enter> :EasyAlign<cr>
  " }}}
  Plug 'Raimondi/delimitMate'
  " {{{
    let delimitMate_expand_cr = 2
    let delimitMate_expand_space = 1 " было {|}, нажимаем пробел => { | }
  " }}}
  Plug 'tomtom/tcomment_vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'AndrewRadev/switch.vim'
  " {{{
    let g:switch_mapping = '-'
  " }}}
  Plug 'AndrewRadev/sideways.vim'
  " {{{
    nnoremap <Leader>hh :SidewaysLeft<CR>
    nnoremap <Leader>ll :SidewaysRight<CR>
  " }}}
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-abolish'

" Text Objects
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-indent'
  Plug 'nelstrom/vim-textobj-rubyblock'

" Writing
" =======
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'reedes/vim-colors-pencil'
  Plug 'reedes/vim-pencil'
  Plug 'reedes/vim-wordy'
  Plug 'reedes/vim-litecorrect'
  " {{{
    function! EnterWritingMode()
      set background=light
      set colorcolumn=0
      let g:pencil_terminal_italics = 1
      let g:airline_section_x = '%{PencilMode()}'
      colorscheme pencil
      AirlineTheme pencil
      Pencil
      call litecorrect#init()
      redraw
    endfunction

    function! LeaveWritingMode()
      set background=light
      set colorcolumn=79
      colorscheme jellybeans
      AirlineTheme jellybeans
      NoPencil
      redraw
    endfunction
  " }}}

" Languages
" =========
  Plug 'scrooloose/syntastic'
  " {{{
    nnoremap <Leader>te :SyntasticToggleMode<CR>
    let g:syntastic_enable_signs        = 1   " включить пометки об ошибках на полях
    let g:syntastic_enable_highlighting = 1   " включить подсветку ошибок
    let g:syntastic_cpp_check_header    = 1   " включить подсветку в файлах C++
    let g:syntastic_enable_balloons     = 1   " включить всплывающие подсказки
    let g:syntastic_echo_current_error  = 1   " выводить в строке статуса текущую ошибку
    let g:syntastic_check_on_wq         = 0   " не проверять синтаксис при закрытии файла
    let g:syntastic_error_symbol        = '✘' " заменить символ ошибок
    let g:syntastic_warning_symbol      = '!' " заменить символ предупреждений
    let g:syntastic_ignore_files = ['\.py$']  " использовать только python-mode
    let g:syntastic_vim_checkers = ['vint']
    let g:syntastic_elixir_checkers = ['elixir']
    let g:syntastic_enable_elixir_checker = 1

    function! RubocopAutoCorrection()
      echo 'Starting rubocop autocorrection...'
      cexpr system('rubocop -D -f emacs -a ' . expand(@%))
      edit
      SyntasticCheck rubocop
      copen
    endfunction

    augroup SyntasticCustomCheckers
      autocmd!
      autocmd FileType ruby nnoremap <leader>` :SyntasticCheck rubocop<CR>
      autocmd FileType ruby nnoremap <leader>! :call RubocopAutoCorrection()<CR>
      autocmd FileType sh nnoremap <leader>` :SyntasticCheck shellcheck<CR>
    augroup END
  " }}}
  Plug 'xolox/vim-easytags'
  " {{{
    let g:easytags_async = 1
    let g:easytags_dynamic_files = 1
    let g:easytags_auto_update = 0
    let g:easytags_auto_highlight = 0
  " }}}
  Plug 'mattn/emmet-vim'
  " {{{
    let g:user_emmet_expandabbr_key = '<c-e>'
  " }}}
  Plug 'tpope/vim-ragtag'
  Plug 'vim-ruby/vim-ruby'
  " {{{
    let g:ragtag_global_maps = 1
  " }}}
  Plug 'hwartig/vim-seeing-is-believing'
  " {{{
    augroup seeingIsBelievingSettings
      autocmd!
      autocmd FileType ruby nmap <buffer> gZ <Plug>(seeing-is-believing-run)

      autocmd FileType ruby nmap <buffer> gz <Plug>(seeing-is-believing-mark)
      autocmd FileType ruby xmap <buffer> gz <Plug>(seeing-is-believing-mark)
      autocmd FileType ruby imap <buffer> gz <Plug>(seeing-is-believing-mark)

      autocmd FileType ruby nmap <buffer> <Enter> gzgZ
    augroup END
  " }}}
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-liquid'
  Plug 'klen/python-mode'
  " {{{
    let g:pymode_run = 0
    let g:pymode_rope = 0
    let g:pymode_folding = 0
    let g:pymode_breakpoint = 0
    let g:pymode_options_max_line_length = 0
    let g:pymode_lint_ignore = 'E501,C901'
    let g:pymode_virtualenv = 1

    let g:pymode_lint_todo_symbol = 'DO'
    let g:pymode_lint_comment_symbol = ':('
    let g:pymode_lint_visual_symbol = 'RR'
    let g:pymode_lint_error_symbol = '✘'
    let g:pymode_lint_info_symbol = '!'

    autocmd FileType python setlocal completeopt-=preview
  " }}}
  Plug 'othree/html5.vim'
  Plug 'othree/yajs.vim'
  Plug 'othree/javascript-libraries-syntax.vim'
  " {{{
   let g:used_javascript_libs = 'jquery'
  " }}}
  Plug 'ap/vim-css-color'
  Plug 'moll/vim-node'
  Plug 'digitaltoad/vim-jade'
  Plug 'briancollins/vim-jst'
  Plug 'kchmck/vim-coffee-script'
  " {{{
    let coffee_compiler = '/usr/bin/coffee'
    let coffee_linter   = '/home/i/.npm/coffeelint/0.6.1/package/bin/coffeelint'
    let coffee_compile_vert = 1
    let coffee_watch_vert   = 1
    let coffee_run_vert     = 1

    augroup enterCoffeeScript
      autocmd!
      autocmd FileType coffee nnoremap <leader>js :CoffeeCompile<CR>
      autocmd FileType coffee nnoremap <leader>cw :CoffeeWatch<CR>
      autocmd FileType coffee nnoremap <leader>cl :CoffeeLint<CR>
    augroup END
  " }}}
  Plug 'tpope/vim-haml'
  Plug 'jimenezrick/vimerl'
  " {{{
    let erlang_show_errors = 0
  " }}}
  Plug 'elixir-lang/vim-elixir'
  Plug 'lervag/vimtex'
  " {{{
    let g:vimtex_view_method = 'zathura'
    augroup latex
      autocmd!
      autocmd FileType tex nnoremap <F4> :VimtexView<CR>
      autocmd FileType tex nnoremap <F5> :VimtexCompile<CR>
      autocmd FileType tex nnoremap <F6> :VimtexErrors<CR>
    augroup END
  " }}}

" Git
" ===
  Plug 'tpope/vim-fugitive'
  " {{{
    " Fix broken syntax highlight in gitcommit files
    " (https://github.com/tpope/vim-git/issues/12)
    let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gE :Gedit<space>
    nnoremap <silent> <leader>gl :Glog<space>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gR :Gread<space>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>gW :Gwrite!<CR>
    nnoremap <silent> <leader>gq :Gwq<CR>
    nnoremap <silent> <leader>gQ :Gwq!<CR>

    function! ReviewLastCommit()
      if exists('b:git_dir')
        Gtabedit HEAD^{}
        nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
      else
        echo 'No git a git repository:' expand('%:p')
      endif
    endfunction
    nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

    augroup fugitiveSettings
      autocmd!
      autocmd FileType gitcommit setlocal nolist
      autocmd BufReadPost fugitive://* setlocal bufhidden=delete
    augroup END
  " }}}
  Plug 'gregsexton/gitv'
  " {{{
    let g:Gitv_OpenHorizontal = 1
    nnoremap <silent> <leader>gv :Gitv<CR>
  " }}}
  Plug 'idanarye/vim-merginal'
  " {{{
    nnoremap <leader>gm :MerginalToggle<CR>
  " }}}
  Plug 'airblade/vim-gitgutter'
  " {{{
    let g:gitgutter_map_keys = 0
    let g:gitgutter_max_signs = 250
    let g:gitgutter_realtime = 0
    nmap <silent> ]h :GitGutterNextHunk<CR>
    nmap <silent> [h :GitGutterPrevHunk<CR>
    nnoremap <silent> <Leader>gu :GitGutterRevertHunk<CR>
    nnoremap <silent> <Leader>gp :GitGutterPreviewHunk<CR><c-w>j
    nnoremap cog :GitGutterToggle<CR>
  " }}}
  Plug 'esneider/YUNOcommit.vim'

" Utility
" =======
  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-dispatch'
  Plug 'Shougo/vimproc', { 'do' : 'make' }
  Plug 'tyru/open-browser.vim'
  " {{{
    let g:openbrowser_default_search = 'duckduckgo'
    let g:netrw_nogx = 1
    vmap gx <Plug>(openbrowser-smart-search)
    nmap gx <Plug>(openbrowser-search)
  " }}}
  Plug 'xuhdev/SingleCompile'
  " {{{
    map <s-F5> :SCChooseCompiler<CR>
    map <F5> :SCCompileRun<CR>
    map <F6> :SCViewResult<CR>
  " }}}
  Plug 'Shougo/junkfile.vim'
  " {{{
    let g:junkfile#directory = $HOME . '/.vim/cache/junkfile'
  " }}}
  Plug 'junegunn/vim-peekaboo'
  " {{{
    let g:peekaboo_delay = 400
  " }}}
  Plug 'mbbill/undotree'
  " {{{
    if has('persistent_undo')
      set undodir=$HOME.'/.vim/cache/undodir'
      set undofile
    endif

    nnoremap <F11> :UndotreeToggle<CR>
  " }}}

" Misc
" ====
  Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }
  " {{{
    let g:calendar_date_month_name = 1
  " }}}
  Plug 'katono/rogue.vim', { 'on': 'Rogue' }
  " {{{
    let g:rogue#name = 'zenbro'
    let g:rogue#directory = expand($HOME.'/.vim/rogue')
  " }}}
  Plug 'xolox/vim-misc'

call plug#end()

" can be called only after plugins init
call unite#custom#source('buffer,file,file/new,file_rec/async,outline',
      \ 'matchers', ['converter_relative_word', 'matcher_fuzzy'])
call unite#custom#source('buffer,file,file/new,file_rec/async',
      \ 'sorters', 'sorter_rank')

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
