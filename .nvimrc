let g:python_host_prog='/usr/bin/python2'
let g:mapleader = "\<Space>"

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}
call plug#begin('~/.nvim/plugged') " Plugins initialization start {{{
" }}}
" Appearance
" ====================================================================
Plug 'nanotech/jellybeans.vim'
" {{{
  let g:jellybeans_use_term_background_color = 1
" }}}
Plug 'itchyny/lightline.vim'
" {{{
  let g:lightline = {
        \ 'colorscheme': 'jellybeans_mod',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'filename' ] ],
        \   'right': [ [ 'percent', 'lineinfo' ],
        \              [ 'syntastic' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightLineFugitive',
        \   'readonly': 'LightLineReadonly',
        \   'modified': 'LightLineModified',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'filename': 'LightLineFilename'
        \ },
        \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
        \ 'subseparator': { 'left': '>', 'right': '' }
        \ }
  function! LightLineModified()
    if &filetype == "help"
      return ""
    elseif &modified
      return "+"
    elseif &modifiable
      return ""
    else
      return ""
    endif
  endfunction

  function! LightLineReadonly()
    if &filetype == "help"
      return ""
    elseif &readonly
      return "⭤"
    else
      return ""
    endif
  endfunction

  function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  " {{{ Modified jellybeans theme
  let s:base03    = [ '#151513', 233 ]
  let s:base02    = [ '#30302c', 236 ]
  let s:base01    = [ '#4e4e43', 237 ]
  let s:base00    = [ '#666656', 242 ]
  let s:base0     = [ '#808070', 244 ]
  let s:base1     = [ '#949484', 246 ]
  let s:base2     = [ '#a8a897', 248 ]
  let s:base3     = [ '#e8e8d3', 253 ]
  let s:yellow    = [ '#ffb964', 215 ]
  let s:red       = [ '#cf6a4c', 167 ]
  let s:magenta   = [ '#f0a0c0', 217 ]
  let s:blue      = [ '#7697D6', 4   ]
  let s:orange    = [ '#ffb964', 215 ]
  let s:green     = [ '#99ad6a', 107 ]
  let s:white     = [ '#FCFCFC', 15  ]

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {}}
  let s:p.normal.left     = [ [ s:white, s:blue ], [ s:base3, s:base02 ] ]
  let s:p.normal.right    = [ [ s:base02, s:base1 ], [ s:base3, s:base02 ] ]
  let s:p.inactive.right  = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
  let s:p.inactive.left   = [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
  let s:p.insert.left     = [ [ s:base02, s:orange ], [ s:base3, s:base01 ] ]
  let s:p.replace.left    = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
  let s:p.visual.left     = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
  let s:p.terminal.left   = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
  let s:p.normal.middle   = [ [ s:base0, s:base03 ] ]
  let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
  let s:p.tabline.left    = [ [ s:base3, s:base02 ] ]
  let s:p.tabline.tabsel  = [ [ s:white, s:blue ] ]
  let s:p.tabline.middle  = [ [ s:base01, s:base03 ] ]
  let s:p.tabline.right   = copy(s:p.normal.right)
  let s:p.normal.error    = [ [ s:red, s:base02 ] ]
  let s:p.normal.warning  = [ [ s:yellow, s:base01 ] ]
  " }}}
" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
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
Plug 't9md/vim-choosewin'
" {{{
  nmap <leader>' <Plug>(choosewin)
  let g:choosewin_blink_on_land = 0
  let g:choosewin_tabline_replace = 0
" }}}

" Completion
" ====================================================================
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --tern-completer' }
" {{{
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_key_invoke_completion = '<c-j>'
  let g:ycm_complete_in_strings = 1
" }}}
Plug 'SirVer/ultisnips'
" {{{
  nnoremap <leader>se :UltiSnipsEdit<CR>
  let g:UltiSnipsEditSplit = 'horizontal'

  let g:UltiSnipsListSnippets = '<nop>'
  let g:UltiSnipsExpandTrigger = '<c-l>'
  let g:UltiSnipsJumpForwardTrigger = '<c-l>'
  let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
  let g:ulti_expand_or_jump_res = 0

  function! <SID>ExpandSnippetOrReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    else
      return "\<C-Y>"
    endif
  endfunction
  imap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "<Plug>delimitMateCR"
" }}}
Plug 'honza/vim-snippets'

" File Navigation
" ====================================================================
Plug 'scrooloose/nerdtree'
" {{{
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeWinSize = 31
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeCascadeOpenSingleChildDir = 1

  map <F1> :call NERDTreeToggleAndFind()<cr>
  map <F2> :NERDTreeToggle<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction
" }}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>. :Lines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction
" }}}
Plug 'Shougo/neomru.vim'
" {{{
  let g:neomru#file_mru_path = $HOME . '/.nvim/cache/neomru/file'
  let g:neomru#directory_mru_path = $HOME . '/.nvim/cache/neomru/directory'
" }}}
Plug 'zenbro/mirror.vim'

" Text Navigation
" ====================================================================
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
" ====================================================================
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
" {{{
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
" {{{
  let g:switch_mapping = '\'
" }}}
Plug 'AndrewRadev/sideways.vim'
" {{{
  nnoremap <Leader>< :SidewaysLeft<CR>
  nnoremap <Leader>> :SidewaysRight<CR>
" }}}
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'

" Text Objects
" ====================================================================
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'nelstrom/vim-textobj-rubyblock'

" Languages
" ====================================================================
Plug 'scrooloose/syntastic'
" {{{
  let g:syntastic_enable_signs          = 1
  let g:syntastic_enable_highlighting   = 1
  let g:syntastic_cpp_check_header      = 1
  let g:syntastic_enable_balloons       = 1
  let g:syntastic_echo_current_error    = 1
  let g:syntastic_check_on_wq           = 0
  let g:syntastic_error_symbol          = '✘'
  let g:syntastic_warning_symbol        = '!'
  let g:syntastic_style_error_symbol    = ':('
  let g:syntastic_style_warning_symbol  = ':('
  let g:syntastic_vim_checkers          = ['vint']
  let g:syntastic_elixir_checkers       = ['elixir']
  let g:syntastic_python_checkers       = ['flake8']
  let g:syntastic_javascript_checkers   = ['eslint']
  let g:syntastic_enable_elixir_checker = 0
" }}}
Plug 'xuhdev/SingleCompile'
" {{{
  map <F5> :SCCompileRun<CR>
" }}}
Plug 'mattn/emmet-vim'
" {{{
  let g:user_emmet_expandabbr_key = '<c-e>'
" }}}
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-ragtag'
" {{{
  let g:ragtag_global_maps = 1
" }}}
Plug 'vim-ruby/vim-ruby'
Plug 'zenbro/vim-seeing-is-believing', { 'branch': 'great_update' }
" {{{
  augroup seeingIsBelievingSettings
    autocmd!

    autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)

    autocmd FileType ruby nmap <buffer> gz <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby xmap <buffer> gz <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby imap <buffer> gz <Plug>(seeing-is-believing-mark)

    autocmd FileType ruby nmap <buffer> gZ <Plug>(seeing-is-believing-run)
  augroup END
" }}}
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'yaymukund/vim-rabl'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-jdaddy'
Plug 'Shougo/context_filetype.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" {{{
  let g:used_javascript_libs = 'jquery'
" }}}
Plug 'gavocanov/vim-js-indent'
Plug 'ap/vim-css-color'
Plug 'jimenezrick/vimerl'
" {{{
  let erlang_show_errors = 0
" }}}
Plug 'elixir-lang/vim-elixir'
Plug 'hynek/vim-python-pep8-indent'
Plug 'jvirtanen/vim-octave'
Plug 'lervag/vimtex'
" {{{
  let g:vimtex_view_method = 'zathura'
  augroup latex
    autocmd!
    autocmd FileType tex nnoremap <buffer><F5> :VimtexCompile<CR>
    autocmd FileType tex map <silent> <buffer><F8> :call vimtex#latexmk#errors_open(0)<CR>
  augroup END
" }}}

" Git
" ====================================================================
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
Plug 'idanarye/vim-merginal'
" {{{
  nnoremap <leader>gm :MerginalToggle<CR>
" }}}
Plug 'airblade/vim-gitgutter'
" {{{
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 200
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  let g:gitgutter_diff_args = '--ignore-space-at-eol'
  nmap <silent> ]h :GitGutterNextHunk<CR>
  nmap <silent> [h :GitGutterPrevHunk<CR>
  nnoremap <silent> <Leader>gu :GitGutterRevertHunk<CR>
  nnoremap <silent> <Leader>gp :GitGutterPreviewHunk<CR><c-w>j
  nnoremap cog :GitGutterToggle<CR>
  nnoremap <Leader>gt :GitGutterAll<CR>
" }}}
Plug 'esneider/YUNOcommit.vim'

" Utility
" ====================================================================
Plug 'lyokha/vim-xkbswitch'
" {{{
  let g:XkbSwitchEnabled = 1
  let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
  let g:XkbSwitchNLayout = 'us'
  let g:XkbSwitchILayout = 'us'

  function! RestoreKeyboardLayout(key)
    call system('xkb-switch -s us')
    execute 'normal! ' . a:key
  endfunction

  nnoremap <silent> р :call RestoreKeyboardLayout('h')<CR>
  nnoremap <silent> о :call RestoreKeyboardLayout('j')<CR>
  nnoremap <silent> л :call RestoreKeyboardLayout('k')<CR>
  nnoremap <silent> д :call RestoreKeyboardLayout('l')<CR>
" }}}
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/python2.7/*',
      \ '*/migrate/*.rb'
      \ ]
  let g:gutentags_generate_on_missing = 0
  let g:gutentags_generate_on_write = 0
  let g:gutentags_generate_on_new = 0
  nnoremap <leader>t! :GutentagsUpdate!<CR>
" }}}
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
" {{{
  let g:projectionist_heuristics = {}

  " Elixir Mix
  let g:projectionist_heuristics['mix.exs'] = {
      \   'lib/*.ex': {
      \     'alternate': 'test/{}_test.exs',
      \     'type': 'lib'
      \   },
      \   'test/*_test.exs': {
      \     'alternate': 'lib/{}.ex',
      \     'type': 'test'
      \   },
      \   'config/*.exs': {
      \     'type': 'config'
      \   },
      \   'mix.exs': {
      \     'type': 'mix'
      \   },
      \   '*_test.exs': {'dispatch': 'mix test {file}'},
      \   '*': {
      \     'dispatch': 'mix test',
      \     'console': 'iex'
      \   }
      \ }
" }}}
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'
" {{{
  function! TerminalSplitStrategy(cmd) abort
    tabnew | call termopen(a:cmd) | startinsert
  endfunction
  let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
  let g:test#custom_strategies.terminal_split = function('TerminalSplitStrategy')
  let test#strategy = 'terminal_split'

  nnoremap <silent> <leader>rr :TestFile<CR>
  nnoremap <silent> <leader>rf :TestNearest<CR>
  nnoremap <silent> <leader>rs :TestSuite<CR>
  nnoremap <silent> <leader>ra :TestLast<CR>
  nnoremap <silent> <leader>ro :TestVisit<CR>
" }}}
Plug 'tyru/open-browser.vim'
" {{{
  let g:netrw_nogx = 1
  vmap gx <Plug>(openbrowser-smart-search)
  nmap gx <Plug>(openbrowser-search)
" }}}
Plug 'Shougo/junkfile.vim'
" {{{
  nnoremap <leader>jo :JunkfileOpen 
  let g:junkfile#directory = $HOME . '/.nvim/cache/junkfile'
" }}}
Plug 'junegunn/vim-peekaboo'
" {{{
  let g:peekaboo_delay = 400
" }}}
Plug 'mbbill/undotree'
" {{{
  set undofile
  " Auto create undodir if not exists
  let undodir = expand($HOME . '/.nvim/cache/undodir')
  if !isdirectory(undodir)
    call mkdir(undodir, 'p')
  endif
  let &undodir = undodir

  nnoremap <F11> :UndotreeToggle<CR>
" }}}
Plug '907th/vim-auto-save'
" {{{
  nnoremap coa :AutoSaveToggle<CR>
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_events = ['CursorHold']
" }}}
Plug 'takac/vim-hardtime'
" {{{
  let g:hardtime_default_on = 0
  let g:hardtime_ignore_quickfix = 1
  let g:hardtime_ignore_buffer_patterns = ['netrw', 'help', 'gitcommit']
" }}}
"

" Misc
" ====================================================================
Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }
" {{{
  let g:calendar_date_month_name = 1
" }}}
Plug 'katono/rogue.vim', { 'on': 'Rogue' }
" {{{
  let g:rogue#name = 'zenbro'
  let g:rogue#directory = expand($HOME.'/.vim/rogue')
" }}}
call plug#end() " Plugins initialization finished {{{
" }}}

" General settings {{{
" ====================================================================
set clipboard=unnamed,unnamedplus
set number         " show line numbers
set relativenumber " use relative lines numbering by default
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse

set scrolloff=999       " always keep cursor at the middle of screen
set virtualedit=onemore " allow the cursor to move just past the end of the line
set undolevels=5000     " set maximum undo levels

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

set foldmethod=manual       " use manual folding
set diffopt=filler,vertical " default behavior for diff

" ignore pattern for wildmenu
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp
set wildmode=list:longest,full

set list " show hidden characters
set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines
" }}}
" Indentation {{{
" ====================================================================
set expandtab     " replace <Tab with spaces
set tabstop=2     " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)
" }}}
" Search {{{
" ====================================================================
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set gdefault   " when on, the :substitute flag 'g' is default on
" }}}
" Colors and highlightings {{{
" ====================================================================
colorscheme jellybeans
let g:lightline#colorscheme#jellybeans_mod#palette = lightline#colorscheme#flatten(s:p)

set cursorline     " highlight current line
set colorcolumn=80 " highlight column
highlight! ColorColumn ctermbg=233 guibg=#131313

" Various columns
highlight! SignColumn ctermbg=233 guibg=#0D0D0D
highlight! FoldColumn ctermbg=233 guibg=#0D0D0D

" Syntastic
highlight SyntasticErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
highlight SyntasticErrorLine guibg=#0D0D0D ctermbg=232
highlight SyntasticWarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
highlight SyntasticWargningLine guibg=#171717
highlight SyntasticStyleWarningSign guifg=black guibg=#bcbcbc ctermfg=16 ctermbg=250
highlight SyntasticStyleErrorSign guifg=black guibg=#ff8700 ctermfg=16 ctermbg=208

" Language-specific
highlight! link elixirAtom rubySymbol
" }}}
" Key Mappings " {{{
nnoremap <leader>vi :tabedit $MYVIMRC<CR>

" Toggle quickfix
map <silent> <F8> :copen<CR>

" Quick way to save file
nnoremap <leader>w :w<CR>

" Y behave like D or C
nnoremap Y y$

" Disable search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select all text
noremap vA ggVG

" Same as normal H/L behavior, but preserves scrolloff
nnoremap H :call JumpWithScrollOff('H')<CR>
nnoremap L :call JumpWithScrollOff('L')<CR>
function! JumpWithScrollOff(key) " {{{
  set scrolloff=0
  execute 'normal! ' . a:key
  set scrolloff=999
endfunction " }}}

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}
nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Same as above, except it opens unite at the end
nnoremap <silent> <Leader>h<Space> :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 1)<CR>
nnoremap <silent> <Leader>l<Space> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 1)<CR>
nnoremap <silent> <Leader>k<Space> :call JumpOrOpenNewSplit('k', ':leftabove split', 1)<CR>
nnoremap <silent> <Leader>j<Space> :call JumpOrOpenNewSplit('j', ':rightbelow split', 1)<CR>

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS>s :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G

" Universal closing behavior
nnoremap <silent> Q :call CloseSplitOrDeleteBuffer()<CR>
nnoremap <silent> Й :call CloseSplitOrDeleteBuffer()<CR>
function! CloseSplitOrDeleteBuffer() " {{{
  if winnr('$') > 1
    wincmd c
  else
    execute 'bdelete'
  endif
endfunction " }}}

" Delete all hidden buffers
nnoremap <silent> <Leader><BS>b :call DeleteHiddenBuffers()<CR>
function! DeleteHiddenBuffers() " {{{
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction " }}}
" }}}
" Terminal {{{
" ====================================================================
nnoremap <silent> <leader><Enter> :tabnew<CR>:terminal<CR>

" Opening splits with terminal in all directions
nnoremap <Leader>h<Enter> :leftabove  vnew<CR>:terminal<CR>
nnoremap <Leader>l<Enter> :rightbelow vnew<CR>:terminal<CR>
nnoremap <Leader>k<Enter> :leftabove  new<CR>:terminal<CR>
nnoremap <Leader>j<Enter> :rightbelow new<CR>:terminal<CR>


" Open tig
nnoremap <Leader>gg :tabnew<CR>:terminal tig<CR>

tnoremap <F1> <C-\><C-n>
tnoremap <C-\><C-\> <C-\><C-n>:bd!<CR>

function! TerminalInSplit(args)
  botright split
  execute 'terminal' a:args
endfunction

nnoremap <leader><F1> :execute 'terminal ranger ' . expand('%:p:h')<CR>
nnoremap <leader><F2> :terminal ranger<CR>
augroup terminalSettings
  autocmd!
  autocmd FileType ruby nnoremap <leader>\ :call TerminalInSplit('pry')<CR>
augroup END
" }}}
" Autocommands {{{
" ====================================================================
augroup vimGeneralCallbacks
  autocmd!
  autocmd BufWritePost .nvimrc nested source ~/.nvimrc
augroup END

augroup fileTypeSpecific
  autocmd!
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " JST support
  autocmd BufNewFile,BufRead *.ejs set filetype=jst
  autocmd BufNewFile,BufRead *.jst set filetype=jst
  autocmd BufNewFile,BufRead *.djs set filetype=jst
  autocmd BufNewFile,BufRead *.hamljs set filetype=jst
  autocmd BufNewFile,BufRead *.ect set filetype=jst

  " Gnuplot support
  autocmd BufNewFile,BufRead *.plt set filetype=gnuplot

  autocmd FileType jst set syntax=htmldjango
augroup END

augroup quickFixSettings
  autocmd!
  autocmd FileType qf
        \ nnoremap <buffer> <silent> q :close<CR> |
        \ map <buffer> <silent> <F4> :close<CR> |
        \ map <buffer> <silent> <F8> :close<CR>
augroup END

augroup terminalCallbacks
  autocmd!
  autocmd TermClose * call feedkeys('<cr>')
augroup END
"}}}
" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
