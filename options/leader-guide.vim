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
let g:lmap.k.d = ['w', 'Save']
let g:lmap.k.e = ['enew', 'New Buffer']
let g:lmap.k.j = ['bd', 'Close Buffer']
let g:lmap.k.x = ['wq', 'Save & Exit']
let g:lmap.k.o = ['Explore', 'Open File Browser']
let g:lmap.k.q = ['q!', 'Abandon Changes']
let g:lmap.k.u = ['PlugUpdate', 'Update Plugins']
let g:lmap.k.f = ['terminal', 'run Linux command']

" Onscreen Format menu
let g:lmap.o.w = ['call ToggleWP()', 'Toggle Word Processor Mode']
let g:lmap.o.p = ['ComposerStart', 'Page Preview']
let g:lmap.o.k = ['bnext', 'Switch Buffer']
let g:lmap.o.m = ['split', 'Open Window']

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

" Define local leader dictionary
let g:llmap = {}
" autocmd FileType org let g:llmap.o = { 'name' : 'orgmode' }
autocmd FileType org noremap <buffer> <localleader> <Plug>leaderguide-global

nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>LeaderGuide  ','<CR>
vnoremap <silent> <localleader> :<c-u>LeaderGuideVisual  ','<CR>

let g:topdict = {}
let g:topdict[' '] = g:lmap
let g:topdict[' ']['name'] = '<leader>'
let g:topdict[','] = g:llmap
let g:topdict[',']['name'] = '<localleader>'

call leaderGuide#register_prefix_descriptions("", "g:topdict")
" call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
" call leaderGuide#register_prefix_descriptions(",", "g:llmap")
