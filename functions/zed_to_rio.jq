.themes[$i].style."terminal.background"[0:7] as $bg |

def blend_bg: blend(.; $bg);

.themes[$i].style as $s |
$s |
[
  "[colors]",
  "background = \"\($bg)\"",
  "foreground = \"\(."terminal.foreground" | blend_bg)\"",
  "",
  "# Selection",
  "selection-background = \"\(.players[0].selection | blend_bg)\"",
  "selection-foreground = \"\(."terminal.foreground" | blend_bg)\"",
  "",
  "# Navigation",
  "cursor = \"\(.players[0].cursor | blend_bg)\"",
  # "cursor-text = \"\(."terminal.foreground" | blend_bg)\"",
  "",
  "# Search",
  "",
  "# Regular colors",
  "black = \"\(."terminal.ansi.black" | blend_bg)\"",
  "red = \"\(."terminal.ansi.red" | blend_bg)\"",
  "green = \"\(."terminal.ansi.green" | blend_bg)\"",
  "yellow = \"\(."terminal.ansi.yellow" | blend_bg)\"",
  "blue = \"\(."terminal.ansi.blue" | blend_bg)\"",
  "magenta = \"\(."terminal.ansi.magenta" | blend_bg)\"",
  "cyan = \"\(."terminal.ansi.cyan" | blend_bg)\"",
  "white = \"\(."terminal.ansi.white" | blend_bg)\"",
  "",
  "# Dim colors",
  "",
  "# Light colors",
  "light-black = \"\(."terminal.ansi.bright_black" | blend_bg)\"",
  "light-red = \"\(."terminal.ansi.bright_red" | blend_bg)\"",
  "light-green = \"\(."terminal.ansi.bright_green" | blend_bg)\"",
  "light-yellow = \"\(."terminal.ansi.bright_yellow" | blend_bg)\"",
  "light-blue = \"\(."terminal.ansi.bright_blue" | blend_bg)\"",
  "light-magenta = \"\(."terminal.ansi.bright_magenta" | blend_bg)\"",
  "light-cyan = \"\(."terminal.ansi.bright_cyan" | blend_bg)\"",
  "light-white = \"\(."terminal.ansi.bright_white" | blend_bg)\"",
  ""
] | .[]
