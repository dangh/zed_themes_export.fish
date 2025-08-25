.themes[$i].style."editor.background"[0:7] as $bg |

def v:
  if type == "string" then
    . | @json
  elif . == null then
    "{}"
  else
    with_entries(
      select(
        .value != null and
        .value != {} and
        .value != []
      )
    )
    | "{ " +
        (to_entries
        | map("\(.key) = \(.value |
              if type == "object" then v
              else @json
              end)")
        | join(", "))
      + " }"
  end;

def color: blend(.; $bg);
def fg($v): { fg: ($v | color) };
def bg($v): { bg: ($v | color) };
def style:
  if . == null then
    {}
  else
    {
      fg: (.color),
      modifiers: (
        [
          if .font_style == "italic" then "italic" else empty end,
          if .font_weight != null then "bold" else empty end
        ]
      )
    }
  end;

def add_modifier(modifier):
  if has("modifiers") then
    .modifiers as $m
    | .modifiers = ($m + [modifier] | unique)
  else
    . + {modifiers: [modifier]}
  end;

def bold: add_modifier("bold");
def dim: add_modifier("dim");
def italic: add_modifier("italic");
def underlined: add_modifier("underlined");
def slow_blink: add_modifier("slow_blink");
def rapid_blink: add_modifier("rapid_blink");
def reversed: add_modifier("reversed");
def hidden: add_modifier("hidden");
def crossed_out: add_modifier("crossed_out");

.themes[$i].style |
[
  "\"attribute\" = \(.syntax.attribute | style | v)",
  "\"type\" = \(.syntax.type | style | v)",
  # "\"type.builtin\" = \( | v)",
  # "\"type.parameter\" = \( | v)",
  # "\"type.enum\" = \( | v)",
  # "\"type.enum.variant\" = \( | v)",
  "\"constructor\" = \(.syntax.constructor | style | v)",
  "\"constant\" = \(.syntax.constant | style | v)",
  # "\"constant.builtin\" = \( | v)",
  # "\"constant.builtin.boolean\" = \( | v)",
  # "\"constant.character\" = \( | v)",
  # "\"constant.character.escape\" = \( | v)",
  # "\"constant.numeric\" = \( | v)",
  # "\"constant.numeric.integer\" = \( | v)",
  # "\"constant.numeric.float\" = \( | v)",
  "\"string\" = \(.syntax.string | style | v)",
  "\"string.regexg\" = \(.syntax."string.regex" | style | v)",
  "\"string.special\" = \(.syntax."string.special" | style | v)",
  # "\"string.special.path\" = \( | v)",
  # "\"string.special.url\" = \( | v)",
  "\"string.special.symbol\" = \(.syntax."string.special.symbol" | style | v)",
  "\"comment\" = \(.syntax.comment | style | italic | v)",
  # "\"comment.line\" = \( | v)",
  "\"comment.line.documentation\" = \(.syntax."comment.doc" | style | italic | v)",
  # "\"comment.block\" = \( | v)",
  "\"comment.block.documentation\" = \(.syntax."comment.doc" | style | italic | v)",
  # "\"comment.unused\" = \( | v)",
  "\"variable\" = \(.syntax.variable | style | v)",
  # "\"variable.builtin\" = \( | v)",
  # "\"variable.parameter\" = \( | v)",
  # "\"variable.other\" = \( | v)",
  # "\"variable.other.member\" = \( | v)",
  # "\"variable.other.member.private\" = \( | v)",
  "\"label\" = \(.syntax.label | style | v)",
  "\"punctuation\" = \(.syntax.punctuation | style | v)",
  "\"punctuation.delimiter\" = \(.syntax."punctuation.delimiter" | style | v)",
  "\"punctuation.bracket\" = \(.syntax."punctuation.bracket" | style | v)",
  "\"punctuation.special\" = \(.syntax."punctuation.special" | style | v)",
  "\"keyword\" = \(.syntax.keyword | style | v)",
  # "\"keyword.control\" = \( | v)",
  # "\"keyword.control.conditional\" = \( | v)",
  # "\"keyword.control.repeat\" = \( | v)",
  # "\"keyword.control.import\" = \( | v)",
  # "\"keyword.control.return\" = \( | v)",
  # "\"keyword.control.exception\" = \( | v)",
  # "\"keyword.operator\" = \( | v)",
  # "\"keyword.directive\" = \( | v)",
  # "\"keyword.function\" = \( | v)",
  # "\"keyword.storage\" = \( | v)",
  # "\"keyword.storage.type\" = \( | v)",
  # "\"keyword.storage.modifier\" = \( | v)",
  "\"operator\" = \(.syntax.operator | style | v)",
  "\"function\" = \(.syntax.function | style | bold | v)",
  "\"function.builtin\" = \(.syntax."function.builtin" | style | bold | v)",
  # "\"function.method\" = \( | v)",
  # "\"function.method.private\" = \( | v)",
  # "\"function.macro\" = \( | v)",
  # "\"function.special\" = \( | v)",
  "\"tag\" = \(.syntax.tag | style | v)",
  # "\"tag.builtin\" = \( | v)",
  "\"namespace\" = \(.syntax.namespace | style | v)",
  "\"special\" = \(.syntax.keyword | style | v)",
  # "\"markup\" = \( | v)",
  # "\"markup.heading\" = \( | v)",
  # "\"markup.heading.marker\" = \( | v)",
  # "\"markup.heading.marker.1\" = \( | v)",
  # "\"markup.heading.marker.2\" = \( | v)",
  # "\"markup.heading.marker.3\" = \( | v)",
  # "\"markup.heading.marker.4\" = \( | v)",
  # "\"markup.heading.marker.5\" = \( | v)",
  # "\"markup.heading.marker.6\" = \( | v)",
  # "\"markup.list\" = \( | v)",
  # "\"markup.list.unumbered\" = \( | v)",
  # "\"markup.list.umbered\" = \( | v)",
  # "\"markup.list.checked\" = \( | v)",
  # "\"markup.list.unchecked\" = \( | v)",
  # "\"markup.bold\" = \( | v)",
  # "\"markup.italic\" = \( | v)",
  # "\"markup.strikethrough\" = \( | v)",
  # "\"markup.link\" = \( | v)",
  # "\"markup.link.url\" = \( | v)",
  # "\"markup.link.label\" = \( | v)",
  # "\"markup.link.text\" = \( | v)",
  # "\"markup.quote\" = \( | v)",
  # "\"markup.raw\" = \( | v)",
  # "\"markup.raw.inline\" = \( | v)",
  # "\"markup.raw.block\" = \( | v)",
  # "\"diff\" = \( | v)",
  # "\"diff.plus\" = \( | v)",
  "\"diff.plus.gutter\" = \(fg(."editor.gutter.background") + bg(."version_control.added") | v)",
  # "\"diff.minus\" = \( | v)",
  "\"diff.minus.gutter\" = \(fg(."editor.gutter.background") + bg(."version_control.deleted") | v)",
  # "\"diff.delta\" = \( | v)",
  # "\"diff.delta.moved\" = \( | v)",
  # "\"diff.delta.conflict\" = \( | v)",
  "\"diff.delta.gutter\" = \(fg(."editor.gutter.background") + bg(."version_control.modified") | v)",
  "",
  # "\"markup.normal\" = \( | v)",
  # "\"markup.normal.completion\" = \( | v)",
  # "\"markup.normal.hover\" = \( | v)",
  # "\"markup.heading.completion\" = \( | v)",
  # "\"markup.heading.hover\" = \( | v)",
  # "\"markup.raw.inline\" = \( | v)",
  # "\"markup.raw.inline.completion\" = \( | v)",
  # "\"markup.raw.inline.hover\" = \( | v)",
  "",
  "\"ui.background\" = \(bg($bg) + fg(.border) | v)",
  "\"ui.background.separator\" = \(fg(.border) | v)",
  "\"ui.cursor\" = \(bg(.players[1].cursor) + fg($bg) | v)",
  # "\"ui.cursor.normal\" = \( | v)",
  # "\"ui.cursor.insert\" = \( | v)",
  # "\"ui.cursor.select\" = \( | v)",
  "\"ui.cursor.match\" = \(bg(.players[0].selection) | v)",
  "\"ui.cursor.primary\" = \(bg(.players[0].cursor) + fg($bg) | v)",
  # "\"ui.cursor.primary.normal\" = \( | v)",
  # "\"ui.cursor.primary.insert\" = \( | v)",
  # "\"ui.cursor.primary.select\" = \( | v)",
  # "\"ui.debug.breakpoint\" = \( | v)",
  # "\"ui.debug.active\" = \( | v)",
  "\"ui.gutter\" = \(bg(."editor.gutter.background") | v)",
  "\"ui.gutter.selected\" = \(bg(."editor.active_line.background") | v)",
  "\"ui.linenr\" = \(bg(."editor.gutter.background") + fg(."editor.line_number") | v)",
  "\"ui.linenr.selected\" = \(bg(."editor.active_line.background") + fg(."editor.active_line_number") | v)",
  "\"ui.statusline\" = \(bg(."status_bar.background") + fg(.text) | v)",
  # "\"ui.statusline.inactive\" = \( | v)",
  # "\"ui.statusline.normal\" = \( | v)",
  # "\"ui.statusline.insert\" = \( | v)",
  # "\"ui.statusline.select\" = \( | v)",
  # "\"ui.statusline.separator\" = \( | v)",
  "\"ui.bufferline\" = \(bg(."title_bar.inactive_background") | v)",
  "\"ui.bufferline.active\" = \(bg(."title_bar.background") | v)",
  "\"ui.bufferline.background\" = \(bg(."title_bar.inactive_background") | v)",
  "\"ui.popup\" = \(bg(."elevated_surface.background") + fg(.border) | v)",
  # "\"ui.popup.info\" = \( | v)",
  # "\"ui.picker.header\" = \( | v)",
  # "\"ui.picker.header.column\" = \( | v)",
  # "\"ui.picker.header.column.active\" = \( | v)",
  "\"ui.window\" = \(fg(.border) | v)",
  # "\"ui.help\" = \( | v)",
  "\"ui.text\" = \(fg(.text) | v)",
  "\"ui.text.focus\" = \(bg(."element.selected") | v)",
  "\"ui.text.inactive\" = \(bg(."element.disabled") | v)",
  # "\"ui.text.info\" = \( | v)",
  # "\"ui.text.directory\" = \( | v)",
  "\"ui.virtual.ruler\" = \(fg(."editor.wrap_guide") | v)",
  "\"ui.virtual.whitespace\" = \(fg(."editor.invisible") | v)",
  "\"ui.virtual.indent-guide\" = \(fg(."editor.active_wrap_guide") | v)",
  # "\"ui.virtual.inlay-hint\" = \( | v)",
  # "\"ui.virtual.inlay-hint.parameter\" = \( | v)",
  # "\"ui.virtual.inlay-hint.type\" = \( | v)",
  "\"ui.virtual.wrap\" = \(fg(."editor.invisible") | v)",
  "\"ui.virtual.jump-label\" = \(bg(.players[2].selection) + fg(.players[2].cursor) | v)",
  "\"ui.menu\" = \(bg(."elevated_surface.background") | v)",
  "\"ui.menu.selected\" = \(bg(."element.selected") | v)",
  "\"ui.menu.scroll\" = \(bg(."scrollbar.track.background") + fg(."scrollbar.thumb.background") | v)",
  "\"ui.selection\" = \(bg(.players[1].selection) | v)",
  "\"ui.selection.primary\" = \(bg(.players[0].selection) | v)",
  # "\"ui.highlight\" = \( | v)",
  # "\"ui.highlight.frameline\" = \( | v)",
  "\"ui.cursorline.primary\" = \(bg(."editor.active_line.background") | v)",
  "\"ui.cursorline.secondary\" = \(bg(."editor.highlighted_line.background") | v)",
  "\"ui.cursorcolumn.primary\" = \(bg(."editor.active_line.background") | v)",
  "\"ui.cursorcolumn.secondary\" = \(bg(."editor.highlighted_line.background") | v)",
  "\"warning\" = \(bg(."warning.background") + fg(.warning) | v)",
  "\"error\" = \(bg(."error.background") + fg(.error) | v)",
  "\"info\" = \(bg(."info.background") + fg(.info) | v)",
  "\"hint\" = \(bg(."hint.background") + fg(.hint) | v)",
  # "\"diagnostic\" = \( | v)",
  "\"diagnostic.warning\" = \(bg(."warning.background") + fg(.warning) | v)",
  "\"diagnostic.error\" = \(bg(."error.background") + fg(.error) | v)",
  "\"diagnostic.info\" = \(bg(."info.background") + fg(.info) | v)",
  "\"diagnostic.hint\" = \(bg(."hint.background") + fg(.hint) | v)",
  "\"diagnostic.unnecessary\" = \(bg(."unreachable.background") + fg(.unreachable) | crossed_out | v)",
  "\"diagnostic.deprecated\" = \(bg(."ignored.background") + fg(.ignored) | italic | v)",
  # "\"tabstop\" = \( | v)",
  "",
  "[palette]",
  "\"default\" = \(.text | color | v)",
  "\"black\" = \(."terminal.ansi.black" | color | v)",
  "\"red\" = \(."terminal.ansi.red" | color | v)",
  "\"green\" = \(."terminal.ansi.green" | color | v)",
  "\"yellow\" = \(."terminal.ansi.yellow" | color | v)",
  "\"blue\" = \(."terminal.ansi.blue" | color | v)",
  "\"magenta\" = \(."terminal.ansi.magenta" | color | v)",
  "\"cyan\" = \(."terminal.ansi.cyan" | color | v)",
  "\"gray\" = \(."terminal.ansi.white" | color | v)",
  "\"bright_black\" = \(."terminal.ansi.bright_black" | color | v)",
  "\"bright_red\" = \(."terminal.ansi.bright_red" | color | v)",
  "\"bright_green\" = \(."terminal.ansi.bright_green" | color | v)",
  "\"bright_yellow\" = \(."terminal.ansi.bright_yellow" | color | v)",
  "\"bright_blue\" = \(."terminal.ansi.bright_blue" | color | v)",
  "\"bright_magenta\" = \(."terminal.ansi.bright_magenta" | color | v)",
  "\"bright_cyan\" = \(."terminal.ansi.bright_cyan" | color | v)",
  "\"bright_gray\" = \(."terminal.ansi.bright_white" | color | v)"
  # "\"white\" ="
] | .[]
