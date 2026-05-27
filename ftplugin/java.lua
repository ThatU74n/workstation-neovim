-- Configurations for Java ---
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

local home = os.getenv('HOME')

local jdtls = require('jdtls')
local spring_boot = require('spring_boot')

-- The path of java that run jdtls server
local java = '/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home/bin/java'


-- The path of jdtls jar (assuming mason)
local jdtls_jar    = home .. '/.local/share/nvim/mason/packages/jdtls'
local jdtls_config = home .. '/.local/share/nvim/mason/packages/jdtls/config_mac'
local lombok_jar   = home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar'


-- The bundles
-- - java-debug-adapter
-- - spring-boot-tools
local debug_bundle = vim.fn.glob(
  home .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
  true)
local spring_boot_bundle = spring_boot.java_extensions()
local bundles = { debug_bundle }
vim.list_extend(bundles, spring_boot_bundle)


-- This block determines the root directory of a Java project by checking the root markers.
-- JDTLS store the project data within a data directory.
-- If we are working with multiple projects, we have to create a workspace for each of them. Then point jdtls to the right workspace for the current project.
local root_markers = {
  '.git',
  'pom.xml',
  'mvnw'
}
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == nil then
  print('Project root not found. Please ensure you are in a Java project directory.')
  return
end
local workspace_dir = home .. '/.local/share/jdtls/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

-- attach function for dap
local on_attach = function(client, bufnr)
  require('keymap.dap').setup()
  jdtls.setup_dap({
    config_overrides = {
      hotcodereplace = 'auto',
    },
  })
end


-- Config block for JDTLS
local config = {
  root_dir = root_dir,
  init_options = {
    bundles = bundles,
  },
  on_attach = on_attach,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      -- format = {
      --   settings = {
      --     url = vim.fn.expand('~/.config/nvim/java-formatter.xml'),
      --     profile = 'IntelliJStyle',
      --   },
      -- },

      -- No collaspe imports to *
      saveActions = {
        organizeImports = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },

      -- Handle multiple runtimes
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = '/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home',
            default = true
          },
          {
            name = 'JavaSE-17',
            path = '/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home',
          },
          {
            name = 'JavaSE-21',
            path = '/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home',
          },
        }
      }
    }
  },

  -- Entry point of jdtls server
  cmd = {
    java,
    '-javaagent:' .. lombok_jar,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(
    jdtls_jar .. '/plugins/org.eclipse.equinox.launcher_*.jar'
  ),
    '-configuration', jdtls_config,
    '-data', workspace_dir,
  }
}

jdtls.start_or_attach(config)

vim.notify('JDTLS started!')
