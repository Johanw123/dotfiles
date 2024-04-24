local M = {}

M.adapter = {
	type = "executable",
	command = "lldb-dap",
	name = "lldb",
}

M.config = {
	-- {
	-- 	name = "Launch",
	-- 	type = "lldb",
	-- 	request = "launch",
	-- 	program = function()
	-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 	end,
	-- 	cwd = "${workspaceFolder}",
	-- 	stopOnEntry = false,
	-- 	args = function()
	-- 		local argument_string = vim.fn.input("Program arguments: ")
	-- 		return vim.fn.split(argument_string, " ", true)
	-- 	end,
	-- },
    {
		name = "quickSimLapsim",
		type = "lldb",
		request = "launch",
		program = "",
		cwd = "${workspaceFolder}\\Runtime\\LapSim\\bin_unopt\\quickSim.exe",
		stopOnEntry = false,
		args = {}
	},
}

return M
