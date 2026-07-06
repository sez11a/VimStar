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
