local function cprint(str)
	io.write(str);
end

local function printf(formatstr, ...)
	print(string.format(formatstr, ...));
end

local function debug_get_func_name(func)
	for k, v in pairs(getfenv()) do
		if v == func then
			return k;
		end
	end
end

local function debug_print_function(func)
	local info = debug.getinfo(func, "S");
	printf("function %s(), %s: %s", debug_get_func_name(func) or "<anonymous>", info.short_src, info.linedefined);
end

--- @param val          any      The value to be printed
--- @param recursive    boolean? When `val` is a table, should its content be printed recursively? Default = `true`.
--- @param indent_level number?  Level of indentation. Default = `0`.
local function debug_print(val, recursive, indent_level)
	if type(val) ~= "table" and type(val) ~= "function" then
		print(tostring(val));
		return;
	end

	if type(val) == "function" then
		debug_print_function(val);
		return;
	end

	indent_level = indent_level or 0;
	if recursive == nil then
		recursive = true;
	end

	local indent_str = string.rep("\t", indent_level);
	print(indent_str .. "{");
	if recursive then
		for k, v in pairs(val) do
			local inner_indent_str = string.rep("\t", indent_level + 1);
			cprint(inner_indent_str .. k .. " = ");
			if type(v) == "table" then

				print("");
			end
			debug_print(v, recursive, indent_level + 1);
		end
	end

	print(indent_str .. "}");
end

return {
	print = debug_print
};
