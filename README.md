<div align="center">

# fzf-nerdfont.nvim

A Neovim plugin that provides a handy way to search
and insert Nerd Font icons<br />using [`ibhagwan/fzf-lua`](https://github.com/ibhagwan/fzf-lua)
while you edit.
<br />

![Example GIF](https://raw.githubusercontent.com/stephansama/static/refs/heads/main/nvim-plugins/fzf-nerdfont.gif)

</div>

## 📋 Installation

Using [`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
require("lazy").setup({
    spec = {
      {
        "stephansama/fzf-nerdfont.nvim",
        lazy = true,
        dependencies = { "ibhagwan/fzf-lua" },
        cmd = "FzfNerdfont",
        keys = {
            { "<leader>fi", "<CMD>FzfNerdfont<CR>", desc= "Open fzf nerd font picker" }
        }
      }
    }
})
```

## ☄ Getting started

This plugin provides a command `FzfNerdFont` that opens a `fzf-lua` window
with a list of Nerd Font icons.
You can search for an icon and press enter to insert it into the current buffer.

## ⚙ Configuration

> [!NOTE]
> The options are also available in Neovim by calling `:h fzf-nerdfont.options`

<details>
<summary>Click to unfold the full list of options with their default values</summary>

```lua
require("fzf-nerdfont").setup({
    -- you can copy the full list from lua/fzf-nerdfont/config.lua
})
```

</details>

## 🧰 Commands

|   Command   |         Description        |
|-------------|----------------------------|
|  `:FzfNerdFont`  |     Shows the Nerd Font icon list with fzf-lua.    |

---

## FAQ

1. _**How to use this plugin from within insert mode?**_
  ```lua
  local function insert_fzf_nerdfont()
    vim.cmd.stopinsert()
    vim.cmd.FzfNerdfont()
  end

  vim.keymap.set("i", "<C-i>", insert_fzf_nerdfont, {
    noremap = true,
    silent = true,
  })
  ```

## ⌨ Contributing

PRs and issues are always welcome. Make sure to provide as much context as possible when opening one.

## 🗞 Wiki

You can find guides and showcase of the plugin on [the Wiki](https://github.com/stephansama/fzf-nerdfont.nvim/wiki).

## Special Thanks

A very special thanks to [DrKJeff16](https://github.com/DrKJeff16/) for helping me with the initial setup of this plugin.

And a special thank you to [fzf-lua](https://github.com/ibhagwan/fzf-lua).
