return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    -- Main keybinds
    {
      "<C-f>",
      function()
        local fzf = require("fzf-lua")
        local git_dir = vim.fn.system("git rev-parse --git-dir 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and git_dir ~= "" then
          fzf.git_files()
        else
          fzf.files()
        end
      end,
      desc = "Find files",
    },
    { "<C-g>", function() require("fzf-lua").live_grep() end, desc = "Live grep" },

    -- Leader keybinds
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Files" },
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    { "<leader>fh", function() require("fzf-lua").help_tags() end, desc = "Help tags" },
    { "<leader>fr", function() require("fzf-lua").resume() end, desc = "Resume last search" },
    { "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
    { "<leader>fc", function() require("fzf-lua").commands() end, desc = "Commands" },
    { "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
    { "<leader>f/", function() require("fzf-lua").search_history() end, desc = "Search history" },
    { "<leader>f:", function() require("fzf-lua").command_history() end, desc = "Command history" },
    { "<leader>fe", function() require("fzf-lua").files({ cwd = "~/.config" }) end, desc = "Config files" },
    -- Quickfix/loclist
    { "gq", function() require("fzf-lua").quickfix() end, desc = "Quickfix" },
    { "gl", function() require("fzf-lua").loclist() end, desc = "Loclist" },
    -- Git
    { "<leader>GB", function() require("fzf-lua").git_branches() end, desc = "Git branches" },
    { "<leader>Gc", function() require("fzf-lua").git_commits() end, desc = "Git commits" },
    { "<leader>Gs", function() require("fzf-lua").git_status() end, desc = "Git status" },
  },
  opts = {
    "default-title",
    winopts = {
      border = "single",
      preview = {
        layout = "vertical",
        vertical = "down:50%",
      },
    },
    fzf_opts = {
      ["--layout"] = "reverse",
    },
  },
}
