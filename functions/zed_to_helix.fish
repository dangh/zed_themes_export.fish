function zed_to_helix
    set themes ayu gruvbox one
    set json (mktemp)
    for theme in $themes
        curl -s https://raw.githubusercontent.com/zed-industries/zed/main/assets/themes/$theme/$theme.json -o $json
        for i in (seq 0 (jq '.themes | length - 1' $json))
            jq -r ".themes[$i].name" $json | string replace -a ' ' '' | read name
            set name Zed$name
            echo $name
            jq -r --argjson i $i \
                -f (cat $__fish_config_dir/functions/{colors,zed_to_helix}.jq | psub -f) \
                $json >~/.config/helix/themes/$name.toml
        end
    end
end
