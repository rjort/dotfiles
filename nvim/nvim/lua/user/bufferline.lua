require('bufferline').setup{
  options = {
    numbers = 'ordinal',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'Explorer',
        text_align = 'center',
        separator = true
      }
    },
  },
}

