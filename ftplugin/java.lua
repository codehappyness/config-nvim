---@diagnostic disable: unused-function
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages


local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
--capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

-- Determine OS
local home = os.getenv "HOME"
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "linux"
else
  print "Unsupported system"
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end
local function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

---@diagnostic disable-next-line: unused-local
    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
  vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/app/vscode-java-test/server/*.jar"), "\n"))
  vim.list_extend(
    bundles,
    vim.split(
      vim.fn.glob(
        home .. "/app/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
      ),
      "\n"
    )
  )
  vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.getcwd() .. "/WebContent/WEB-INF/lib/*.jar"), "\n"))
end

local referenced_list = {}

vim.list_extend(referenced_list, vim.split(vim.fn.glob(vim.fn.getcwd() .. "/WebContent/WEB-INF/lib/*.jar"), "\n"))

--print_r(bundles)
local config = {
  cmd = {
    "java", -- or '/path/to/java11_or_newer/bin/java'
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(home .. "/jdt/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/jdt/config_" .. CONFIG,
    "-data", workspace_dir,
  },
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = true,
        settings = {
          url = home .. "app/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },

      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = bundles,
  },
}
--config.settings = {
--  java = {
--    project = {
--      referencedLibraries = {
--        ''
--
--      },
--    }
--  }
--}

jdtls.start_or_attach(config)
require("jdtls.setup").add_commands()
--vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
--vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
--vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
----vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
--vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
----vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

