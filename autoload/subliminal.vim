" Copyright © 2014 Grimy <Victor.Adam@derpymail.org>
" This work is free software. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See the LICENCE file for more details.

function! subliminal#insert(append) range
	" In character-wise mode, fallback to the normal behaviour
	if visualmode() ==# 'v'
		call setpos('.', getpos(a:append ? "'>" : "'<"))
		startinsert
		return
	endif

	let col = sort([virtcol("'>"), virtcol("'<")])[a:append]
	execute 'silent! keeppatterns *s/\%' . col . 'v/' . g:cursor . '/'
	call subliminal#main()
endfunction

function! NormalPos(pos)
	return line(a:pos) . 'G' . virtcol(a:pos) . '|'
endfunction

function! CountCursors()
	redir => result
	execute 'silent! keeppatterns %s/' . g:cursor . '//gn'
	redir END
	return str2nr(result[1:])
endfunction

" Wrapper around getchar() that keeps a cache of the typeahead, in case the
" user types faster than what we can process.
" It also converts characters to their string representation
function! GetChar()
	redraw
	while getchar(1) || len(s:chars) == 0
		let c = getchar()
		call add(s:chars, type(c) == 0 ? nr2char(c) : c)
	endwhile
	return remove(s:chars, 0)
endfunction
let s:chars = [ ]

function! subliminal#main()
	" Save options so we can restore them later
	let save = [ &eventignore, &cursorline, &cursorcolumn ]
	set eventignore=all nocursorline nocursorcolumn

	call subliminal#loop()

	execute 'silent! keeppatterns %s/' . g:cursor . '//g'
	let [ &eventignore, &cursorline, &cursorcolumn ] = save
	"call repeat#set(chars, 1)
endfunction

function! subliminal#loop() abort
	" No cursors, no chocolate
	call setpos('.', [ bufnr('.'), 0, 0, 0 ])
	if CountCursors() == 0
		return
	endif

	let char = GetChar()
	while char != "\<Esc>"
		silent! undojoin
		execute 'silent! keeppatterns %s/' . g:cursor . '\+/' . g:cursor . '/g'
		keepjumps normal gg
		for i in range(CountCursors())
			silent! undojoin
			execute 'silent! keeppatterns normal! /' . g:cursor . "\<CR>x"
			execute 'normal i' . char . g:cursor
		endfor
		let char = GetChar()
	endwhile
endfunction

