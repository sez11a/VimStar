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
   \ [ "E&xit VimStar", 'qa' ],
   \ ])

call quickui#menu#install('&View', [
   \ [ "&Preview\t^op", 'MarkdownPreview' ],
   \ [ "&Open/Switch Window\t^ok", 'bnext' ],
   \ [ "Toggle WP/Code\t^ow", 'call ToggleWP()' ],
   \ [ "Toggle Outline\t^ou", 'call voom#Init("markdown", 1, 1)' ],
   \ ])

let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <space><space> :call quickui#menu#open()<cr>

let blocksave = [
			  \ [ "Save &d", 'w' ],
			  \ [ "New &e", 'enew' ],
			  \ [ "Close &j", 'bd' ],
			  \ [ "Save and Exit &x", 'wq'],
			  \ [ "Open/Switch &o", 'Explore'],
			  \ [ "Abandon Changes &q", 'q!'],
			  \ [ "Update Plugins &u", 'PlugUpdate'],
			  \ [ "Terminal &f", 'terminal'],
			  \ [ "Change Working Dir &l", 'cd %:p:h']
			  \]
let bopts = {'Block & Save': 'select one'}
noremap <C-k> :call quickui#listbox#open(blocksave,bopts)<cr>

let onscreen = [
			 \ [ "Toggle WP/Code &w", 'call ToggleWP()'],
			 \ [ "Toggle Soft/Hard Wrap &r", 'call ToggleWrap()'],
			 \ [ "Markdown Preview &p", 'MarkdownPreview'],
			 \ [ "Stop Preview &s", 'MarkdownPreviewStop'],
			 \ [ "Next Buffer &k", 'bnext'],
			 \ [ "Switch Buffer &b", "call quickui#tools#list_buffer('e')"],
			 \ [ "Toggle Outline &u", "call voom#Init('markdown', 1, 1)"],
			 \ [ "Toggle Focus Mode &y", 'call ToggleFocusMode()']
			 \]

let oopts = {'Onscreen Format': 'select one'}
noremap <C-o> :call quickui#listbox#open(onscreen,oopts)<cr>

let gitmenu = [
			\ [ "Git Status &s", 'Gstatus' ],
			\ [ "Git Pull &p", 'Gpull' ],
			\ [ "Git Push &u", 'Gpush' ],
			\ [ "Git Commit &c", 'Gcommit' ],
			\ [ "Git Write &w", 'Gwrite' ],
			\ [ "Git Move &m", 'GMove' ],
			\ [ "Git Delete &d", 'GDelete' ],
			\ [ "Git Diff Staged &f", 'Gdiffsplit' ]
			\]

let gopts = {'Git:': 'select one'}
noremap <C-g> :call quickui#listbox#open(gitmenu,gopts)<cr>
vnoremap <C-g> :call quickui#listbox#open(gitmenu,gopts)<cr>

