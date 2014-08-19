" Copyright © 2014 Grimy <Victor.Adam@derpymail.org>
" This work is free software. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See the LICENCE file for more details.

let g:cursor = "\u2038"

command! -range=% SubliminalStart  call subliminal#main()
command! -range=% SubliminalInsert call subliminal#insert('\v(%V@!.|^)%V')
command! -range=% SubliminalAppend call subliminal#insert('\v%V.(%V@!|$)')

nnoremap <C-_> i<C-V>u2038<Esc>
inoremap <C-_>  <C-V>u2038
cnoremap <C-_>  <C-V>u2038
nnoremap <C-LeftMouse> <LeftMouse>i<C-V>u2038<Esc>

nnoremap <silent> i :SubliminalStart<CR>
xnoremap <silent> I    :SubliminalInsert<CR>
xnoremap <silent> A    :SubliminalAppend<CR>
xnoremap <silent> c xgv:SubliminalInsert<CR>

augroup Subliminal
	autocmd!
	" Remove cursors before saving
	autocmd BufWritePre * execute 'silent! keeppatterns %s/\u2038//g'

	" Conceal, don’t feel~
	autocmd FileType * execute 'syntax match Cursor /' . g:cursor . '\ze./ conceal containedin=ALL'
	autocmd FileType * execute 'syntax match Cursor /' . g:cursor . '.\?/ containedin=ALL'
augroup END
