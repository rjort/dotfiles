local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
  Text = '',
  Method = '',
  Function = '󰊕',
  Constructor = '',
  Field = '',
  Variable = '󰫧',
  Module = '',
  Class = '',
  Property = '',
  File = '',
  Enum = '󰉻',
  Interface = '',
  Reference = '',
  Unit = '󰅲',
  Keyword = '',
  EnumMember = '',
  Color = '',
  Snippet = '',
  Folder = '',
  Struct = '',
  Operator = '',
  Event = '',
  Constant = '',
  Value = '󰅩',
  TypeParameter = ''
}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ["<C-c>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Right>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      end
    end, {
      'i',
      's'
    }),
    ["<S-Tab"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, {
      'i',
      's',
    }),
  }), 
  -- choose how the completion window will appear
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]"
      })[entry.source.name]
      return vim_item
    end,
  },

  -- choose our sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' }
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = true
  },
})
