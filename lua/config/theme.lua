local themes = { "tokyonight", "catppuccin" }
local savefile = vim.fn.stdpath("data") .. "/theme.txt"

--- Global highlight settings
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { ctermbg = "NONE", bg = "NONE" })

--- Custom highlight settings
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ffcc00", bg = "#3d3000" })
vim.api.nvim_set_hl(0, "FgWhite", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "FgGitHub", { fg = "#FEFEFE" })
vim.api.nvim_set_hl(0, "FgGitea", { fg = "#609926" })
vim.api.nvim_set_hl(0, "FgHelm", { fg = "#3A46E8" })
vim.api.nvim_set_hl(0, "FgTerraform", { fg = "#7B42BC" })
vim.api.nvim_set_hl(0, "FgK8s", { fg = "#326CE5" })
vim.api.nvim_set_hl(0, "FgArgoCD", { fg = "#EE6600" })

local ICON = {
  yaml = { icon = "󰈙", color = "#6d8086", name = "Yaml" },

  dap_breakpoint = { text = "󰐾 ", texthl = "DapBreakpoint", linehl = "", numhl = "" },
  dap_stopped = { text = "▶", texthl = "DapStopped", linehl = "DapStopped", numhl = "" },
  github = { icon = " ", hl = "FgGitHub" }, -- nf-dev-github
  gitea = { icon = " ", hl = "FgGitea" }, -- nf-dev-gitea
  github_actions = { icon = " ", hl = "FgGitHub" }, -- nf-dev-github_actions
  test = { icon = " ", hl = "FgWhite" },
  document = { icon = "󱔘 ", hl = "FgWhite" },
  ansible = { icon = " ", hl = "FgWhite" }, -- nf-dev-ansible
  helm = { icon = " ", hl = "FgHelm" }, -- nf-dev-helm
  terraform = { icon = " ", hl = "FgTerraform" }, -- nf-dev-terraform
  k8s = { icon = " ", hl = "FgK8s" }, -- nf-dev-kubernetes
  argocd = { icon = " ", hl = "FgArgoCD" }, -- nf-dev-argocd
}

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

return ICON
