-- Full border around panes
require("full-border"):setup()

require("session"):setup {
    sync_yanked = true,
}

-- Git header with branch info
require("githead"):setup({
    show_branch = true,
    branch_color = "blue",
    show_numbers = true,
    staged_color = "green",
    unstaged_color = "yellow",
    untracked_color = "red",
})

-- Git status sign customization (optional)
th.git = th.git or {}
th.git.unstaged_sign = "M"
th.git.staged_sign   = "M"
th.git.added_sign    = "A"
th.git.deleted_sign  = "D"
th.git.untracked_sign = "?"
th.git.ignored_sign  = "-"
th.git.clean_sign    = "✔"
th.git.unstaged = ui.Style():fg("blue")
th.git.staged   = ui.Style():fg("green")
th.git.deleted  = ui.Style():fg("red"):bold()
th.git.added    = ui.Style():fg("green")
th.git.untracked = ui.Style():fg("yellow")

-- Git plugin ordering
require("git"):setup({ order = 1500 })