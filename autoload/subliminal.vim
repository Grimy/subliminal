" Copyright © 2015 Grimy <Victor.Adam@derpymail.org>
" This work is free software. You can redistribute it and/or modify it under
" the terms of the Do What The Fuck You Want To Public License, Version 2, as
" published by Sam Hocevar. See the LICENCE file for more details.

" TODO: repeat#set(...) ?

function! subliminal#insert(regex) range
	execute 'silent! keeppatterns keepjumps %s/' . a:regex . "\\zs/\u2038"
	call subliminal#main()
endfunction

" Saves and restores the environment
function! subliminal#main()
	if !search("\u2038", 'w')
		startinsert
		return
	endif
	let save = [&eventignore, &cursorline, &cursorcolumn, &scrolloff, &gdefault]
	try
		set eventignore=all nocursorline nocursorcolumn scrolloff=0 nogdefault
		call s:input_loop()
	catch | finally
		echo
		let [&eventignore, &cursorline, &cursorcolumn, &scrolloff, &gdefault] = save
	endtry
endfunction

nnoremap <Plug>(subliminal_abs) a<BS>
inoremap <silent> <Plug>(subliminal_ok) <C-O>:let s:cursors += 1<CR><C-V>u2038
nnoremap <silent> <Plug>(subliminal_ok) <Nop>

function! s:input_loop()
	let s:cursors = 1
	call feedkeys("\<C-]>")
	while s:cursors
		redraw
		let char = getchar()
		let char = type(char) == 0 ? nr2char(char) : char
		silent! undojoin
		execute "silent! keeppatterns keepjumps %s/\u2038\\+/\u2039"
		let s:cursors = 0
		while search("\u2039", 'w')
			exec "normal \<Plug>(subliminal_abs)" . char . "\<Plug>(subliminal_ok)"
		endwhile
		echo 'Subliminal:' s:cursors 'cursors'
	endwhile
	silent! normal! `.
endfunction
