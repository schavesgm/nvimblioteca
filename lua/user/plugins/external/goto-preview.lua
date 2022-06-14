local status_ok, preview = pcall(require, "goto-preview")
if not status_ok then return end

preview.setup {
    width = 120,
    height = 15,
    border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"},
    default_mappings = true,
    resizing_mappings = true,
    debug = false,
    opacity = nil,
    post_open_hook = nil,
    references = {
        telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
    },
    -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
    focus_on_open = true,
    dismiss_on_move = false,
    force_close = true,
    bufhidden = "wipe",
}
