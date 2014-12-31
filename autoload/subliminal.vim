" Copyright © 2015 Grimy <Victor.Adam@derpymail.org>
" This work is free software. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See the LICENCE file for more details.

" TODO: repeat#set(...) ?

function! subliminal#insert(regex) range
	let [save, &selection] = [&selection, 'inclusive']
	execute 'silent! keeppatterns keepjumps %s/' . a:regex . '\zs/' . g:cursor
	let &selection = save
	call subliminal#main()
endfunction

" Saves and restores the environment
function! subliminal#main()
	if !search(g:cursor, 'w')
		startinsert
		return
	endif
	let save = [&eventignore, &cursorline, &cursorcolumn, &scrolloff]
	try
		set eventignore=all nocursorline nocursorcolumn scrolloff=0
		call s:input_loop()
	catch | finally
		echo
		let [&eventignore, &cursorline, &cursorcolumn, &scrolloff] = save
	endtry
endfunction

nnoremap <Plug>(subliminal_abs) a<BS>
inoremap <silent> <Plug>(subliminal_ok) <C-O>:let s:cursors += 1<CR><C-V>u2038
nnoremap <silent> <Plug>(subliminal_ok) <Nop>

function! s:input_loop()
	let s:cursors = 9001  " dummy value to force
	while s:cursors
		redraw
		let char = getchar()
		let char = type(char) == 0 ? nr2char(char) : char
		silent! undojoin
		execute 'silent! keeppatterns keepjumps %s/\v' . g:cursor . "+/\u2039"
		let s:cursors = 0
		while search("\u2039", 'w')
			exec "normal \<Plug>(subliminal_abs)" . char . "\<Plug>(subliminal_ok)"
		endwhile
		echo 'Subliminal:' s:cursors 'cursors'
	endwhile
	silent! normal! `.
endfunction
