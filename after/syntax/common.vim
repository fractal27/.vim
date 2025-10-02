hi clear note_to_self
hi clear Todo

" Define the highlight with both GUI and terminal support
hi note_to_self guifg=#ff0000 ctermfg=120
hi todo_self guifg=#ff0000 ctermfg=120
hi Todo ctermfg=Red ctermbg=NONE guifg=#FF0000 guibg=NONE


syn match note_to_self  /\<NTS\>/			   contains=@NoSpell	containedin=.*Comment.*
syn match Todo 			/\v<(TODO|FIXME|NOTE)/ containedin=Comment

" Apply to all filetypes
augroup custom_syntax
	autocmd!
	autocmd Syntax * syn match note_to_self
	autocmd Syntax * syn match Todo
augroup END
