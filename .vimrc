""" PLUGINS

call plug#begin()
	Plug 'tpope/vim-fugitive'		" 284K	rosepineb
	Plug 'rose-pine/vim'			" 284K	rosepine
	Plug 'prabirshrestha/vim-lsp'	" 1.5M	vim-lsp
	Plug 'dstein64/vim-menu'		" 2.4M	vim-menu
	Plug 'vimwiki/vimwiki'			" 6.7M	vimwiki
	"Tot 10.8M

call plug#end()

" this doesn't work for now(probably I don't know how to get it to work)
" call vimail#begin()
"
"" Global configuration

let g:project_directory = '~/Personal/repos'


""" FILETYPE SPECIFIC STUFF
filetype on
"au BufNewFile,BufRead *.nimble set filetype=nim
au BufWritePost *.go exec '!go build'

" vimwiki
"
let g:vimwiki_list = [{ 'syntax': 'markdown', 
                      \ 'ext': 'md',
		      \ 'path': '~/notes'}]

"
" Vim airline
"


if !exists('g:airline_symbols')
		let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' : '
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' line ' "" LINENR
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = '-'

let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'
let g:airline_section_d = '%{exec set ft}'

""" LSP 



"if executable('pyright')
"    augroup lsp_pyright
"        autocmd!
"        autocmd User lsp_setup call lsp#register_server({
"                    \ 'name': 'pyright',
"                    \ 'cmd': {server_info->['pyright']},
"                    \ 'whitelist': ['python'],
"                    \ })
"        autocmd FileType python setlocal omnifunc=lsp#complete
"		" autocmd BufWritePre *.py *.pyi call Formatonsave()
"    augroup end
"endif
"
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
fun! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		setlocal signcolumn=yes
		if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
		nmap <buffer> gd <plug>(lsp-definition)
		nmap <buffer> gs <plug>(lsp-document-symbol-search)
		nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
		nmap <buffer> gr <plug>(lsp-references)
		nmap <buffer> gi <plug>(lsp-implementation)
		nmap <buffer> gt <plug>(lsp-type-definition)
		nmap <buffer> <leader>rn <plug>(lsp-rename)
		nmap <buffer> [g <plug>(lsp-previous-diagnostic)
		nmap <buffer> ]g <plug>(lsp-next-diagnostic)
		nmap <buffer> K <plug>(lsp-hover)
		nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
		nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

		let g:lsp_format_sync_timeout = 1000
		autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunc

augroup lsp_install 
		autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"" default mappings

map , <leader>

noremap  <F1> <Esc>:e./Makefile<CR>
noremap  <F2> <Esc>:!make<CR>
noremap  <C-s> <Esc>:wq<CR>
noremap  <C-c> <Esc>:q!<CR>


noremap  <leader>q <Esc>:tabclose<CR>
noremap  <leader>e <Esc>:tabnew<CR>
noremap  <leader>f <Esc>:tabnext<CR>
noremap  <leader>d <Esc>:tabprev<CR>
nnoremap <C-k> :m-2==<CR>
nnoremap <C-j> :m+1==<CR>
vnoremap <C-k> :m-2==<CR>
vnoremap <C-j> :m+1==<CR>

noremap  <leader>g <Esc>==
nnoremap <leader>g q:avimgrep //ij **/* | copen<Esc>5ba
inoremap <leader>g <Esc><C-g>
vnoremap <leader>g <Esc><C-g>
cnoremap <leader>g vimgrep //ij **/* | copen<C-Left><C-Left><C-Left><C-Left><C-Left><Right>

noremap <leader>i <Esc>:Git

nnoremap <F9> <Esc>:!surf <C-r>"<CR><CR>
vnoremap <F9> y<Esc>:!surf <C-r>"<CR><CR>
inoremap <F9> yiw<Esc>:!surf <C-r>"<CR><CR>


for char_to_wrap in ['"',"'","`"]
		" wrap combinations
		" ,w" to wrap the selection or the word selected in \"double quotes"
		exec "nnoremap  <leader>w"..char_to_wrap.." ciw"..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
		exec "vnoremap  <leader>w"..char_to_wrap.." c"  ..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
		exec "inoremap  <leader>w"..char_to_wrap.." <Esc>ciw"..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
endfor
" Disable arrow movement; resize splits instead.
for mode in ['n','i','v']
		exec mode.'noremap' '<up>' '<C-w><up>'
		exec mode.'noremap' '<down>' '<C-w><down>'
		exec mode.'noremap' '<left>' '<C-w><left>'
		exec mode.'noremap' '<right>' '<C-w><right>'
endfor

fun! EnvSetup()
		exec '!git pull'
		let l:project_type = system('cat .project_type')
		if l:project_type == 'c_makefile'
				let l:entrypoint = 'main.c*'
		elseif l:project_type == 'c_cmake'
				let l:entrypoint = 'main.c*'
		elseif l:project_type == 'python'
				let l:entrypoint = '__main__.py'
		else
				let l:entrypoint = '.'
		endif

		exec 'e '.l:entrypoint
endfun

fun! UserInput(prompt)
		let curline = getline('.')
		call inputsave()
		let result = input(a:prompt)
		call inputrestore()
		return result
endfun

fun! Makeproj(project_type)
		if a:project_type != "c_automake" && a:project_type != "c_makefile" && a:project_type != "c_cmake" && a:project_type != "python"
				echoerr 'Project type not found:'.a:type
				return
		endif

		let l:project_name = UserInput('project name: ')
		exec '!mkdir '..g:project_directory..'/'..l:project_name
		exec 'cd '..g:project_directory..'/'..l:project_name
		exec '!echo '.a:project_type.'.project_type'

		if a:project_type == 'c_makefile'
				let l:entrypoint = 'main.c'
		elseif a:project_type == 'c_cmake'
				let l:entrypoint = 'main.c'
		elseif a:project_type == 'python'
				let l:entrypoint = '__main__.py'
		endif
		exec 'e '.l:entrypoint
		startinsert
endfun


fun! ProjectMenu()
		silent! source $VIMRUNTIME/menu.vim
		aunmenu *

		exec 'noremenu &New.&c-makefile <Esc>:call Makeproj("c_makefile")'
		exec 'noremenu &New.&c-automake <Esc>:call Makeproj("c_automake")'
		exec 'noremenu &New.&c-cmake    <Esc>:call Makeproj("c_cmake")'
		exec 'noremenu &New.&python     <Esc>:call Makeproj("python")'

		for project in split(system('ls --color=never -1 '.g:project_directory),'\n')
				let l:enviroment_setup	= '&'.."'".l:project."'.&Enviroment"
				let l:build_menu 		= '&'.."'".l:project."'.&Build"
				let l:reinstall_menu	= '&'.."'".l:project."'.&Reinstall"
				let l:project_path		= g:project_directory.'/'.project
				" noremenu &Project.&Build :echo<cr>
				" noremenu &Project.&Reinstall :echo<cr>
				exec 'noremenu '.l:enviroment_setup.' <Esc>:cd '..l:project_path..'<CR>:call EnvSetup()<CR><CR>'
				exec 'noremenu '.l:build_menu.' <Esc>:make -C '..l:project_path..'<CR><CR'
				exec 'noremenu '.l:reinstall_menu.' <Esc>:make install -C '..l:project_path..'<CR><CR>'
		endfor

		" let s:menu_vimscript = function(menu#Sid() . 'ParseMenuVimScript')('n')
		Menu
endfun


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
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> c :e ~/.vimrc<CR>
    nnoremap <buffer><silent> p :call ProjectMenu()<CR>
    nnoremap <buffer><silent> d :VimwikiDiaryIndex<CR>
    nnoremap <buffer><silent> w :VimwikiIndex<CR>
    nnoremap <buffer><silent> g :tab Git<CR>
    nnoremap <buffer><silent> q :q<CR>
endfun

" Run after "doing all the startup stuff"

autocmd VimEnter * call Start()
autocmd Syntax * runtime! after/syntax/common.vim




""appearence/settings


set nowrap
set nu
set ignorecase

set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab
set modeline
set hlsearch
colorscheme rosepine
syntax on
