local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local conditional = function(fn)
  local utils = require('null-ls.utils').make_conditional_utils()
  return fn(utils)
end

null_ls.setup({
  debug = false,

  sources = {
    formatting.prettier,
    diagnostics.eslint.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end
    }), -- eslint.with

    conditional(function(utils)
      return utils.root_has_file('Gemfile')
      and null_ls.builtins.formatting.rubocop.with({
        command = 'bundle',
        args = vim.list_extend(
          { 'exec', 'rubocop' },
          null_ls.builtins.formatting.rubocop._opts.args
        ), -- args vimlitextend
      }) --rubocop.with
      or null_ls.builtins.diagnostics.rubocop
    end), -- conditional1

    conditional(function(utils)
      return utils.root_has_file('Gemfile')
      and null_ls.builtins.formatting.rubocop.with({
        command = 'bundle',
        args = vim.list_extend(
          { 'exec', 'rubocop' },
          null_ls.builtins.formatting.rubocop._opts.args
        ), -- args vimlistextend
      }) --rubocop.with
      or null_ls.builtins.diagnostics.rubocop
    end), -- conditional2
  }, -- sources
}) --setup
