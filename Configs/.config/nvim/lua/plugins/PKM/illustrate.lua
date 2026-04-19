return {
'NelsonAguirre/illustrate.nvim',
dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
},
keys = function()
    local illustrate = require('illustrate')
    local illustrate_finder = require('illustrate.finder')

    return {
        {
            "<leader>ki",
            function() illustrate.create_and_open_svg() end,
            desc = "Create and open a new SVG file with provided name."
        },
        {
            "<leader>ka",
            function() illustrate.create_and_open_ai() end,
            desc = "Create and open a new Adobe Illustrator file with provided name."
        },
        {
            "<leader>ko",
            function() illustrate.open_under_cursor() end,
            desc = "Open file under cursor (or file within environment under cursor)."
        },
        {
            "<leader>kf",
            function() illustrate_finder.search_and_open() end,
            desc = "Use telescope to search and open illustrations in default app."
        },
        {
            "<leader>kc",
            function() illustrate_finder.search_create_copy_and_open() end,
            desc = "Use telescope to search existing file, copy it with new name, and open it in default app."
        },
    }
end,
opts = {
    prompt_caption= true,
    prompt_label= true,
    pkm= {
      path_pkm= PKM_path,
      relative_path_attachments_of_pkm="08-Attachments",
    },
    -- optionally define options. Look at the "Default Config File Example"
    -- under "Configuration" in the GitHub README.
},
}
