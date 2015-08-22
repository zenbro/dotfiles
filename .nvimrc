filetype plugin indent on

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
Plug 'bling/vim-airline'
" {{{
  let g:airline_left_sep  = '▓▒░'
  let g:airline_right_sep = '░▒▓'
  let g:airline_section_z = '%2p%% %2l/%L:%2v'
  let g:airline#extensions#syntastic#enabled = 0
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline_exclude_preview = 1

  " Tabline
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
" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'unite', 'rogue']
  autocmd! TermOpen * IndentGuidesDisable
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
Plug 'mhinz/vim-startify'
" {{{
  let g:startify_session_dir = '~/.nvim/session'
  let g:startify_list_order = ['sessions']
  let g:startify_session_persistence = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_change_to_vcs_root = 1
  let g:startify_custom_footer =
    \ map(split(system('fortune.rb'), '\n'), '"   ". v:val') + ['','']
  nnoremap <F12> :Startify<CR>
  autocmd! User Startified setlocal colorcolumn=0
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
" ====================================================================
Plug 'Shougo/deoplete.nvim'
" {{{
  let g:deoplete#enable_at_startup = 1
" }}}
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet'
" {{{
  let g:neosnippet#snippets_directory = '~/.nvim/snippets'
  let g:neosnippet#data_directory = $HOME . '/.nvim/cache/neosnippet'
  let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

  nnoremap <leader>se :NeoSnippetEdit -split<CR>
  nnoremap <leader>sc :NeoSnippetClearMarkers<CR>

  imap <expr><TAB> neosnippet#expandable() ?
        \ "\<Plug>(neosnippet_expand)"
        \ : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable() ?
        \ "\<Plug>(neosnippet_expand)"
        \ : "\<TAB>"

  " jump to the next snippet trigger or move to the right split
  nmap <expr><C-l> neosnippet#jumpable() ?
        \ ":call feedkeys('i<C-l>')<CR>"
        \ : ":diffupdate<CR>:redraw!<CR>"
  " jump to the next snippet trigger or redraw a screen
  " (default <C-l> behaviour in normal mode)
  imap <expr><C-l> neosnippet#jumpable() ?
        \ "\<Plug>(neosnippet_jump)"
        \ : "<ESC>:redraw!<CR>a"
  smap <expr><C-l> neosnippet#jumpable() ?
        \ "\<Plug>(neosnippet_jump)" :
        \ "\<C-l>"
  xmap <C-l> <Plug>(neosnippet_expand_target)
" }}}

" File Navigation
" ====================================================================
Plug 'Shougo/unite.vim'
" {{{
  let g:unite_data_directory = $HOME . '/.nvim/cache/unite'
  let g:unite_split_rule = 'botright'
  let g:unite_winheight = 15
  let g:unite_force_overwrite_statusline = 0
  let g:unite_source_rec_max_cache_files = 1000
  let g:unite_source_grep_max_candidates = 200

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup --smart-case'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_search_word_highlight = 1
    " Using ag as recursive command.
    let g:unite_source_rec_async_command =
          \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
  endif

  autocmd FileType unite call s:UniteSettings()
  function! s:UniteSettings()
    nmap <silent><buffer> ; <Plug>(unite_quick_match_default_action)
    imap <silent><buffer> ; <Plug>(unite_quick_match_default_action)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-s> unite#do_action('vsplit')
  endfunction

  nnoremap <silent> <leader><space> :<C-u>Unite -toggle -smartcase -start-insert buffer file_rec/neovim:!<CR>
  nnoremap <silent> <leader>b :<C-u>Unite buffer -start-insert<cr>
  nnoremap <silent> <leader>o :<C-u>Unite outline -start-insert<cr>
  nnoremap <silent> <leader>/ :<C-u>Unite -no-quit -keep-focus grep:.<cr>
  nnoremap <silent> <leader>? :<C-u>Unite -no-quit -keep-focus grep:$buffers<cr>
  nnoremap <silent> <leader>. :<C-u>Unite -no-quit -keep-focus grep:%<cr>
  nnoremap <silent> K :<C-u>UniteWithCursorWord -no-quit -keep-focus grep:.<cr>
" }}}
Plug 'Shougo/unite-outline'
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
Plug 'tomtom/tcomment_vim'
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
  let g:syntastic_ignore_files          = ['\.py$']
  let g:syntastic_vim_checkers          = ['vint']
  let g:syntastic_elixir_checkers       = ['elixir']
  let g:syntastic_enable_elixir_checker = 0

" Rubocop Settings {{{
  let g:syntastic_ruby_rubocop_exec = '~/.rubocop.sh'
  let g:syntastic_ruby_rubocop_args = '--display-cop-names --rails'

  function! RubocopAutoCorrection()
    echo 'Starting rubocop autocorrection...'
    cexpr system('rubocop -D -R -f emacs -a ' . expand(@%))
    edit
    SyntasticCheck rubocop
    copen
  endfunction
" }}}
" Elixir Settings {{{
  function! ElixirCheck()
    let g:syntastic_enable_elixir_checker = 1
    SyntasticCheck elixir
    let g:syntastic_enable_elixir_checker = 0
  endfunction
" }}}

  augroup syntasticCustomCheckers
    autocmd!
    autocmd FileType ruby nnoremap <leader>` :SyntasticCheck rubocop<CR>
    autocmd FileType ruby nnoremap <leader>! :call RubocopAutoCorrection()<CR>
    autocmd FileType sh nnoremap <leader>` :SyntasticCheck shellcheck<CR>
    autocmd FileType elixir nnoremap <leader>` :call ElixirCheck()<CR>
  augroup END

  nnoremap <Leader>~ :SyntasticReset<CR>
" }}}
Plug 'mattn/emmet-vim'
" {{{
  let g:user_emmet_expandabbr_key = '<c-e>'
" }}}
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
Plug 'tpope/vim-liquid'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" {{{
  let g:used_javascript_libs = 'jquery'
" }}}
Plug 'ap/vim-css-color'
Plug 'jimenezrick/vimerl'
" {{{
  let erlang_show_errors = 0
" }}}
Plug 'elixir-lang/vim-elixir'

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
Plug 'Shougo/vimproc', { 'do' : 'make' }
Plug 'janko-m/vim-test'
" {{{
  function! TerminalSplitStrategy(cmd) abort
    botright new | call termopen(a:cmd) | startinsert
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
  let g:openbrowser_default_search = 'duckduckgo'
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

call unite#custom#source('buffer,file,file/new,file_rec/neovim',
      \ 'matchers', ['converter_relative_word', 'matcher_fuzzy'])
call unite#custom#source('buffer,file,file/new,file_rec/neovim,outline',
      \ 'sorters', 'sorter_rank')
call unite#custom#source('outline', 'matchers', ['matcher_fuzzy'])
" }}}

" General settings {{{
" ====================================================================
syntax on " syntax highlighting

set clipboard=unnamed,unnamedplus
set number     " show line numbers
set noswapfile " disable creating of *.swp files
set hidden     " hide buffers instead of closing
set lazyredraw " speed up on large files
set mouse=     " disable mouse

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

set list " show hidden characters
set listchars=tab:•·,trail:·,extends:❯,precedes:❮,nbsp:×

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

set splitbelow
set splitright
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

set cursorline     " highlight current line
set colorcolumn=80 " highlight column
highlight! ColorColumn ctermbg=233 guibg=#131313

" Various columns
highlight! SignColumn ctermbg=233 guibg=#0D0D0D
highlight! FoldColumn ctermbg=233 guibg=#0D0D0D

" Syntastic
highlight! SyntasticErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
highlight! SyntasticErrorLine guibg=#0D0D0D ctermbg=232
highlight! SyntasticWarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11
highlight! SyntasticWargningLine guibg=#171717
highlight! SyntasticStyleWarningSign guifg=black guibg=#bcbcbc ctermfg=16 ctermbg=250
highlight! SyntasticStyleErrorSign guifg=black guibg=#ff8700 ctermfg=16 ctermbg=208

" Language-specific
highlight! link elixirAtom rubySymbol
" }}}
" Key Mappings " {{{
nnoremap <leader>vi :tabedit $MYVIMRC<CR>

" Jump to beginning/end of the line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

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

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, unite) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:unite
      Unite -toggle -smartcase -start-insert buffer file_rec/async:!
    endif
  else
    if a:unite
      Unite -toggle -smartcase -start-insert buffer file_rec/async:!
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
" Netrw {{{
" ====================================================================
map <F1> :Explore<CR>
map <F2> :edit .<CR>

let g:netrw_banner = 0 " disable netrw banner with
let g:netrw_hide   = 1 " show not-hidden files by default
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles

function! s:NetrwCustomSettings()
  setlocal nolist
  map <buffer> <F1> :Rexplore<CR>
  map <buffer> <F2> :Rexplore<CR>
  nmap <buffer> l <CR>
  nmap <buffer> h -
  nnoremap <buffer> ~ :edit ~/<CR>
  nnoremap <buffer> <silent> q :Rexplore<CR>
endfunction

augroup enterNetrw
  autocmd!
  autocmd FileType netrw call s:NetrwCustomSettings()
augroup END
" }}}
" Autocommands {{{
" ====================================================================
augroup vimGeneralCallbacks
  autocmd!
  autocmd VimEnter * call system('i3-msg border none')
  autocmd VimLeave * call system('i3-msg border normal')
  autocmd BufWritePost .nvimrc source ~/.nvimrc | AirlineRefresh
augroup END

augroup fileTypeSpecific
  autocmd!
  " Rabl support
  autocmd BufRead,BufNewFile *.rabl setfiletype ruby
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " JST support
  autocmd BufNewFile,BufRead *.ejs set filetype=jst
  autocmd BufNewFile,BufRead *.jst set filetype=jst
  autocmd BufNewFile,BufRead *.djs set filetype=jst
  autocmd BufNewFile,BufRead *.hamljs set filetype=jst
  autocmd BufNewFile,BufRead *.ect set filetype=jst
  autocmd FileType jst set syntax=htmldjango
augroup END
"}}}
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
