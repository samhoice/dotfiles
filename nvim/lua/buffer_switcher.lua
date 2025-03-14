
local function build_buffer_list_mapping(opts)
    local buffers = vim.api.nvim_list_bufs()
    local buffer_map = {}
    local current_buffer = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(buffers) do
        -- table.insert(buffer_map, vim.api.
        if opts and opts['exclude_current'] == true and current_buffer == buf then
            -- noop
        elseif not (vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf)) then
            -- noop
        else 
            -- add buffer to map
            local name = vim.api.nvim_buf_get_name(buf) 
            if name == '' then
                name = "[No Name]"
            end
            buffer_map[name] = buf
        end
    end
    -- for name,key in pairs(buffer_map) do
    --     vim.api.nvim_echo({{name .. " " .. key, "None" }}, true, {})
    -- end

    return buffer_map
end

local function switch_to_buf_from_cursor()
    local buffers = build_buffer_list_mapping()

    local buf = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_win_get_cursor(0)[1] -- Get current line number
    local line_text = vim.api.nvim_buf_get_lines(buf, line - 1, line, false)[1] -- Get the line content

    -- vim.api.nvim_echo({{line_text, "None" }}, true, {})

    local buffer_id = buffers[line_text]
    vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true})
    vim.api.nvim_set_current_buf(buffer_id)

end

-- Function to open a floating window with a list of buffers
local function open_floating_buffer_list()
    local buffers = build_buffer_list_mapping({ exclude_current = true })

    local buffer_names = {}
    for key, id in pairs(buffers) do
        table.insert(buffer_names, key)
    end

    -- Create a new buffer for the floating window
    local float_buf = vim.api.nvim_create_buf(false, true)

    -- Set the content of the floating buffer
    vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, buffer_names)

    vim.api.nvim_buf_set_keymap(float_buf, 'n', '<Esc>', ':q<CR>', { silent = true, noremap = true })
    vim.api.nvim_buf_set_keymap(float_buf, 'n', '<Cr>', ':lua switch_to_buf_from_cursor()<CR>', { silent = true, noremap = true })

    -- Set floating window options
    local win_height = math.min(#buffer_names, 20) -- Max 20 lines
    -- local win_height = 20 -- Max 20 lines
    local win_width = vim.o.columns / 2
    local win_opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        col = math.max(0, (vim.o.columns - win_width) / 2),
        row = math.max(0, (vim.o.lines - win_height) / 2),
        anchor = "NW",
        style = "minimal",
	border = "single",
    }

    -- Create the floating window
    local float_win = vim.api.nvim_open_win(float_buf, true, win_opts)

    -- Set some additional options for the floating window
    vim.api.nvim_win_set_option(float_win, 'wrap', false)
    vim.api.nvim_win_set_option(float_win, 'cursorline', false)
end

_G.open_floating_buffer_list = open_floating_buffer_list
_G.switch_to_buf_from_cursor = switch_to_buf_from_cursor
-- return {
--     open_floating_buffer_list = open_floating_buffer_list
-- }
