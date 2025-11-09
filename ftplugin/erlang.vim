
func! Compile_erlang()
	term erlc %
	" ./$$(basename % | echo \"${filename\%.*}")<CR>'
endfunc

map <F5> <Esc>:call Compile_erlang()<CR>


