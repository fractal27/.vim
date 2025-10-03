
hi clear eqsign
hi eqsign guifg=#ff0000 ctermfg=120


syn match eqsign  / -> /

" Apply to all filetypes
augroup custom_syntax
	autocmd!
	autocmd Syntax start_buffer syn match eqsign
augroup end
