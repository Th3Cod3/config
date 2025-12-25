local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

M.terminal_picker = function()
    local terminals = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
            local name = vim.api.nvim_buf_get_name(buf)
            local cwd = vim.fn.fnamemodify(name, ":h")
            table.insert(terminals, {
                bufnr = buf,
                name = name,
                cwd = cwd,
            })
        end
    end

    pickers
        .new({}, {
            prompt_title = "Terminal Buffers",
            finder = finders.new_table({
                results = terminals,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = string.format(
                            "  %d  %s",
                            entry.bufnr,
                            entry.cwd ~= "" and entry.cwd or entry.name
                        ),
                        ordinal = entry.name,
                        bufnr = entry.bufnr,
                    }
                end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.api.nvim_open_win(selection.bufnr, true, {
                        relative = 'editor',
                        width = math.floor(vim.o.columns * 0.8),
                        height = math.floor(vim.o.lines * 0.8),
                        row = math.floor(vim.o.lines * 0.1),
                        col = math.floor(vim.o.columns * 0.1),
                        border = 'rounded',
                    })
                end)
                return true
            end,
        })
        :find()
end


return M
