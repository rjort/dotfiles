local function codeium_status()
  local status = vim.fn['codeium#GetStatusString']()
  return status
end

require('lualine').setup{
  options = {
    theme = 'gruvbox_dark'
  },
  sections = {
    lualine_c = {
      'filename',
      {
        codeium_status, color = { fg = '#ff9e64', gui = 'bold' }
      }
    }
  }
}
