hi clear note_to_self
hi arrow ctermfg=Red ctermbg=NONE guifg=#FF0000 guibg=NONE
hi grave_enclosed ctermfg=Yellow ctermbg=NONE guifg=#FFFF00 guibg=NONE

syn match arrow 			/->/
syn match grave_enclosed 	/\[ .* \]/

" Apply to all filetypes
augroup custom_syntax
	autocmd!
	autocmd Syntax start_buffer syn match arrow
	autocmd Syntax start_buffer syn match grave_enclosed
augroup END
