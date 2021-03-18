" Quick UI Menu Configuration

let g:quickui_border_style = 2
let g:quickui_color_scheme = 'borland'
call quickui#menu#reset()

" File Menu
call quickui#menu#install('&File', [
   \ [ "&New Buffer\t^ke", 'enew' ],
   \ [ "&Open/Switch\t^ko", 'Explore' ],
   \ [ "&Close", 'bd' ],
   \ [ "Save and C&lose\t^kx", 'wq' ],
   \ [ "&Change Working Dir\t^kl", 'cd %:p:h'],
   \ [ "&Terminal\t^kf", 'terminal' ],
   \ [ "&Update Plugins\t^ku", 'PlugUpdate' ],
   \ [ "&Open Diary\t^kd", 'Diary' ],
   \ [ "E&xit VimStar", 'qa' ],
   \ ])

" Edit Menu
let note_snippet = "<!--  -->"
call quickui#menu#install('&Edit', [
   \ [ "&Undo\tu", 'normal! u' ],
   \ [ "&Redo\t^R", "normal! <C-r>" ],
   \ [ "&Find Files\t^qf", 'Files<CR>' ],
   \ [ "&Find in Files\t^qg", 'Rg<CR>' ],
   \ [ "Go to Marker 1\t\'a", "normal! \'a" ],
   \ [ "Go to Marker 2\t\'b", "normal! \'b" ],
   \ [ "Go to Marker 3\t\'c", "normal! \'c" ],
   \ [ "Go to Marker 4\t\'d", "normal! \'d" ],
   \ [ "Go to Marker 5\t\'e", "normal! \'e" ],
   \ [ "Set Marker 1\tma", "normal! ma<space><space><esc>" ],
   \ [ "Set Marker 2\tmb", "normal! mb" ],
   \ [ "Set Marker 3\tmc", "normal! mc" ],
   \ [ "Set Marker 4\tmd", "normal! md" ],
   \ [ "Set Marker 5\tme", "normal! me" ],
   \ [ "&Insert Note", "normal! i\<C-r>\<C-r>=note_snippet\<CR>\<Esc>" ],
   \ ])

" View Menu
call quickui#menu#install('&View', [
   \ [ "&Preview\t^op", 'MarkdownPreview' ],
   \ [ "&Open/Switch Window\t^ok", 'bnext' ],
   \ [ "Toggle WP/Code\t^ow", 'call ToggleWP()' ],
   \ [ "Toggle Outline\t^ou", 'call voom#Init("markdown", 1, 1)' ],
   \ [ "Vertical Split", 'vsplit' ],
   \ [ "Horizontal Split", 'split' ],
   \ [ "Toggle Linters\t ^ol", 'ALEToggle' ],
   \ ])

" Git Menu
call quickui#menu#install('&Git', [
	\ [ "Git Status &^gs", 'Gstatus' ],
	\ [ "Git Pull &^gp", 'Gpull' ],
	\ [ "Git Push &^gu", 'Gpush' ],
	\ [ "Git Commit &^gc", 'Gcommit' ],
	\ [ "Git Write &^gw", 'Gwrite' ],
	\ [ "Git Move &^gm", 'GMove' ],
	\ [ "Git Delete &^gd", 'GDelete' ],
	\ [ "Git Diff Staged &^gf", 'Gdiffsplit' ],
   \ [ "Git Browse Head &^gb", 'Gedit HEAD' ],
	\ ])

let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <leader><space> :call quickui#menu#open()<cr>

let blocksave = [
			  \ [ "Save &d", 'w' ],
			  \ [ "New &e", 'enew' ],
			  \ [ "Close &j", 'bd' ],
			  \ [ "Save and Exit &x", 'wq'],
			  \ [ "Open/Switch &o", 'Explore'],
			  \ [ "Abandon Changes &q", 'q!'],
			  \ [ "Update Plugins &u", 'PlugUpdate'],
			  \ [ "Terminal &f", 'terminal'],
			  \ [ "Change Working Dir &l", 'cd %:p:h'],
           \ [ "Open Diary &d", 'Diary']
			  \]
let bopts = {'Block & Save': 'select one'}
noremap <leader>k :call quickui#listbox#open(blocksave,bopts)<cr>

let onscreen = [
			 \ [ "Toggle WP/Code &w", 'call ToggleWP()'],
			 \ [ "Toggle Soft/Hard Wrap &r", 'call ToggleWrap()'],
			 \ [ "Markdown Preview &p", 'MarkdownPreview'],
			 \ [ "Stop Preview &s", 'MarkdownPreviewStop'],
			 \ [ "Next Buffer &k", 'bnext'],
			 \ [ "Switch Buffer &b", "call quickui#tools#list_buffer('e')"],
			 \ [ "Toggle Outline &u", "call voom#Init('markdown', 1, 1)"],
			 \ [ "Toggle Focus Mode &y", 'call ToggleFocusMode()'],
			 \ [ "Toggle Linters &l", 'ALEToggle']
			 \]

let oopts = {'Onscreen Format': 'select one'}
noremap <leader>o :call quickui#listbox#open(onscreen,oopts)<cr>

let gitmenu = [
			\ [ "Git Status &s", 'Gstatus' ],
			\ [ "Git Pull &p", 'Gpull' ],
			\ [ "Git Push &u", 'Gpush' ],
			\ [ "Git Commit &c", 'Gcommit' ],
			\ [ "Git Write &w", 'Gwrite' ],
			\ [ "Git Move &m", 'GMove' ],
			\ [ "Git Delete &d", 'GDelete' ],
			\ [ "Git Diff Staged &f", 'Gdiffsplit' ],
         \ [ "Git Browse Head &b", 'Gedit HEAD' ]
			\]

let gopts = {'Git:': 'select one'}
noremap <leader>g :call quickui#listbox#open(gitmenu,gopts)<cr>
vnoremap <leader>g :call quickui#listbox#open(gitmenu,gopts)<cr>

let quickmenu = [
			  \ [ "Find Files &f", 'Files' ],
			  \ [ "Find in Files &i", 'Rg' ]
			  \ ]

let qopts = {'Quick Menu': 'select one'}
nnoremap <leader>q :call quickui#listbox#open(quickmenu,qopts)<cr>
vnoremap <leader>q :call quickui#listbox#open(quickmenu,qopts)<cr>
