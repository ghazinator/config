return {
  "nvim-lualine/lualine.nvim",

  ---@param opts table
  opts = function(_, opts)
    opts.options.component_separators = { left = '', right = '' }
    opts.options.section_separators = { left = '', right = '' }

    opts.sections.lualine_z = {}
  end
}
