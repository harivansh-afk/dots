-- Minimal custom statusline
local M = {}

-- Mode mapping
local mode_map = {
    n = "NORMAL",
    no = "N-PENDING",
    nov = "N-PENDING",
    noV = "N-PENDING",
    ["no\22"] = "N-PENDING",
    niI = "NORMAL",
    niR = "NORMAL",
    niV = "NORMAL",
    nt = "NORMAL",
    ntT = "NORMAL",
    v = "VISUAL",
    vs = "VISUAL",
    V = "V-LINE",
    Vs = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["\22s"] = "V-BLOCK",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
    i = "INSERT",
    ic = "INSERT",
    ix = "INSERT",
    R = "REPLACE",
    Rc = "REPLACE",
    Rx = "REPLACE",
    Rv = "V-REPLACE",
    Rvc = "V-REPLACE",
    Rvx = "V-REPLACE",
    c = "COMMAND",
    cv = "EX",
    ce = "EX",
    r = "REPLACE",
    rm = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    t = "TERMINAL",
}

-- Get current mode indicator
local function get_mode()
    local mode = vim.api.nvim_get_mode().mode
    return mode_map[mode] or mode
end

-- Get git branch from gitsigns
local function get_git_branch()
    local branch = vim.b.gitsigns_head
    if branch and branch ~= "" then
        return " " .. branch
    end
    return ""
end

-- Get filename with modified indicator
local function get_filename()
    local filename = vim.fn.expand("%:t")
    if filename == "" then
        filename = "[No Name]"
    end

    local modified = vim.bo.modified and " [+]" or ""
    local readonly = vim.bo.readonly and " [RO]" or ""

    return filename .. modified .. readonly
end

-- Get file path (relative to cwd)
local function get_filepath()
    local filepath = vim.fn.expand("%:~:.")
    if filepath == "" then
        return ""
    end
    return filepath
end

-- Get current position
local function get_position()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local total = vim.fn.line("$")
    return string.format("%d:%d/%d", line, col, total)
end

-- Get filetype
local function get_filetype()
    local ft = vim.bo.filetype
    if ft == "" then
        return ""
    end
    return ft
end

-- Build the statusline
function M.statusline()
    local parts = {}

    -- Left side
    table.insert(parts, " " .. get_mode() .. " ")
    table.insert(parts, get_git_branch())

    local filepath = get_filepath()
    if filepath ~= "" then
        table.insert(parts, " " .. filepath)
    end

    -- Modified indicator
    if vim.bo.modified then
        table.insert(parts, " [+]")
    end

    -- Separator
    table.insert(parts, "%=")

    -- Right side
    local ft = get_filetype()
    if ft ~= "" then
        table.insert(parts, ft .. " ")
    end

    table.insert(parts, get_position() .. " ")

    return table.concat(parts, "")
end

-- Setup function to configure the statusline
function M.setup()
    -- Use the %!v:lua.require() pattern
    vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"

    -- Ensure statusline is always shown
    vim.o.laststatus = 2
end

return M
