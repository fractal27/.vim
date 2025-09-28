""" PLUGINS

call plug#begin()

Plug 'rose-pine/vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'kien/ctrlp.vim'
Plug 'airline/vim-airline'

call plug#end()


call vimail#begin()

""" FILETYPE SPECIFIC STUFF
filetype on
"
" vimwiki
"
let g:vimwiki_list = [{ 'syntax': 'markdown', 
                      \ 'ext': 'md',
		      \ 'path': '~/notes'}]



"
" airline
"

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = '(lines)'
let g:airline_symbols.dirty='⚡'


""" LSP 


" map <C-K> :!python3 /usr/share/clang/clang-format-19/clang-format.py<cr>
" imap <C-K> <c-o>:!python3 /usr/share/clang/clang-format-19/clang-format.py<cr>


if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
		" autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
    augroup end
endif


"goto definition lsp
nmap gd :LspDefinition<CR>
nmap <C-d> :LspRename<CR>


map <leader> ,

"" default mappings
map <F1> <Esc>:e./Makefile<CR>
map <F2> <Esc>:!make<CR>
map <C-s> <Esc>:wq<CR>
map <C-c> <Esc>:q!<CR>
map <leader>q <Esc>:tabclose<CR>
map <leader>e <Esc>:tabnew<CR>
map <leader>d <Esc>:tabnext<CR>
map <leader>a <Esc>:tabprev<CR>
map <F9> <Esc>:!surf <C-r>"<CR><CR>
map <C-a> <Esc>:set wrap<CR>
nmap <Tab> i<C-n>
imap <S-Tab> <C-n>

" Disable arrow movement; resize splits instead.
for mode in ['n','i','v']
		exec mode.'noremap' '<up>' '<Esc>:resize +2<CR>'
		exec mode.'noremap' '<down>' '<Esc>:resize -2<CR>'
		exec mode.'noremap' '<left>' '<Esc>:vertical resize +2<CR>'
		exec mode.'noremap' '<right>' '<Esc>:vertical resize -2<CR>'
endfor

fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Start a new buffer ...
    enew

    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber

    " Now we can just write to the buffer, whatever you want.
    call append('$', "")
	for line in split(system('cat ~/.vim/start'), '\n')
        call append('$', '        ' . l:line)
    endfor

    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :CtrlP<CR>
    nnoremap <buffer><silent> c :e ~/.vimrc<CR>
endfun


" Run after "doing all the startup stuff"
autocmd VimEnter * call Start()




""appearence/settings

set nowrap
set tabstop=4
set nu
set ignorecase

colorscheme rosepine
syntax on
