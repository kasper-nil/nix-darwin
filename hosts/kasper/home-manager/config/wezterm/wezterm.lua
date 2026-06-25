local wezterm = require("wezterm")
local config = wezterm.config_builder()

local mocha = require("lib.mocha")
local pill = require("lib.pill")
local widgets = require("lib.widgets")

local PILL_LEFT = pill.LEFT
local PILL_RIGHT = pill.RIGHT

-- ── Font & Colors ────────────────────────────────────────────
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16

-- ── Window ───────────────────────────────────────────────────
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 0
config.window_close_confirmation = "AlwaysPrompt"
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true

config.window_padding = {
  left = "0.75cell",
  right = "0.75cell",
  top = "0.50cell",
  bottom = "0.25cell",
}

-- ── Rendering ────────────────────────────────────────────────
config.max_fps = 120
config.animation_fps = 60

-- ── Scrollback ───────────────────────────────────────────────
config.scrollback_lines = 10000
config.enable_kitty_keyboard = true

-- ── Tab Bar ──────────────────────────────────────────────────
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 50
config.show_new_tab_button_in_tab_bar = false

config.window_frame = {
  border_top_height = "0.5cell",
  border_bottom_height = "0.5cell",
  border_left_width = "0.75cell",
  border_right_width = "0.75cell",
  border_top_color = mocha.base,
  border_bottom_color = mocha.base,
  border_left_color = mocha.base,
  border_right_color = mocha.base,
  active_titlebar_bg = mocha.base,
  inactive_titlebar_bg = mocha.base,
  active_titlebar_border_bottom = mocha.base,
  inactive_titlebar_border_bottom = mocha.base,
}

config.colors = {
  tab_bar = {
    background = mocha.base,
    inactive_tab_edge = mocha.base,
    active_tab = {
      bg_color = mocha.base,
      fg_color = mocha.text,
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = mocha.base,
      fg_color = mocha.overlay0,
    },
    inactive_tab_hover = {
      bg_color = mocha.base,
      fg_color = mocha.subtext0,
      italic = false,
    },
  },
}

-- ── Tab Title ──────────────────────────────────────────────
local SHELLS = {
  zsh = true, bash = true, fish = true, nu = true, sh = true, dash = true,
}

local TERMINAL_ICON = wezterm.nerdfonts.cod_terminal

local PROCESS_ICONS = {
  nvim           = wezterm.nerdfonts.dev_vim,
  vim            = wezterm.nerdfonts.dev_vim,
  yazi           = wezterm.nerdfonts.md_folder,
  lazygit        = wezterm.nerdfonts.dev_git,
  git            = wezterm.nerdfonts.dev_git,
  tig            = wezterm.nerdfonts.dev_git,
  gitui          = wezterm.nerdfonts.dev_git,
  spotify_player = wezterm.nerdfonts.fa_spotify,
  ncspot         = wezterm.nerdfonts.fa_spotify,
  k9s            = wezterm.nerdfonts.md_kubernetes,
  lazydocker     = wezterm.nerdfonts.md_docker,
  docker         = wezterm.nerdfonts.md_docker,
  btop           = wezterm.nerdfonts.md_monitor,
  htop           = wezterm.nerdfonts.md_monitor,
  claude         = wezterm.nerdfonts.md_robot,
  node           = wezterm.nerdfonts.md_nodejs,
  npm            = wezterm.nerdfonts.md_nodejs,
  pnpm           = wezterm.nerdfonts.md_nodejs,
  bun            = wezterm.nerdfonts.md_nodejs,
  python         = wezterm.nerdfonts.md_language_python,
  python3        = wezterm.nerdfonts.md_language_python,
  uv             = wezterm.nerdfonts.md_language_python,
  cargo          = wezterm.nerdfonts.dev_rust,
  rustc          = wezterm.nerdfonts.dev_rust,
  ssh            = wezterm.nerdfonts.md_ssh,
  psql           = wezterm.nerdfonts.md_database,
  pgcli          = wezterm.nerdfonts.md_database,
  mycli          = wezterm.nerdfonts.md_database,
  lazysql        = wezterm.nerdfonts.md_database,
  aerc           = wezterm.nerdfonts.md_email,
  neomutt        = wezterm.nerdfonts.md_email,
  himalaya       = wezterm.nerdfonts.md_email,
  newsboat       = wezterm.nerdfonts.md_rss,
}

local app_colors = {
  terminal   = mocha.subtext0,
  vim        = "#57a143",
  yazi       = mocha.peach,
  git        = "#f05032",
  spotify    = "#1ed760",
  kubernetes = "#326ce5",
  docker     = "#2496ed",
  monitor    = mocha.teal,
  claude     = "#d97757",
  nodejs     = "#83cd29",
  python     = "#ffd43b",
  rust       = "#dea584",
  ssh        = mocha.sky,
  database   = "#4d8fc7",
  mail       = mocha.lavender,
  rss        = "#f26522",
}

local ICON_COLORS = {
  nvim           = app_colors.vim,
  vim            = app_colors.vim,
  yazi           = app_colors.yazi,
  lazygit        = app_colors.git,
  git            = app_colors.git,
  tig            = app_colors.git,
  gitui          = app_colors.git,
  spotify_player = app_colors.spotify,
  ncspot         = app_colors.spotify,
  k9s            = app_colors.kubernetes,
  lazydocker     = app_colors.docker,
  docker         = app_colors.docker,
  btop           = app_colors.monitor,
  htop           = app_colors.monitor,
  claude         = app_colors.claude,
  node           = app_colors.nodejs,
  npm            = app_colors.nodejs,
  pnpm           = app_colors.nodejs,
  bun            = app_colors.nodejs,
  python         = app_colors.python,
  python3        = app_colors.python,
  uv             = app_colors.python,
  cargo          = app_colors.rust,
  rustc          = app_colors.rust,
  ssh            = app_colors.ssh,
  psql           = app_colors.database,
  pgcli          = app_colors.database,
  mycli          = app_colors.database,
  lazysql        = app_colors.database,
  aerc           = app_colors.mail,
  neomutt        = app_colors.mail,
  himalaya       = app_colors.mail,
  newsboat       = app_colors.rss,
}

local TERMINAL_ICON_COLOR = app_colors.terminal

local function pane_proc(pane)
  local proc_path = pane.foreground_process_name or ""
  return proc_path:match("([^/\\]+)$") or ""
end

local function pane_icon_color(pane)
  local proc = pane_proc(pane)
  if proc == "" or SHELLS[proc] then
    return TERMINAL_ICON, TERMINAL_ICON_COLOR
  end
  return PROCESS_ICONS[proc] or TERMINAL_ICON,
         ICON_COLORS[proc] or TERMINAL_ICON_COLOR
end

local function tab_title(tab_info)
  local manual = tab_info.tab_title
  if manual and #manual > 0 then
    return { manual_label = manual }
  end

  local active = tab_info.active_pane
  local active_proc = pane_proc(active)
  local active_icon, active_color, active_label

  if active_proc == "" or SHELLS[active_proc] then
    active_icon = TERMINAL_ICON
    active_color = TERMINAL_ICON_COLOR
    local cwd_uri = active.current_working_dir
    local dir
    if cwd_uri then
      local cwd = cwd_uri.file_path or tostring(cwd_uri)
      dir = cwd:match("([^/]+)/?$")
    end
    active_label = dir or "shell"
  else
    active_icon = PROCESS_ICONS[active_proc] or TERMINAL_ICON
    active_color = ICON_COLORS[active_proc] or TERMINAL_ICON_COLOR
    active_label = active_proc
  end

  local panes = tab_info.panes or {}
  local extras = {}
  for _, p in ipairs(panes) do
    if p.pane_id ~= active.pane_id then
      local i, c = pane_icon_color(p)
      table.insert(extras, { icon = i, color = c })
    end
  end

  return {
    icon = active_icon,
    icon_color = active_color,
    label = active_label,
    extras = extras,
  }
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
  local index = tostring(tab.tab_index + 1)
  local t = tab_title(tab)

  local bg, label_fg
  if tab.is_active then
    bg, label_fg = mocha.surface0, mocha.text
  elseif hover then
    bg, label_fg = mocha.surface0, mocha.subtext0
  else
    bg, label_fg = mocha.mantle, mocha.overlay0
  end

  local gap = "\u{2009}"
  local elements = {
    { Background = { Color = mocha.base } },
    { Foreground = { Color = bg } },
    { Text = gap .. PILL_LEFT },
    { Background = { Color = bg } },
  }
  if tab.is_active then
    table.insert(elements, { Attribute = { Intensity = "Bold" } })
  end

  if t.manual_label then
    local overhead = #index + 5
    local available = max_width - overhead
    if available < 10 then available = 10 end
    local label = wezterm.truncate_right(t.manual_label, available)
    table.insert(elements, { Foreground = { Color = label_fg } })
    table.insert(elements, { Text = " " .. index .. " " .. label .. " " })
  else
    local extras_width = #t.extras > 0 and (2 * #t.extras + 1) or 0
    local overhead = #index + 5 + 2 + extras_width
    local available = max_width - overhead
    if available < 8 then available = 8 end
    local label = wezterm.truncate_right(t.label, available)

    table.insert(elements, { Foreground = { Color = label_fg } })
    table.insert(elements, { Text = " " .. index .. " " })
    table.insert(elements, { Foreground = { Color = t.icon_color } })
    table.insert(elements, { Text = t.icon })
    table.insert(elements, { Foreground = { Color = label_fg } })
    table.insert(elements, { Text = " " .. label })

    if #t.extras > 0 then
      table.insert(elements, { Text = "  " })
      for i, e in ipairs(t.extras) do
        table.insert(elements, { Foreground = { Color = e.color } })
        table.insert(elements, { Text = e.icon })
        if i < #t.extras then
          table.insert(elements, { Foreground = { Color = label_fg } })
          table.insert(elements, { Text = " " })
        end
      end
    end
    table.insert(elements, { Text = " " })
  end

  table.insert(elements, { Background = { Color = mocha.base } })
  table.insert(elements, { Foreground = { Color = bg } })
  table.insert(elements, { Text = PILL_RIGHT })
  return elements
end)

-- ── Status Bar ───────────────────────────────────────────────
config.status_update_interval = 5000

-- Add/remove/reorder widgets here. Each name maps to widgets/<name>.lua.
local active_widgets = widgets.load {
  -- "claude",
  -- "battery",
  -- "clock",
}

wezterm.on("update-status", function(window, pane)
  window:set_right_status(wezterm.format(widgets.render(active_widgets, window, pane)))
end)

-- ── Option Key ───────────────────────────────────────────────
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

-- ── Fibonacci Split ──────────────────────────────────────────
-- Split focused pane evenly along its longer visual axis. Spiral emerges
-- because each split flips which axis is longer.
wezterm.on("smart-split", function(window, pane)
  local dims = pane:get_dimensions()
  local w = dims.pixel_width or dims.cols
  local h = dims.pixel_height or (dims.viewport_rows * 2)
  local direction = w >= h and "Right" or "Bottom"
  pane:split { direction = direction, size = 0.5 }
end)

-- ── Keys ─────────────────────────────────────────────────────
config.keys = {
  { key = "k", mods = "CMD", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },
  { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },

  -- Pane navigation
  { key = "LeftArrow",  mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "DownArrow",  mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },

  -- Pane resize
  { key = "LeftArrow",  mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
  { key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
  { key = "UpArrow",    mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize { "Up", 3 } },
  { key = "DownArrow",  mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize { "Down", 3 } },

  -- Close pane first, then tab when last pane
  { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- New pane (tall layout)
  { key = "p", mods = "CMD", action = wezterm.action.EmitEvent("smart-split") },
}

-- CMD+SHIFT+1..9 moves current tab to that position (others shift to fill)
for i = 1, 9 do
  table.insert(config.keys, {
    key = "phys:" .. tostring(i),
    mods = "CMD|SHIFT",
    action = wezterm.action.MoveTab(i - 1),
  })
end

-- ── Mouse ────────────────────────────────────────────────────
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

return config
