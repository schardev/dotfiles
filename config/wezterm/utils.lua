local M = {}
M.table = {}

-- Adds the values from one array to the end of another and returns the result.
--@see https://github.com/premake/premake-core/
function M.table.join(...)
    local result = {}
    local arg = { ... }
    for _, t in ipairs(arg) do
        if type(t) == "table" then
            for _, v in ipairs(t) do
                table.insert(result, v)
            end
        else
            table.insert(result, t)
        end
    end
    return result
end

-- Function equivalent to basename in POSIX systems
function M.basename(str)
    if str then
        return string.gsub(str, "(.*/)(.*)", "%2")
    end
end

-- Detect if running inside an editor or not
function M.is_editor(proc_name)
    local editors = { "nvim", "vim", "vi", "nano" }
    local name = M.basename(proc_name)
    for _, v in pairs(editors) do
        if name == v then
            return true
        end
    end
    return false
end

return M
