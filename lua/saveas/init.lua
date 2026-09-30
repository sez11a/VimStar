local M = {}

function M.open(opts)
	opts = opts or {}
	local dialog = require("saveas.dialog")
	dialog.new(opts)
end

return M