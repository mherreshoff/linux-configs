set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch

"Light blue comments, easier to read.
highlight Comment ctermfg=6

imap jj <Esc>

let mapleader=" "
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e
nnoremap <Leader>v :vsplit
nnoremap <Leader>s :split
nnoremap <Leader>n :set invnumber<CR>

nnoremap <Leader>p "+p

" Window switch commands:
nnoremap <Leader><TAB> <C-w><C-w>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Window moving commands:
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

" Window resize commands:
nnoremap <Leader>, 4<C-w><<C-l>
nnoremap <Leader>. 4<C-w>><C-l>
nnoremap <Leader>- 4<C-w>-<C-l>
nnoremap <Leader>= 4<C-w>+<C-l>
" <C-l> is here because sometimes screen doesn't do the right thing on
" sub-window resizes so we need to repaint.


map <Leader>y :w !xclip -sel clip<CR>
" Yank the current vi buffer into the X11 clipboard

nnoremap <Leader>s !}sort<CR>
"Sort current block

map <Leader>i :s/\//./g<CR>Iimport<Space><Esc>A;<Esc>

ab sop System.out.println("
ab dsh ---------

