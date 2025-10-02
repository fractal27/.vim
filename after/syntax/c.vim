runtime! after/syntax/common.vim

hi clear cFunction

" Define the highlight with both GUI and terminal support
hi cFunction guifg=#ff0000 ctermfg=161

syn match cFunction "\<\h\w*\ze\_s*("

" Apply to all filetypes
augroup custom_syntax
	autocmd!
	autocmd Syntax c,cpp syn match cFunction
augroup end
