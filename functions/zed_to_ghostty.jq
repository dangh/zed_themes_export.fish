.themes[$i].style."terminal.background"[0:7] as $bg |

def blend_bg: blend(.; $bg);

.themes[$i].style as $s |
$s |
[
  "palette = 0=\(."terminal.ansi.black" | blend_bg)",
  "palette = 1=\(."terminal.ansi.red" | blend_bg)",
  "palette = 2=\(."terminal.ansi.green" | blend_bg)",
  "palette = 3=\(."terminal.ansi.yellow" | blend_bg)",
  "palette = 4=\(."terminal.ansi.blue" | blend_bg)",
  "palette = 5=\(."terminal.ansi.magenta" | blend_bg)",
  "palette = 6=\(."terminal.ansi.cyan" | blend_bg)",
  "palette = 7=\(."terminal.ansi.white" | blend_bg)",
  "palette = 8=\(."terminal.ansi.bright_black" | blend_bg)",
  "palette = 9=\(."terminal.ansi.bright_red" | blend_bg)",
  "palette = 10=\(."terminal.ansi.bright_green" | blend_bg)",
  "palette = 11=\(."terminal.ansi.bright_yellow" | blend_bg)",
  "palette = 12=\(."terminal.ansi.bright_blue" | blend_bg)",
  "palette = 13=\(."terminal.ansi.bright_magenta" | blend_bg)",
  "palette = 14=\(."terminal.ansi.bright_cyan" | blend_bg)",
  "palette = 15=\(."terminal.ansi.bright_white" | blend_bg)",
  "",
  "background = \($bg)",
  "foreground = \(."terminal.foreground" | blend_bg)",
  "cursor-color = \(.players[0].cursor | blend_bg)",
  "cursor-text = \(."terminal.foreground" | blend_bg)",
  "selection-background = \(.players[0].selection | blend_bg)",
  "selection-foreground = \(."terminal.foreground" | blend_bg)",
  "",
  "palette = 250 = \(.background | blend_bg)"
] | .[]
