setlocal expandtab
setlocal shiftwidth=7
"map <buffer> <F5> <C-o>:!gcc -o %.out % $LIBS<CR>
map <F3> <Esc>yiw:!man <C-r>"<CR>

imap  <leader>c I// <Esc><C-o>i
vmap  <leader>c :norm I// <CR>
nmap  <leader>c I// <Esc>

imap  <leader>v <Esc>^3x<C-o>i
vmap  <leader>v :norm ^3x<CR>
nmap  <leader>v ^3x<C-o>


