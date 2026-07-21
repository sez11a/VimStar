local M = {}

function M.has_executable(name)
  return vim.fn.executable(name) == 1
end

function M.has_pandoc()
  return M.has_executable("pandoc")
end

function M.has_typst()
  if vim.fn.executable("typst") == 1 then
    return true
  end
  local mason_path = vim.fn.stdpath("data") .. "/mason/packages/typst"
  if vim.uv.fs_stat(mason_path) ~= nil then
    return pcall(vim.fn, "typst") or true
  end
  return false
end

function M.has_python_debugger()
  local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
  if vim.uv.fs_stat(debugpy_path) ~= nil then
    return true
  end
  local venv = os.getenv("VIRTUAL_ENV")
  if venv and vim.uv.fs_stat(venv .. "/bin/python") then
    return true
  end
  return false
end

function M.has_java_debugger()
  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  return vim.uv.fs_stat(jdtls_path) ~= nil and (M.has_executable("java") or true)
end

function M.has_go_debugger()
  if not M.has_executable("go") then
    return false
  end
  local ok, _ = pcall(require, "nvim-dap-go")
  return ok
end

function M.has_ollama()
  local ollama_host = os.getenv("OLLAMA_HOST") or "127.0.0.1:11434"
  if not ollama_host:find(":") then
    ollama_host = ollama_host .. ":11434"
  end
  local result = vim.fn.system({
    "sh", "-c",
    "curl -s -o /dev/null -w '%{http_code}' --connect-timeout 2 http://" .. ollama_host .. "/api/tags 2>/dev/null || echo '000'"
  })
  return result and vim.trim(result) ~= "000" and vim.trim(result) ~= ""
end

function M.has_yarn()
  return vim.fn.executable("yarn") == 1 or vim.fn.executable("npm") == 1
end

function M.report(msg)
  vim.notify(msg, vim.log.levels.WARN, { title = "VimStar" })
end

return M