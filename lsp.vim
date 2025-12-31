" --- vim lsp configuration ---

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
        autocmd user lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd filetype c setlocal omnifunc=lsp#complete
        autocmd filetype cpp setlocal omnifunc=lsp#complete
        autocmd filetype objc setlocal omnifunc=lsp#complete
        autocmd filetype objcpp setlocal omnifunc=lsp#complete
		" autocmd bufwritepre *.h,*.cc,*.cpp call formatonsave()
    augroup end
endif

if executable('gopls')
    augroup lsp_gopls
        autocmd!
        autocmd user lsp_setup call lsp#register_server({
                    \ 'name': 'gopls',
                    \ 'cmd': {server_info->['gopls']},
                    \ 'whitelist': ['go','mod'],
                    \ })
        autocmd filetype go setlocal omnifunc=lsp#complete
        autocmd filetype mod setlocal omnifunc=lsp#complete
		" autocmd bufwritepre *.h,*.cc,*.cpp call formatonsave()
    augroup end
endif

" jdtls
if executable('jdtls')
    augroup lsp_jtls
        autocmd!
        autocmd user lsp_setup call lsp#register_server({
                    \ 'name': 'java lsp',
                    \ 'cmd': {server_info->['jdtls']},
                    \ 'whitelist': ['java'],
                    \ })
        autocmd filetype java setlocal omnifunc=lsp#complete
    augroup end
endif

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
