
Multiple cursors for VIM
========================

Subliminal 

Quick Start
===========

NeoBundle 'Grimy/subliminal'  " or whatever your plugin manager is
set utf-8  " required
set conceallevel=2 concealcursor+=n  " recommended

Place cursors with <C-_> or <C-LeftMouse>; start Subliminal-mode with i
In visual-mode, A, I and c start Subliminal with a cursor on each line

FAQ
===

provides multiple cursors *in insert mode only*. If you want
some normal-mode functionality to be available to multiple cursors, you can
map it to some key in insert mode. I like having the following mappings:

inoremap <C-Del> <C-O>"_dw
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-S> <C-O><C-A>
inoremap <nowait> <C-X> <C-O><C-X>

At the moment, multi-chars mappings aren’t supported.


Each cursor is represented by an invisible character in the buffer. This is
better than saving a list of positions, as it ensures that cursors remain
correctly placed even when adding or removing text. you delete surrounding text means that simply
copySubliminal works by placing

Commands
========

Mappings
========

Options
=======

None at the moment.

Contributing
============

Bug reports and contributions are welcome.
