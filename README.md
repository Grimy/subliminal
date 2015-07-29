
Multiple cursors for VIM
========================

Quick Start
-----------

Plug 'Grimy/subliminal'  " or whatever your plugin manager is
set utf-8  " required
set conceallevel=2 concealcursor+=n  " recommended

Place cursors with <C-_> or <C-LeftMouse>; start Subliminal-mode with i.
In visual-mode, A, I and c start Subliminal with a cursor on each line

FAQ
---

Subliminal provides multiple cursors *in insert mode only*. If you want
some normal-mode functionality to be available to multiple cursors, you can
map it to a key in insert mode. I like having the following mappings:

inoremap <C-Del> <C-O>"_dw
inoremap <C-BS> <C-W>
inoremap <C-A> <Home>
inoremap <C-E> <End>

Each cursor is represented by an invisible character in the buffer. This is
better than saving a list of positions, as it ensures that cursors remain
correctly placed even when adding or removing text. It also means that you
can manipulate cursors using standard 

Commands
--------

Mappings
--------

Options
-------

None at the moment.

Known bugs
----------

* Adding a cursor in the middle of a keyword can mess syntax highlighting
* Multi-character mappings (like `jk`) aren’t handled
* The « Subliminal: %d cursors » message doesn’t appear until a key is pressed
* Subliminal-mode doesn’t 

Contributing
------------

Bug reports and contributions are welcome.
