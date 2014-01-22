" Copyright © 2014 Grimy <Victor.Adam@derpymail.org>
" This work is free software. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See the LICENCE file for more details.

function! subliminal#insert(append) range
	" In character-wise mode, fallback to the normal behaviour
	if visualmode() ==# 'v'
		return feedkeys(a:append ? 'gvA' : 'gvI', 'n')
	endif

	execute "normal! gv" (a:append ? 'A' : 'I') . g:cursor
	call subliminal#main()
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
	" No cursors, no chocolate
	" Save options so we can restore them later
	let save = [ &eventignore, &cursorline, &cursorcolumn, &scrolloff ]
	set eventignore=all nocursorline nocursorcolumn scrolloff=0

	let char = GetChar()
	while char != "\<Esc>"
		if strlen(maparg(char, 'i'))
			execute 'let char = "' . escape(maparg(char, 'i'), '<') . '"'
		endif

		silent! undojoin
		execute 'silent! keeppatterns %s/' . g:cursor . '\+/' . g:cursor2 . '/g'

		while search(g:cursor2, 'w')
			execute "normal! a\<BS>" . char . g:cursor
		endwhile
		let char = GetChar()
	endwhile

	execute 'silent! keeppatterns %s/' . g:cursor . '//g'
	let [ &eventignore, &cursorline, &cursorcolumn, &scrolloff ] = save
	"call repeat#set(chars, 1)
endfunction

