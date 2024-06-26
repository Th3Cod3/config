return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"},
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                position = "right"
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added = "A",
                        deleted = "D",
                        modified = "M",
                        renamed = "R",
                        -- Status type
                        untracked = "U",
                        ignored = "I",
                        unstaged = "M",
                        staged = "S",
                        conflict = "C"
                    },
                    align = "right"
                }
            }
        })
        vim.keymap.set("n", "<C-e>", ":Neotree filesystem reveal right<CR>", {})
    end
}
