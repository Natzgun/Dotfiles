#!/bin/bash


backup_dir="$HOME/.dotNatzgunBackup"

mkdir -p "$backup_dir"

declare -A items=(
    ["20-intel.conf"]="$HOME/.dotfiles/.config/20-intel.conf"
    ["doom"]="$HOME/.dotfiles/.config/doom"
    ["latexmk"]="$HOME/.dotfiles/.config/latexmk"
    ["picom.conf"]="$HOME/.dotfiles/.config/picom.conf"
    ["starship.toml"]="$HOME/.dotfiles/.config/starship.toml"
    ["Xresources"]="$HOME/.dotfiles/.config/Xresources"
    ["alacritty"]="$HOME/.dotfiles/.config/alacritty"
    ["dunst"]="$HOME/.dotfiles/.config/dunst"
    ["neofetch"]="$HOME/.dotfiles/.config/neofetch"
    ["polybar"]="$HOME/.dotfiles/.config/polybar"
    ["swaylock"]="$HOME/.dotfiles/.config/swaylock"
    ["battery-notify"]="$HOME/.dotfiles/.config/battery-notify"
    ["fish"]="$HOME/.dotfiles/.config/fish"
    ["nitrogen"]="$HOME/.dotfiles/.config/nitrogen"
    ["qtile"]="$HOME/.dotfiles/.config/qtile"
    ["sxhkd"]="$HOME/.dotfiles/.config/sxhkd"
    ["bspwm"]="$HOME/.dotfiles/.config/bspwm"
    ["gtk-3.0"]="$HOME/.dotfiles/.config/gtk-3.0"
    ["NvChad"]="$HOME/.dotfiles/.config/NvChad"
    ["ranger"]="$HOME/.dotfiles/.config/ranger"
    ["waybar"]="$HOME/.dotfiles/.config/waybar"
    ["cava"]="$HOME/.dotfiles/.config/cava"
    ["hypr"]="$HOME/.dotfiles/.config/hypr"
    ["nvim"]="$HOME/.dotfiles/.config/nvim"
    ["Readme.md"]="$HOME/.dotfiles/.config/Readme.md"
    ["waybar.old"]="$HOME/.dotfiles/.config/waybar.old"
    ["chrome-flags.conf"]="$HOME/.dotfiles/.config/chrome-flags.conf"
    ["kitty"]="$HOME/.dotfiles/.config/kitty"
    ["pavucontrol.ini"]="$HOME/.dotfiles/.config/pavucontrol.ini"
    ["rofi"]="$HOME/.dotfiles/.config/rofi"
    ["wofi"]="$HOME/.dotfiles/.config/wofi"
)

    src="${items[$item]}"
    for item in "${!items[@]}"; do
    dest="$HOME/.config/$item"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        read -p "El destino $dest ya existe. ¿Quieres hacer una copia de seguridad y sobrescribirlo? (s/n): " choice
        if [ "$choice" == "s" ]; then
            echo "Haciendo copia de seguridad en $backup_dir..."
            mv "$dest" "$backup_dir/"
        else
            echo "Omitiendo $dest..."
            continue
        fi
    fi
    ln -s "$src" "$dest"
    echo "Creado enlace simbólico: $dest -> $src"
done

echo "Enlaces simbólicos creados correctamente."
echo "Dots instalados correctamente"
