function WikiMonthLink()
  return print(os.date("[%B %Y](/journal/%Y/%m/plan.md)"))
end

-- Pandoc <format> to compile documents quickly and easily:
vim.api.nvim_create_user_command("Pandoc", function(args)
	vim.cmd(
		"!pandoc -i "
			.. vim.fn.fnameescape(vim.fn.expand("%"))
			.. " -o "
			.. vim.fn.fnameescape(vim.fn.expand("%:r"))
			.. "."
			.. args.args
	)
end, {
	nargs = 1,
})

local M = {}

function M.ThreeWayDiff()
  local current_file = vim.fn.expand('%')
  if current_file == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  -- Prompt for branches
  local base = vim.fn.input('Base branch (master/main): ', 'master')
  if base == '' then return end

  local other = vim.fn.input('Other branch: ')
  if other == '' then return end

  -- Layout: left = base, middle = current, right = other
  vim.cmd('only')

  -- Left: base branch
  vim.cmd('leftabove vsplit')
  vim.cmd('Gedit ' .. base .. ':%')
  vim.cmd('diffthis')

  -- Middle: current version
  vim.cmd('wincmd l')
  vim.cmd('diffthis')

  -- Right: other branch
  vim.cmd('rightbelow vsplit')
  vim.cmd('Gedit ' .. other .. ':%')
  vim.cmd('diffthis')

  -- Return focus to the middle window
  vim.cmd('wincmd h')
end

function MoveMotion(motion)
  vim.cmd.normal(motion)
end

-- WordStar Diamond in Insert Mode
vim.keymap.set("i", "<C-s>", function() MoveMotion("h") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-d>", function() MoveMotion("l") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", function() MoveMotion("k") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-x>", function() MoveMotion("j") end, { noremap = true, silent = true })

-- WordStar Extended in Insert Mode
vim.keymap.set("i", "<C-f>", function() MoveMotion("w") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", function() MoveMotion("b") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-r>", function() MoveMotion("<C-b>") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", function() MoveMotion("<C-f>") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-w>", function() MoveMotion("<C-y>") end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-z>", function() MoveMotion("<C-e>") end, { noremap = true, silent = true })

return M
