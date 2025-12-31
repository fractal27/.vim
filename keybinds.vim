" keybinds

map , <leader>

for char_to_wrap in ['"',"'","`"]
		" wrap combinations
		" ,w" to wrap the selection or the word selected in \"double quotes"
		exec "nnoremap  <leader>w"..char_to_wrap.." ciw"..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
		exec "vnoremap  <leader>w"..char_to_wrap.." c"  ..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
		exec "inoremap  <leader>w"..char_to_wrap.." <Esc>ciw"..char_to_wrap.."<Esc>pa"..char_to_wrap.."<Esc>"
endfor
" " Disable arrow movement; resize splits instead.
" for mode in ['n','i','v']
" 		exec mode.'noremap' '<up>' '<C-w><up>'
" 		exec mode.'noremap' '<down>' '<C-w><down>'
" 		exec mode.'noremap' '<left>' '<C-w><left>'
" 		exec mode.'noremap' '<right>' '<C-w><right>'
" endfor
" 

noremap  <F1> <Esc>:e./Makefile<CR>
noremap  <F2> <Esc>:!make<CR>
noremap  <C-s> <Esc>:wq<CR>
noremap  <C-c> <Esc>:q!<CR>


noremap  <leader>q <Esc>:tabclose<CR>
noremap  <leader>e <Esc>:tabnew<CR>
noremap  <leader>n <Esc>:tabnext<CR>
noremap  <leader>p <Esc>:tabprev<CR>

nnoremap <C-k> :m-2==<CR>
nnoremap <C-j> :m+1==<CR>
vnoremap <C-k> :m-2==<CR>
vnoremap <C-j> :m+1==<CR>

noremap <leader>ff <Esc>:Files<CR>
noremap <leader>fc <Esc>:Rg<CR>
noremap <leader>fq <Esc>:History<CR>

nnoremap <leader>gz q:avimgrep //ij **/* | copen<Esc>5ba
noremap <leader>gg <Esc>:call VimGrepExec()<CR>

" nnoremap <leader>f :call VimGrepExec()<CR>
inoremap <C-f> <Esc><leader>f

noremap <leader>h <Esc>:Git<CR>

nnoremap <F9> <Esc>:!surf <C-r>"<CR><CR>
vnoremap <F9> y<Esc>:!surf <C-r>"<CR><CR>
inoremap <F9> yiw<Esc>:!surf <C-r>"<CR><CR>

