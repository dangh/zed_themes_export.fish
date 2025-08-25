function zed_to_helix
    set themes ayu gruvbox one
    set json (mktemp)
    for theme in $themes
        curl -s https://raw.githubusercontent.com/zed-industries/zed/main/assets/themes/$theme/$theme.json -o $json
        for i in (seq (jq '.themes | length' $json))
            jq -r ".themes[$i-1].name" $json | string replace -a ' ' '' | read name
            set name Zed$name
            echo $name
            jq -r --argjson i "$i" -f ./colors.jq -f ./zed_to_helix.jq "$json" >~/.config/helix/themes/$name.toml
        end
    end
end
