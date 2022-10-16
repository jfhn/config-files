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

print("module loaded: _debug");

return {
	print = function(val, recursive, indent_level)
		if type(val) ~= "table" and type(val) ~= "function" then
			print(tostring(val));
			return;
		end

		if type(val) == "function" then
			debug_print_function(val);
			return;
		end

		recursive    = recursive or false;
		indent_level = indent_level or 0;
		local indent_str = string.rep("\t", indent_level);
		print(indent_str .. "{");
		for k, v in pairs(val) do
			local inner_indent_str = string.rep("    ", indent_level + 1);
			cprint(inner_indent_str .. k .. " = ");
			if type(v) == "table" then
				print("");
				debug_print(v, recursive, indent_level + 1);
			elseif type(v) == "function" then
				debug_print_function(v);
			else
				print(tostring(v));
			end
		end
		print(indent_str .. "}");
	end
};
