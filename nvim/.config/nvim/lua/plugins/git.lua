return {
  -- Fugitive: The gold standard for Git in Vim
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gread", "Gwrite", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr><cmd>only<cr>", desc = "Git status (fullscreen)" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff vertical" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git checkout file" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git add file" },
    },
  },

  -- Gitsigns: Git info in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "│" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "┃" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,  -- disabled - let colorscheme handle
      word_diff = false,
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 500,
      },
    },
    keys = {
      { "]g", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
      { "[g", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
      { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    },
  },

  -- Snacks: GitHub integration (browse, issues, PRs)
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      gitbrowse = {},
    },
    keys = {
      { "<leader>go", function() Snacks.gitbrowse() end, desc = "Open in GitHub" },
    },
  },

  -- Diffs.nvim: Better diff highlighting
  {
    "barrettruth/diffs.nvim",
    ft = { "git", "fugitive", "diff" },
    config = function()
      vim.g.diffs = {
        hide_prefix = true,
        highlights = {
          gutter = true,
          blend_alpha = 0.4,
        },
      }
    end,
  },
}
