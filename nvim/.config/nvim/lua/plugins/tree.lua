return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<C-e>", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<BS>", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<leader>gs", "<cmd>Neotree git_status left<cr>", desc = "Git status tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
      },
      -- Source selector at top (just Files, no Git tab)
      source_selector = {
        winbar = false,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
    })
  end,
}
