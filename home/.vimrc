syntax on
set ts=4 sw=4 is autoindent et modeline title
set backspace=indent,eol,start
set enc=utf-8
" Buggy in MacVim
if !has("gui_macvim")
    set cpoptions=$
endif

if !exists("homesick")
    let homesick = $HOME . "/.homesick"
endif

filetype off
let &runtimepath = &runtimepath . "," . homesick . "/repos/vundle"
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'altercation/vim-colors-solarized'
Plugin 'elzr/vim-json'
Plugin 'dracula/vim'

" Support for ES2015, among other things
" See https://davidosomething.com/blog/vim-for-javascript/
Plugin 'othree/yajs'

" Usage - :JSHint
Plugin 'Shutnik/jshint2.vim'

call vundle#end()

filetype plugin indent on

set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set hidden        " Leave hidden buffers open
set history=100

set nospell

set mousemodel=popup_setpos browsedir=buffer
set ttimeoutlen=100        " http://stackoverflow.com/a/2158610/25507

if has("win32")
    set gfn=Consolas:h11:cANSI

    " VIM's default:
    " set dir=.,c:\\tmp,c:\\temp
    " My change:  (because Windows 7 rearranges folder windows whenever a .swp
    " is added):
    set dir=c:\\tmp,c:\\temp
endif

if !has('gui_running')
    " Disable X clipboard to not slow down by trying to connect to an X server.
    set clipboard=exclude:.*
endif

function ColorColumn()
    if v:version >= 703 && has('gui_running')
        setlocal colorcolumn=100
    endif
endfunction

" Let % match, e.g., HTML tags
source $VIMRUNTIME/macros/matchit.vim

" Enable spell checking for human-readable documents.
" Disabled for now in favor of blanket statement above.
"au FileType html set spell

au FileType python set et
" au FileType python set et | exec ColorColumn()

autocmd BufEnter *.html :syntax sync fromstart
autocmd BufEnter *.htm :syntax sync fromstart

" Enable viminfo to remember certain things when we exit.
set viminfo='10,\"100,:20,%,n~/.viminfo
" Use viminfo to restore last line when reopening a file
" vim.wikia.com has a fancier, longer version.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

hi ColorColumn guibg=#eeeeee

" Default ctermbg=1 red background for unrecognized words is very loud.
" Try something less obtrusive.
hi SpellBad cterm=underline ctermbg=none
hi SpellRare cterm=none ctermbg=none
hi SpellCap cterm=none ctermbg=none

if has('gui_running')
    colorscheme darkblue
else
    colorscheme default
end
set background=dark

if has('gui_running')
    if exists("+lines")
      set lines=53
    endif
    if exists("+columns")
      set columns=120
    endif
    winpos 1900 50
endif

set number

" Note: <leader> sequence is '\\' (two backslashes)
map <leader>rr :source ~/.vimrc<CR>

" Map Ctrl-Left and Ctrl-Right to :prev (previous file) and :next (next file),
" respectively
if !has('gui_running') && !has('terminal')
    map  <Esc>[D <Esc>:prev<CR>
    map  <Esc>[C <Esc>:next<CR>
    map! <Esc>[D <Esc>:prev<CR>
    map! <Esc>[C <Esc>:next<CR>
    nmap <Esc>[D :prev<CR>
    nmap <Esc>[C :next<CR>
else
    map <C-Left> <Esc>:prev<CR>
    map <C-Right> <Esc>:next<CR>
endif

" Map Ctrl-Up and Ctrl-Down to Ctrl-y and Ctrl-e, respectively (scroll
" up/down a line at a time)
if !has('gui_running') && !has('terminal')
    map  <Esc>[A <C-y>
    map  <Esc>[B <C-e>
    map! <Esc>[A <C-y>
    map! <Esc>[B <C-e>
    nmap <Esc>[A <C-y>
    nmap <Esc>[B <C-e>
else
    map <C-Up> <C-y>
    map <C-Down> <C-e>
endif

" Toggles "paste mode' (no autoindent)
" http://nvie.com/posts/how-i-boosted-my-vim/
map <F2> :set invpaste paste?<CR>
map <leader>p :set invpaste paste?<CR>

" Toggle highlight search
map <F3> :set invhlsearch hlsearch?<CR>
map <leader>sp :set invhlsearch hlsearch?<CR>

" Toggle word wrap
map <F4> :set invwrap wrap?<CR>
map <leader>ww :set invwrap wrap?<CR>

" Toggle line numbers
map <F5> :set invnumber number?<CR>
map <leader>num :set invnumber number?<CR>

" Toggle background
map <F6> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
map <leader>bg :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" Toggle spell check
map <F7> :set invspell spell?<CR>
map <leader>sp :set invspell spell?<CR>

" Toggle whitespace
map <F8> :ToggleWhitespace<CR>
map <leader>ws :ToggleWhitespace<CR>

" Reformat JSON
map <leader>json :%!python -m json.tool<CR>

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
    let l:modeline = printf(" vim: ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Customize ntpeters/vim-better-whitespace: don't complain for diffs
let g:better_whitespace_filetypes_blacklist=['diff']

" Customize elzr/vim-json: don't hide double quotes
"let g:vim_json_syntax_conceal = 0

" Other useful resources:
" http://vim.wikia.com/wiki/Example_vimrc
" https://gist.github.com/ben336/4e4bc44d8135cfc43fc3
" http://benmccormick.org/2014/07/14/learning-vim-in-2014-configuring-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://robots.thoughtbot.com/faster-grepping-in-vim
" http://statico.github.io/vim.html
" http://tuxdiary.com/2015/02/15/yavide/

" To share with Windows gVim, create %HOMEPATH%/_vimrc with these contents:
" set runtimepath+=c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vim
" source c:/cygwin/home/Josh/.homesick/repos/dotfiles/home/.vimrc

