return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = { "java" },
    config = function()
      local home = os.getenv('HOME')
      local mason_path = home .. '/.local/share/nvim/mason/packages'
      local jdtls_path = mason_path .. '/jdtls'

      -- 1. Workspace Setup
      -- JDTLS creates a folder for each project to store its cache/index
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

      -- 2. Find the Launcher and Config
      -- These paths are standard for a Mason-installed JDTLS
      local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
      -- Change 'config_linux' to 'config_mac' if you move to a Mac
      local config_os = jdtls_path .. '/config_linux' 

      -- 3. Debugging Bundles
      -- This allows nvim-dap to talk to the Java Debug Server
      local bundles = {
        vim.fn.glob(mason_path .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.adapter-*.jar', true)
      }

      -- 4. Main Configuration
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx2g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', launcher_jar,
          '-configuration', config_os,
          '-data', workspace_dir
        },

        -- This detects the root of your project (where build.gradle is)
        root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

        -- Enable the debugger
        init_options = {
          bundles = bundles,
        },

        settings = {
          java = {
            -- Force Gradle/Maven import
            import = {
              gradle = { enabled = true },
              maven = { enabled = true },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            -- Mapping your specific JDK
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-zulu-openjdk-ca",
                  default = true,
                },
              },
            },
          },
        },
      }

      -- 5. Attach Function
      -- This runs when the LSP starts. It enables debugging and keybindings.
      config['on_attach'] = function(client, bufnr)
        -- Enable debugger support
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })

        -- Helper for keymaps
        local opts = { silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>df', function() require('jdtls').test_class() end, opts)
        vim.keymap.set('n', '<leader>dn', function() require('jdtls').test_nearest_method() end, opts)
        vim.keymap.set('n', '<leader>oi', function() require('jdtls').organize_imports() end, opts)
      end

      -- Finally, start the server
      require('jdtls').start_or_attach(config)
    end,
  },
}
