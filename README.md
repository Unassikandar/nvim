# Neovim Configuration Repository

This repository contains my personalized Neovim configuration.

**System Architecture Info:** Ubuntu 24.04 (x86_64) via WSL

## Config Features:

### Package Manager

- **Lazy.nvim**: A fast and feature-rich package manager for Neovim.

### Plugins Used

- **alpha.nvim**: Provides a customizable dashboard for Neovim.

- **auto-pairs.nvim**: Automatically inserts and manages pairs of parentheses.

- **barbar.nvim**: Adds a tab bar for easier navigation between buffers.

- **nvim-cmp**: Autocompletion plugin that provides intelligent code completion.

- **mason.nvim**: Portable package manager for installing and managing LSPs, DAPs, linters, and formatters.

- **neo-tree.nvim**: Offers a file system sidebar for improved file navigation.

- **null-ls.nvim**: Integrates external tools for code actions, diagnostics, formatting, hover, and completions.

- **lualine.nvim**: Configures the status line at the bottom of Neovim.

- **nvim-treesitter**: Provides syntax highlighting and code parsing based on Treesitter.

- **telescope.nvim**: Extensible fuzzy finder with powerful search capabilities.

- **todo-comments.nvim**: Enhances visibility and management of TODOs, notes, bugs, etc., with project-wide telescope integration.

- **toggleterm.nvim**: Adds terminal capabilities within Neovim for an integrated terminal experience.
  
## Dependencies and installation

Before setting up the configuration, ensure you have the following dependencies installed:

1. **Install Neovim**
   ```bash
   sudo apt install neovim
   
2. **Get some dependencies**
   ```bash
   # install ripgrep (telescope dependency (i think))
   sudo apt install ripgrep
   # install any c compiler. here we're installing gcc and its dependencies
   sudo apt install build-essential
   # For enhanced telescope (optional):
   sudo apt install fd-find

3. **Clone this repo**

   Default neovim config location is
   ```bash
   ~/.config/nvim

5. **Open neovim and load plugins**
   ```bash
   nvim .
   # from within the editor:
   :Lazy
