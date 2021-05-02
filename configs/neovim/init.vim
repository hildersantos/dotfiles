" Borrowed from Daniel Cherubini
" https://gitlab.com/danielcherubini/dotfiles/-/blob/master/nvim/init.vim
" let $VIMUSERRUNTIME = fnamemodify($MYVIMRC, ':p:h')

" source $VIMUSERRUNTIME/plugins.vim

" Autoinstall / load plugins
if empty(glob(stdpath('config') . '/plugged'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===============================================================
" Plugins
" ===============================================================

call plug#begin(stdpath('config') . '/plugged')
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Build the extra binary if cargo exists on your system.
" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'dyng/ctrlsf.vim'
Plug 'rizzatti/dash.vim'
" Remember to install a compatible NerdFont before installing
" this. A way is by using brew:
" `brew tap homebrew/cask-fonts`
" `brew cask install font-hack-nerd-font`
Plug 'ryanoasis/vim-devicons'
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic', 'coc-snippets', 'coc-rls']
Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'ntk148v/vim-horizon'
" Plug 'ptzz/lf.vim'
" Plug 'voldikss/vim-floaterm'
call plug#end()

" ===============================================================
" Theming
" ===============================================================

syntax enable

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
" endif

" set background=dark
colorscheme horizon
let g:one_allow_italics = 1

" ===============================================================
" General Options
" ===============================================================

set hidden
set nobackup
set autochdir
set mouse=a
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
" Set relative line numbers when not editing
" Borrowed from https://jeffkreeftmeijer.com/vim-number/
set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set title
" set cmdheight=2
set shiftwidth=2
set showmatch
set expandtab
set tabstop=2
set softtabstop=2
" Copy text to clipboard, always
set clipboard+=unnamedplus
" Table width (for line wrapping)
set tw=80
" Format options
" set fo?
 set fo+=o
 set nojoinspaces
 set splitbelow
 set splitright

 " Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Leader Key
nnoremap <SPACE> <Nop>
let g:mapleader=" "
" ===============================================================
" Plugins Options
" ===============================================================

" ***********************************
" Airline
" ***********************************
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
" let g:airline_left_sep = ' '
" let g:airline_left_alt_sep = '|'
" let g:airline_right_sep = ' '
" let g:airline_right_alt_sep = '|'

" ***********************************
" coc-nvim
" ***********************************
"
" ***********************************
" CtrlP
" ***********************************
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" ***********************************
" CtrlSF
" ***********************************
let g:ctrlsf_default_root = 'project'

" ***********************************
" NERDTree
" ***********************************
let g:NERDTreeGitStatusUseNerdFonts = 1
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTreeVCS' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" ***********************************
" emmet-vim
" ***********************************
let g:user_emmet_settings = {
      \  'eelixir' : {
      \    'extends' : 'html',
      \  }
      \}

" ***********************************
" ElixirLS + coc.nvim
" Credits: https://bernheisel.com/blog/vim-elixir-ls-plug/
" ***********************************
let g:ElixirLS = {}
let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
let ElixirLS.cmd = join([
        \ 'asdf reshim &&',
        \ 'asdf install &&',
        \ 'mix do',
        \ 'local.hex --force --if-missing,',
        \ 'local.rebar --force,',
        \ 'deps.get,',
        \ 'compile,',
        \ 'elixir_ls.release'
        \ ], ' ')

function ElixirLS.on_stdout(_job_id, data, _event)
  let self.output[-1] .= a:data[0]
  call extend(self.output, a:data[1:])
endfunction

let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

function ElixirLS.on_exit(_job_id, exitcode, _event)
  if a:exitcode[0] == 0
    echom '>>> ElixirLS compiled'
  else
    echoerr join(self.output, ' ')
    echoerr '>>> ElixirLS compilation failed'
  endif
endfunction

function ElixirLS.compile()
  let me = copy(g:ElixirLS)
  let me.output = ['']
  echom '>>> compiling ElixirLS'
  let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
endfunction

" If you want to wait on the compilation only when running :PlugUpdate
" then have the post-update hook use this function instead:

" function ElixirLS.compile_sync()
"   echom '>>> compiling ElixirLS'
"   silent call system(g:ElixirLS.cmd)
"   echom '>>> ElixirLS compiled'
" endfunction

" Then, update the Elixir language server
call coc#config('elixir', {
  \ 'command': g:ElixirLS.lsp,
  \ 'filetypes': ['elixir', 'eelixir']
  \})
call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)


" ===============================================================
" Keybindings
" ===============================================================

" ***********************************
" General
" ***********************************

" Use comma for leader
" Double backslash for local leader
" let g:maplocalleader='\\'
" Create directories for new files
nnoremap <silent> <leader>c :! mkdir -p %:h<CR> 
" Stop highlighting on Enter
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" Show me those buffers
nnoremap <Leader>bl :ls<cr>:b<space>
nnoremap <Leader><TAB> :e#<CR>
" Buff deletion
" nnoremap <Leader>bd :bdelete<CR>
" nnoremap <Leader>b<S-D> :BufOnly<CR>
" Move arround panels with Ctrl+HJKL
"noremap <C-H> <C-W><Left>
"noremap <C-K> <C-W><Up>
"noremap <C-J> <C-W><Down>
"noremap <C-L> <C-W><Right>
" Move around buffers
nnoremap <silent><C-h> :bprevious<CR>
nnoremap <silent><C-l> :bnext<CR>
nnoremap <silent><C-x> :bp <BAR> bd #<CR>
" Terminal
tnoremap <ESC> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
nnoremap <silent><Leader>t :tabnew <BAR> term<CR>
" Sort lists
vnoremap <Leader>s :sort<CR>
command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')
command! BufOnly execute '%bdelete|edit #|normal `"'
" Use ; for commands.
nnoremap ; :
" Use Q to execute default register.
nnoremap Q @q
" ***********************************
" CtrlSF
" ***********************************

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" ***********************************
" FZF
" ***********************************
nmap <C-P> :Files<CR>
" Search pattern across repository files
function! FzfExplore(...)
    let inpath = substitute(a:1, "'", '', 'g')
    if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
        let cwpath = getcwd() . '/'
        call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))

" ***********************************
" Coc.Nvim
" ***********************************

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType elixir setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl <Plug>(coc-codelens-action)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <Leader>cr <Plug>(coc-rename)

" Remap for format selected region
xmap <Leader>cf  <Plug>(coc-format-selected)
nmap <Leader>cf  <Plug>(coc-format-selected)
" Using CocList
" Show all diagnostics
nnoremap <silent> <Leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <Leader>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <Leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <Leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <Leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>cp  :<C-u>CocListResume<CR>
command! -nargs=0 Format :call CocAction('format')

" ***********************************
" NerdTREE
" ***********************************

nnoremap <silent><C-t> :NERDTreeToggleVCS<CR>

" ***********************************
" LF
" ***********************************
" let g:lf_replace_netrw = 1 " Open lf when vim opens a directory

" ***********************************
" Dash
" ***********************************

nmap <silent> <leader>d <Plug>DashSearch
