local mydbg = require("_debug");

local t = {
	{x = 5, tab = {y = 5}},
	abc = {1,2,3},
	f = function () end
};

mydbg.print(t);
mydbg.print(t, true);
mydbg.print(t, false);
mydbg.print(function() end);
