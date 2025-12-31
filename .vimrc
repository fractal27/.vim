""" PLUGINS

call plug#begin()
	" looks
	Plug 'tribela/vim-transparent'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'tpope/vim-fugitive'

	" lsp
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'

	" utility
	Plug 'dstein64/vim-menu'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'vimwiki/vimwiki' 
call plug#end()

"" Global configuration

let g:base_vim = '~/.vim'
let g:project_directory = '~/Personal/repos'
let g:make_command = "make -B"
let g:vimwiki_list = [{ 'syntax': 'markdown', 
                      \ 'ext': 'md',
		      \ 'path': '~/notes'}]
"au BufNewFile,BufRead *.nimble set filetype=nim
au BufWritePost *.go exec '!go build'

let g:files = [ g:base_vim.'/functions.vim',
			  \ g:base_vim.'/keybinds.vim', 
			  \ g:base_vim.'/projects.vim',
			  \ g:base_vim.'/lsp.vim'
			  \ ]

for file in g:files
	exec 'source '..file
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
	setlocal ft=start_buffer

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :call NewFile()<CR>
    nnoremap <buffer><silent> c :Files g:base_vim<CR>
    nnoremap <buffer><silent> sf :Files<CR>
    nnoremap <buffer><silent> sc :Rg<CR>
    nnoremap <buffer><silent> p :call ProjectMenu()<CR>
    nnoremap <buffer><silent> d :VimwikiDiaryIndex<CR>
    nnoremap <buffer><silent> w :VimwikiIndex<CR>
    nnoremap <buffer><silent> g :tab Git<CR>
    nnoremap <buffer><silent> h :History<CR>
    nnoremap <buffer><silent> q :q<CR>
endfun

" Run after "doing all the startup stuff"

autocmd VimEnter * call Start()
autocmd Syntax * runtime! after/syntax/common.vim




""appearence/settings
filetype on

set nowrap
set nu
set ignorecase

set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab
set modeline
set hlsearch

colorscheme tokyonight
syntax on
