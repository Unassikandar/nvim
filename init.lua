require('keymaps')
require('options')



vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",       -- required by telescope
  "https://github.com/nvim-tree/nvim-web-devicons", -- required by telescope, nvim-tree, bufferline, lualine
  "https://github.com/folke/tokyonight.nvim",       -- colorscheme
  "https://github.com/rebelot/kanagawa.nvim",       -- colorscheme
})

-- vim.cmd.colorscheme("kanagawa-wave")
vim.cmd.colorscheme('tokyonight-night')

------------------------------------------------------------------------------------------------------------------------
-- NVIM-TREESITTER -----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require('nvim-treesitter').install({ 'rust', 'javascript', 'zig', 'java', 'javadoc', 'json', 'yaml', 'go', 'html', 'lua' })
    :wait(300000)

require("nvim-treesitter").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

------------------------------------------------------------------------------------------------------------------------
-- TELESCOPE -----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim", --Manually went to downloaded directory and exec MAKE
  "https://github.com/nvim-telescope/telescope.nvim"
})

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Telescope find string under cursor" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope open keymaps picker" })

require("telescope").setup({
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

require("telescope").load_extension('fzf')

------------------------------------------------------------------------------------------------------------------------
-- NVIM-TREE -----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/nvim-tree/nvim-tree.lua"
})

require('nvim-tree').setup({
  view = {
    width = 35,
    side = "left",
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  filters = {
    custom = { ".DS_Store" }
  },
  git = {
    ignore = false,
  },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
vim.keymap.set("n", "<leader>eE", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer"})

------------------------------------------------------------------------------------------------------------------------
-- WHICH-KEY

vim.pack.add({
  "https://github.com/folke/which-key.nvim"
})

require("which-key").setup({
  preset = "classic",
  delay = 700,
})


------------------------------------------------------------------------------------------------------------------------
-- AUTO-SESSION --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/rmagatti/auto-session"
})

require("auto-session").setup({
  auto_restore_enabled = false,
  auto_session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Desktop" },
})

vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for cwd" })


------------------------------------------------------------------------------------------------------------------------
-- BUFFERLINE ----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim"
})

require("bufferline").setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
    indicator = { style = "underline" },
    --always_show_bufferline = false,
    show_buffer_close_icons = true,
    show_close_icon = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        text_align = "left",
        separator = true,
      },
    },
  }
})

------------------------------------------------------------------------------------------------------------------------
-- LUALINE ----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim"
})

require('lualine').setup()


------------------------------------------------------------------------------------------------------------------------
-- INDENT-GUIDE --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/lukas-reineke/indent-blankline.nvim"
})

require("ibl").setup({
  indent = { char = "┊" }
})


------------------------------------------------------------------------------------------------------------------------
-- SUBSTITUTION --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/gbprod/substitute.nvim"
})
local substitute = require("substitute")
substitute.setup()

vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })

------------------------------------------------------------------------------------------------------------------------
-- COMPLETIONS ---------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/saghen/blink.lib",
})

require("blink.cmp").build():wait(60000)

require("blink.cmp").setup({
  -- Default keymaps preset (Ctrl+Space to trigger, Ctrl+n/p to select, Ctrl+y to accept)
  keymap = { preset = 'default' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

------------------------------------------------------------------------------------------------------------------------
-- LSP -----------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim"
}

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require('blink.cmp').get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
vim.lsp.enable({ "lua_ls", "gopls" })

vim.diagnostic.config({
  virtual_text = true,
})

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, { desc = "format local buffer" })

