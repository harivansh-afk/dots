-- Vim options
local o, opt = vim.o, vim.opt

-- Line numbers
o.number = true
o.relativenumber = true

-- Indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.breakindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

-- UI
o.termguicolors = true
o.cursorline = true
o.scrolloff = 8
o.signcolumn = "yes"
o.wrap = false
o.showmode = false
o.laststatus = 3
o.cmdheight = 0

opt.fillchars = { vert = "│", fold = "─", foldsep = "│", diff = "─" }
opt.shortmess:append("S")

-- Splits
o.splitbelow = true
o.splitright = true

-- Files
o.swapfile = false
o.backup = false
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Misc
o.updatetime = 250
o.mouse = "a"
o.clipboard = "unnamedplus"
