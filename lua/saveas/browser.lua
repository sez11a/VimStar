local M = {}

function M.list_directory(path)
	path = vim.fn.expand(path)
	if path == "" then
		path = vim.uv.cwd()
	end
	
	if not vim.uv.fs_stat(path) then
		return {}
	end
	
	local entries = {}
	local files = vim.fn.glob(path .. "/*", true, true, true)
	
	for _, file in ipairs(files) do
		file = vim.fn.expand(file)
		if file ~= "" and file ~= path then
			local name = vim.fn.fnamemodify(file, ":t")
			if name ~= "." and name ~= ".." and #name > 0 then
				local is_dir = vim.fn.isdirectory(file) == 1
				table.insert(entries, {
					path = file,
					name = name,
					is_dir = is_dir,
				})
			end
		end
	end
	
	table.sort(entries, function(a, b)
		if a.is_dir ~= b.is_dir then
			return a.is_dir, b.is_dir
		end
		return a.name:lower() < b.name:lower()
	end)
	
	return entries
end

return M