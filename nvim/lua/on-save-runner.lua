--- @param output_bufnr integer
--- @param command string[]
local function attach_to_buffer(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("on-save-runner-group", { clear = true }),
		pattern = pattern,
		callback = function()
			assert(type(output_bufnr) == "number", "type(output_bufnr) = " .. type(output_bufnr))
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end

			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {"Command: '" .. table.concat(command, " ") .. "'"})

			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

vim.api.nvim_create_user_command("OnSaveRun", function()
	print("Starting OnSaveRun command...")
	-- local output_bufnr = tonumber(vim.fn.input("Bufnr (default = this buffer): ")) or vim.api.nvim_get_current_buf()
	local output_bufnr = tonumber(vim.fn.input({prompt = "Bufnr: ", default = vim.api.nvim_get_current_buf()}))
	local pattern      = tostring(vim.fn.input("Pattern: "))
	local command      = vim.split(vim.fn.input("Command: "), " ")
	attach_to_buffer(output_bufnr, pattern, command)
end, {})
