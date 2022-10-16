local M = {};

-- Reference: https://github.com/n3wborn/nvim/blob/main/lua/utils.lua
M.warn = function(msg)
    api.nvim_echo({{msg, 'WarningMsg'}}, true, {})
end

M.notify = function(title, msg, level)
    vim.notify(msg, level, {
        title = title,
    });
end

return M;
