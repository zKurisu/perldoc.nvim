# perldoc.nvim

A simple way to open perldoc in nvim. Only support for functions not methodes.

# Features

It will open the `perldoc xxx::xxx` about the function under cursor on the right side of current window:

![](./img/test.png)

You can also place the cursor on a module name to open `perldoc`.

# Installation

Just clone it!

# Keymap

The default keybinding is `gh` when the filetype is `perl`, you can change it by reset the `vim.g.perldoc_keymap` variable:

    vim.g.perldoc_keymap = { "n", "gh", ":lua Perldoc()<CR>" }


