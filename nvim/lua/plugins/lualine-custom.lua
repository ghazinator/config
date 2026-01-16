return {
  "nvim-lualine/lualine.nvim",

  ---@param opts table
  opts = function(_, opts)
    -- Task 1: Remove Powerline separators (This part is correct)
    opts.options.component_separators = { left = '', right = '' }
    opts.options.section_separators = { left = '', right = '' }

    -- Task 2: Remove the time
    -- Set the 'lualine_z' section to be an empty table.
    -- This removes the time but doesn't add a new 'location'.
    opts.sections.lualine_z = {} -- <-- THIS IS THE FIX
  end
}
