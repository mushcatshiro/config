local M = {}

-- 1. THE PALETTE
-- 'hex' is for gui/24bit, 'c' is for cterm/8bit (0-255)
local colors = {
    bg       = { hex = "#1a1b26", c = "NONE" }, -- Example: TokyoNight-ish dark
    fg       = { hex = "#c0caf5", c = 7 },
    comment  = { hex = "#565f89", c = 8 },
    red      = { hex = "#f7768e", c = 1 },
    green    = { hex = "#9ece6a", c = 2 },
    yellow   = { hex = "#e0af68", c = 3 },
    blue     = { hex = "#7aa2f7", c = 4 },
    magenta  = { hex = "#bb9af7", c = 5 },
    cyan     = { hex = "#7dcfff", c = 6 },
    dark_bg  = { hex = "#16161e", c = 0 },
}

-- 2. THE HIGHLIGHT GROUPS
local theme = {
    -- UI / Editor
    Normal       = { fg = colors.fg, bg = colors.bg },
    NormalFloat  = { fg = colors.fg, bg = colors.dark_bg },
    CursorLine   = { bg = colors.dark_bg },
    LineNr       = { fg = colors.comment },
    CursorLineNr = { fg = colors.yellow },
    Search       = { fg = colors.bg, bg = colors.yellow },
    Visual       = { bg = colors.comment }, -- Selection

    -- Standard Syntax (The foundation)
    Comment      = { fg = colors.comment, italic = true },
    Constant     = { fg = colors.yellow },
    String       = { fg = colors.green },
    Character    = { fg = colors.green },
    Number       = { fg = colors.yellow },
    Boolean      = { fg = colors.yellow },
    Float        = { fg = colors.yellow },
    Identifier   = { fg = colors.blue },
    Function     = { fg = colors.blue },
    Statement    = { fg = colors.magenta },
    Conditional  = { fg = colors.magenta },
    Repeat       = { fg = colors.magenta },
    Label        = { fg = colors.magenta },
    Operator     = { fg = colors.cyan },
    Keyword      = { fg = colors.cyan },
    Exception    = { fg = colors.magenta },
    PreProc      = { fg = colors.cyan },
    Type         = { fg = colors.magenta },
    Special      = { fg = colors.blue },
    Delimiter    = { fg = colors.fg },
    Error        = { fg = colors.red },
    Todo         = { fg = colors.bg, bg = colors.yellow },

    -- TreeSitter (The magic)
    -- Instead of defining thousands of lines, we LINK to standard syntax.
    -- Override specific ones if you want them to look different.
    ["@variable"]      = { link = "Identifier" },
    ["@function"]      = { link = "Function" },
    ["@function.builtin"] = { fg = colors.red }, -- Example: Make builtins red
    ["@keyword"]       = { link = "Keyword" },
    ["@string"]        = { link = "String" },
    ["@comment"]       = { link = "Comment" },
    ["@constructor"]   = { link = "Type" },
    ["@tag"]           = { link = "Label" }, -- HTML tags
    ["@tag.attribute"] = { link = "Identifier" }, -- HTML attributes
}

-- 3. THE LOGIC
function M.setup()
    -- Reset current highlights
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    vim.o.termguicolors = true -- Assume 24-bit by default
    vim.g.colors_name = "shiro-theme"

    -- Determine if we are using 24-bit (gui) or 8-bit (cterm)
    -- This check allows you to toggle behavior
    local is_gui = vim.opt.termguicolors:get()

    for group, opts in pairs(theme) do
        local hl_opts = {}

        if opts.link then
            hl_opts.link = opts.link
        else
            -- Process Foreground
            if opts.fg then
                if is_gui then hl_opts.fg = opts.fg.hex else hl_opts.ctermfg = opts.fg.c end
            end

            -- Process Background
            if opts.bg then
                if is_gui then hl_opts.bg = opts.bg.hex else hl_opts.ctermbg = opts.bg.c end
            end

            -- Process Styles (bold, italic, etc.)
            -- These work largely the same in both, though some terms lack italics
            hl_opts.bold = opts.bold
            hl_opts.italic = opts.italic
            hl_opts.underline = opts.underline
        end

        -- Apply the highlight
        vim.api.nvim_set_hl(0, group, hl_opts)
    end
end

return M
