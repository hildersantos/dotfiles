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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic']
Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
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
colorscheme nord
let g:one_allow_italics = 1

" ===============================================================
" General Options
" ===============================================================

set hidden
set nobackup
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
set expandtab
set tabstop=2
set softtabstop=2
" Copy text to clipboard, always
set clipboard+=unnamedplus
" Table width (for line wrapping)
set tw=80
" Format options
set fo?
set fo+=cl


" ===============================================================
" Plugins Options
" ===============================================================

" ***********************************
" Airline
" ***********************************
let g:airline#extensions#branch#enabled = 1

" ***********************************
" coc-nvim
" ***********************************

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
let g:mapleader=','
" Double backslash for local leader
let g:maplocalleader='\\'
" Stop highlighting on Enter
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" Show me those buffers
nnoremap <leader>l :ls<cr>:b<space>
nnoremap <leader><TAB> :e#<CR>
" Move arround panels with Ctrl+HJKL
noremap <C-H> <C-W><Left>
noremap <C-K> <C-W><Up>
noremap <C-J> <C-W><Down>
noremap <C-L> <C-W><Right>
" Terminal
tnoremap <ESC> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" Sort lists
vnoremap <Leader>s :sort<CR>

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
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
command! -nargs=0 Format :call CocAction('format')

" ***********************************
" NerdTREE
" ***********************************

nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" ***********************************
" Dash
" ***********************************

nmap <silent> <leader>d <Plug>DashSearch
