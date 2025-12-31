"" utility functions

function! QuickInput(prompt) abort
	let s:si=&t_SI|let s:ei=&t_EI|set t_SI= t_EI=
	let s:gc=&guicursor|if has('gui_running')|set guicursor=n-v-c:block-Cursor,i:none|endif
	let r= input(a:prompt)
	let &t_SI=s:si|let &t_EI=s:ei|let &guicursor=s:gc
	return r
endfunction

function! VimGrepExec() 
	let l:choices = [
				\ '**/*',
				\ '`find . -type f ! -executable`',
				\ '**/*.html',
				\ '**/*.[ch]',
				\ '**/*.c']
	let l:filter = input("Quickfix filter:")
	let l:fileglob = inputlist(l:choices)
	exec 'vimgrep /'..l:filter..'/ij '..l:choices[l:fileglob]..' | copen'
endfunction

function! NewFile()
	let l:filename = input("Filename:")
	exec ':enew '..l:filename..'<CR><CR>:w'
endfunction
