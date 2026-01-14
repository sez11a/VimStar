return {
  {
    'nvim-java/nvim-java',
    config = function()
      vim.lsp.config('jdtls', {
        jdk = {
          auto_install = false,
          version = 21,
        },
        java = {
          configuration = {
            runtimes = {
              {
                name = "Zulu Java 21",
                path = "/usr/lib/jvm/java-21-zulu-openjdk-ca",
                default = true,
              }
            }
          }
        }
      })
      vim.lsp.enable('jdtls')
    end,
  }
}
