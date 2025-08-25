function zed_to_ghostty
    set themes ayu gruvbox one
    set json (mktemp)
    for theme in $themes
        curl -s https://raw.githubusercontent.com/zed-industries/zed/main/assets/themes/$theme/$theme.json -o $json
        for i in (seq (jq '.themes | length' $json))
            jq -r ".themes[$i-1].name" $json | string replace -a ' ' '' | read name
            set name Zed$name
            echo $name
            jq -r --argjson i "$i" '
            # --- Helpers ---
            def hex2dec($h):
              "0123456789abcdef" as $hex |
              ($hex | index($h[0:1] | ascii_downcase)) * 16 +
              ($hex | index($h[1:2] | ascii_downcase));

            def dec2hex($n):
              "0123456789abcdef" as $hex |
              ($n / 16 | floor) as $hi |
              ($n % 16) as $lo |
              ($hex[$hi:$hi+1] + $hex[$lo:$lo+1]);

            def blend(rgba; bg):
              if (rgba|length)==9 then
                {
                  r: hex2dec(rgba[1:3]),
                  g: hex2dec(rgba[3:5]),
                  b: hex2dec(rgba[5:7]),
                  a: hex2dec(rgba[7:9])/255
                } as $f |
                {
                  r: hex2dec(bg[1:3]),
                  g: hex2dec(bg[3:5]),
                  b: hex2dec(bg[5:7])
                } as $b |
                "#" +
                dec2hex( ($f.r*$f.a + $b.r*(1-$f.a)) | floor ) +
                dec2hex( ($f.g*$f.a + $b.g*(1-$f.a)) | floor ) +
                dec2hex( ($f.b*$f.a + $b.b*(1-$f.a)) | floor )
              else
                rgba
              end;

            .themes[$i-1].style."terminal.background"[0:7] as $bg |

            def blend_bg: blend(.; $bg);

            # Palette and other colors
            .themes[$i-1].style as $s |
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
              "selection-foreground = \(."terminal.foreground" | blend_bg)"
            ] | .[]
            ' "$json" >~/.config/ghostty/themes/$name
        end
    end
end
