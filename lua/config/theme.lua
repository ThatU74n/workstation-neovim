local themes = { "tokyonight", "catppuccin" }
local savefile = vim.fn.stdpath("data") .. "/theme.txt"

vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg= "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "NONE", bg= "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = "NONE", bg= "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = "NONE", bg= "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { ctermbg = "NONE", bg= "NONE" })

local function load()
  local f = io.open(savefile, "r")
  if f then
    local name = f:read("*l")
    f:close()
    return name
  end
  return themes[1]
end

local function save(name)
  local f = io.open(savefile, "w")
  if f then
    f:write(name)
    f:close()
  end
end

local function apply(name)
  vim.cmd("colorscheme " .. name)
  save(name)
end

vim.api.nvim_create_user_command("ThemeSwitch", function()
  vim.ui.select(themes, { prompt = "Select theme:" }, function(choice)
    if choice then 
      apply(choice)
    end
  end)
end, {})

apply(load())
