--- Configuration for Yaml 

-- Check if root dir has marker
local function find_ancestor(markers)
  local path = vim.fn.expand("%:p:h")
  local prev
  while path ~= prev do
    for _, marker in ipairs(markers) do
      local full = path .. "/" .. marker
      if vim.fn.filereadable(full) == 1 or vim.fn.isdirectory(full) == 1 then
        return path
      end
    end
    prev = path
    path = vim.fn.fnamemodify(path, ":h")
  end
end

local server, root_dir

root_dir = find_ancestor({ "Chart.yaml" })
if root_dir then
  server = "helm_ls"
else
  root_dir = find_ancestor({ "ansible.cfg", "roles" })
  if root_dir then
    server = "ansiblels"
  else
    root_dir = find_ancestor({ ".git" }) or vim.fn.getcwd()
    server = "yamlls"
  end
end

vim.lsp.start(vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, {
  root_dir = root_dir,
}))
