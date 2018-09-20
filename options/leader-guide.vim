 " Define prefix dictionary
let g:lmap =  {}

" Second level dictionaries:
let g:lmap.f = { 'name' : 'File Menu' }
let g:lmap.o = { 'name' : 'Onscreen Format Menu' }
" let g:lmap.q = { 'name' : 'Quick Menu' }
let g:lmap.k = { 'name' : 'Block & Save Menu' }

" Quick Menu
" let g:lmap.q.f = [ '%s/', 'find text' ]

" Block & Save Menu
let g:lmap.k.d = ['w', 'save']
let g:lmap.k.x = ['wq', 'save & exit']
let g:lmap.k.q = ['q!', 'abandon changes']
let g:lmap.k.u = ['PlugUpdate', 'Update Plugins']
let g:lmap.k.f = ['terminal', 'run Linux command']

" Onscreen Format menu
let g:lmap.o.w = ['call ToggleWP()', 'toggle word processor mode']
let g:lmap.o.p = ['ComposerStart', 'page preview']
let g:lmap.o.k = ['bnext', 'switch buffer']
let g:lmap.o.m = ['split', 'open window']

" 'name' is a special field. It will define the name of the group.
" leader-f is the "File Menu" group.
" Unnamed groups will show a default string

" Provide commands and descriptions for existing mappings
	nmap <silent> <leader>fd :e $MYVIMRC<CR>
	let g:lmap.f.d = ['e $MYVIMRC', 'Open vimrc']

	nmap <silent> <leader>fs :so %<CR>
	" let g:lmap.f.s = ['so %', 'Source file']

	nmap <silent> <leader>oo  :copen<CR>
	" let g:lmap.o.o = ['copen', 'Open quickfix']

	nmap <silent> <leader>ol  :lopen<CR>
	" let g:lmap.o.l = ['lopen', 'Open locationlist']

	nmap <silent> <leader>fw :w<CR>
	" let g:lmap.f.w = ['w', 'Write file']

" Create new menus not based on existing mappings:
let g:lmap.g = {
				\'name' : 'Git Menu',
				\'s' : ['Gstatus', 'Git Status'],
                \'p' : ['Gpull',   'Git Pull'],
                \'u' : ['Gpush',   'Git Push'],
                \'c' : ['Gcommit .', 'Git Commit'],
                \'w' : ['Gwrite',  'Git Write'],
                \}

" If you use NERDCommenter:
let g:lmap.c = { 'name' : 'Comments' }
" Define some descriptions
let g:lmap.c.c = ['call feedkeys("\<Plug>NERDCommenterComment")','Comment']
let g:lmap.c[' '] = ['call feedkeys("\<Plug>NERDCommenterToggle")','Toggle']
" The Descriptions for other mappings defined by NerdCommenter, will default
" to their respective commands.

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
