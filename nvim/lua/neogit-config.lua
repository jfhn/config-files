local ok, neogit = pcall(require, "neogit");
if not ok then
	require("util").warn("Error on loading `neogit`.");
	return;
end

neogit.setup {};
