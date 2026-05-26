---@type LazySpec
return {
  "stevearc/aerial.nvim",
  branch = "nvim-0.11",
  config = function()
    require("aerial").setup({
      backends = {
        ["_"]            = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        yaml             = { "treesitter" },
      },
      layout = {
        default_direction = "right",
        placement = "edge",
        min_width = 45,
        max_width = 65,
      },
      icons = {
        Empty = " ",
      },
      post_parse_symbol = function(bufnr, item, ctx)
        local detail = ctx.symbol and ctx.symbol.detail or nil
        if detail and detail ~= "" then
          item.name = item.name .. detail
        end
        return true
      end,
      post_add_all_symbols = function(bufnr, items, ctx)
        if not items or #items == 0 then
          return items
        end

        local function add_seperators(list)
          if not list or #list == 0 then
            return list
          end

          local result = {}
          for i, item in ipairs(list) do
            if i > 1 then
              table.insert(result, {
                name = "",
                kind = "Empty",
                level = item.level,
                lnum = item.lnum,
                end_lnum = item.lnum,
                col = 0,
                end_col = 0,
                selection_range = item.selection_range,
              })
            end
            if item.children and #item.children > 0 then
              item.children = add_seperators(item.children)
            end
            table.insert(result, item)
          end

          return result
        end

        return add_seperators(items)
      end,
    })
  end,
}
