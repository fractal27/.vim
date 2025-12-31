runtime! after/syntax/common.vim

hi clear cFunction

hi cFunction guifg=#ff0000 ctermfg=161

syn match cFunction "\<\h\w*\ze\_s*("
syn keyword CommonTypedefs i8 i16 i32 i64 u8 u16 u32 u64 f32 f64

hi def link CommonTypedefs Identifier

" Apply to all filetypes
augroup custom_syntax
	autocmd!
	autocmd Syntax c,cpp syn match cFunction 
	autocmd Syntax c,cpp syn match CommonTypedefs 
augroup end
