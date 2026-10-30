local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.set_environment_variables = {
    PATH = '/opt/homebrew/bin:/usr/local/bin/:' .. os.getenv('PATH')
}

config.font = wezterm.font({ family = 'Monaspace Neon' })

config.font_size = 12

config.color_scheme = 'Tokyo Night'

config.tab_bar_at_bottom = false

config.keys = {
    {
        key = ',',
        mods = 'SUPER', -- CMD
        action = wezterm.action.SpawnCommandInNewTab {
            cwd = wezterm.home_dir,
            args = { 'nvim', wezterm.config_file },
        }
    },
    {
        key = 's',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical,
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal,
    },
}

local function segments_for_right_status(window)
    return {
        window:active_workspace(),
        wezterm.strftime('%a %b %-d %H:%M'),
        wezterm.hostname(),
    }
end

wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local gradient_to, gradient_from = bg
  -- if appearance.is_dark() then
  gradient_from = gradient_to:lighten(0.2)
  -- else
  --   gradient_from = gradient_to:darken(0.2)
  -- end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  local elements = {}
  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
