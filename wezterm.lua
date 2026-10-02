local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- change config now
config.default_domain = 'WSL:Ubuntu'
config.default_cwd = "/home/jon"
config.font_size = 11

local current_theme = 1
local themes = {
  'Black Metal (Bathory) (base16)',
--  'Black Metal (Burzum) (base16)',
--  'Black Metal (Khold) (base16)',
--   'Seol (Gogh)',
--   'Slate (Gogh)',
--   'Solarized Light (Gogh)',
   'PaperColor Light (base16)',
}
config.color_scheme = themes[current_theme]
--
-- Keybinds
config.leader = { key = 'F6', mods = '', timeout_milliseconds = 1000}

config.keys = {
   { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b\r") },
   {
      key = 't', mods = 'LEADER', action = wezterm.action.EmitEvent 'toggle-theme',
   },
   {
      key = 'w', mods = 'LEADER', action = wezterm.action.PromptInputLine {
         description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'Which workspace?' },
         },
         action = wezterm.action_callback(function(window, pane, line)
               -- line will be `nil` if they hit escape without entering anything
               -- An empty string if they just hit enter
               -- Or the actual line of text they wrote
               if line then
                  window:perform_action(
                     wezterm.action.SwitchToWorkspace {
                        name = line,
                     },
                     pane
                  )
               end
         end),
      },
   }
}

-- functions
-- Get the hostname
local function get_hostname(pane)
  local uri = pane:get_current_working_dir()
  if uri and uri.host and uri.host ~= '' then
    return uri.host
  end
  return wezterm.hostname()  -- fallback to local
end


local function render_right_status(window, segments)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local grad_pct = 1 / (#segments + 1)
  
  local gradient_to, gradient_from = bg
  if current_theme == 1 then
    gradient_from = gradient_to:lighten(grad_pct)
  else
    gradient_from = gradient_to:darken(grad_pct)
  end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments
  )

  local elements = {}

  for i, seg in ipairs(segments) do
    if i == 1 then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })
    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end


-- Update the right status
wezterm.on('update-right-status', function(window, pane)
  local hostname = get_hostname(pane)
  local workspace = wezterm.mux.get_active_workspace()
  
  --local cwd = pane:get_current_working_dir()
  local time = wezterm.strftime('%H:%M')
  local theme = window:effective_config().color_scheme
  local title = pane:get_domain_name()
  render_right_status(window, {
                         hostname,
                         theme,
                         workspace,
                         time,
  })
end)

wezterm.on('toggle-theme', function(window, _pane)
  current_theme = (current_theme % #themes) + 1
  window:set_config_overrides({
    color_scheme = themes[current_theme],
  })
end)

return config
