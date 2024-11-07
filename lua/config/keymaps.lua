-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {

    group = vim.api.nvim_create_augroup("Yank", { clear = true }),

    callback = function()
      vim.fn.system("clip.exe", vim.fn.getreg('"'))
    end,
  })
end

-- exit to file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Set the mapleader to the space key
vim.g.mapleader = " "

-- Insert mode mappings for quickly escaping to normal mode
-- vim.api.nvim_set_keymap("i", "fj", "<Esc>", { noremap = true })
-- vim.api.nvim_set_keymap("i", "jf", "<Esc>", { noremap = true })

-- Insert mode mappings for arrow keys in insert mode
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })

-- Copy from the cursor to the end of the line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Normal mode mappings:
-- Quit Vim
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })
-- Save (update) the current file
vim.api.nvim_set_keymap("n", "<leader>s", ":up<CR>", { noremap = true })

-- Save (update) the current file while in insert mode
-- vim.api.nvim_set_keymap('i', '<leader>s', '<C-o>:up<CR>', {noremap = true})
-- Save (update) the current file while in insert mode
vim.api.nvim_set_keymap("i", "<C-s>", "<C-o>:up<CR>", { noremap = true })
-- (only works in firenvim) save (update) the current file while in insert mode and exit
vim.api.nvim_set_keymap("i", "<C-Enter>", "<Esc>:up<CR>:q<CR>", { noremap = true })
-- (only works in firenvim) save (update) the current file while in normal mode and exit
vim.api.nvim_set_keymap("n", "<C-Enter>", "<Esc>:up<CR>:q<CR>", { noremap = true })

-- Function to adjust font size
function adjust_font_size(step)
  local current_size = tonumber(vim.fn.eval("&guifont"):match("h(%d+)")) or 23
  local new_size = current_size + step
  vim.cmd("set guifont=*:h" .. new_size)
end

-- Keybindings for increasing and decreasing font size
vim.api.nvim_set_keymap("n", "<C-=>", ":lua adjust_font_size(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-->", ":lua adjust_font_size(-1)<CR>", { noremap = true, silent = true })

-- Normal mode mappings for movement:
-- Move to previous paragraph
vim.api.nvim_set_keymap("n", "K", "{", { noremap = true })
-- Move to next paragraph
vim.api.nvim_set_keymap("n", "J", "}", { noremap = true })
-- Move to beginning of line
vim.api.nvim_set_keymap("n", "H", "^", { noremap = false })
vim.api.nvim_set_keymap("v", "H", "^", { noremap = false })
-- Move to end of line
vim.api.nvim_set_keymap("n", "L", "$", { noremap = false })
vim.api.nvim_set_keymap("v", "L", "$", { noremap = false })

local function underscore_line_toggle()
  local cur_col = vim.fn.col(".")
  if cur_col == 1 then
    -- if at the start, move to the start of text, or the end if already there
    vim.cmd("norm! _")
    if vim.fn.col(".") == cur_col then
      vim.cmd("norm! $")
    end
  elseif cur_col == vim.fn.col("$") - 1 then
    -- if at the end move to the start
    vim.cmd("norm! 0")
  else
    -- move to the start of text, or the end if already there
    vim.cmd("norm! _")
    if vim.fn.col(".") == cur_col then
      vim.cmd("norm! $")
    end
  end
end
vim.keymap.set({ "n", "v" }, "_", underscore_line_toggle, { noremap = true, silent = true })

-- Normal mode mapping for 'j' and 'k' with count
vim.api.nvim_set_keymap("n", "j", 'v:count ? "j" : "gj"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("n", "k", 'v:count ? "k" : "gk"', { expr = true, noremap = true })
-- nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
-- nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

-- open Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Map Backspace and Ctrl + h to delete the previous word
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-h>", "<C-w>", { noremap = true })
