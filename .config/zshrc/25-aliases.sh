# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/.config/ml4w/scripts/snapshot.sh'
alias wifi='nmtui'
alias cleanup='~/.config/ml4w/scripts/cleanup.sh'

# -----------------------------------------------------
# ML4W Apps
# -----------------------------------------------------
alias ml4w='flatpak run com.ml4w.welcome'
alias ml4w-settings='flatpak run com.ml4w.settings'
alias ml4w-calendar='flatpak run com.ml4w.calendar'
alias ml4w-hyprland='com.ml4w.hyprland.settings'
alias ml4w-sidebar='flatpak run com.ml4w.sidebar'
alias ml4w-options='ml4w-hyprland-setup -m options'
alias ml4w-sidebar='ags toggle sidebar'
alias ml4w-diagnosis='~/.config/hypr/scripts/diagnosis.sh'
alias ml4w-hyprland-diagnosis='~/.config/hypr/scripts/diagnosis.sh'
alias ml4w-qtile-diagnosis='~/.config/ml4w/qtile/scripts/diagnosis.sh'
alias ml4w-update='~/.config/ml4w/update.sh'

# -----------------------------------------------------
# Window Managers
# -----------------------------------------------------

alias Qtile='startx'
# Hyprland with Hyprland

# -----------------------------------------------------
# Scripts
# -----------------------------------------------------
alias ascii='~/.config/ml4w/scripts/figlet.sh'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# -----------------------------------------------------
# Qtile
# -----------------------------------------------------
alias res1='xrandr --output DisplayPort-0 --mode 2560x1440 --rate 120'
alias res2='xrandr --output DisplayPort-0 --mode 1920x1080 --rate 120'
alias setkb='setxkbmap de;echo "Keyboard set back to de."'

function select_nvim() {
    local paths=(
        "$HOME/.config"
        "$HOME/.local/state"
        "$HOME/.local/share"
        "$HOME/.cache"
    )
    local available_themes=("nvchad" "lazyvim")
    local theme=$1
    for ((i = 1; i <= ${#available_themes[@]}; i++)); do
        echo " ${#available_themes[@]} -> $i ${available_themes[$i]}"
        if [[ "$theme" == "${available_themes[$i]}" ]]; then
            export NVIM_APPNAME="nvim-$theme"
            echo Distro selected: nvim-$theme
            return 0
        fi
    done
    echo Wrong distro
    return 1

}

function select_msfruby ()
{
	unset GEM_HOME
 	unset GEM_PATH
 	unset GEM_PATH
 	unset RUBY_ENGINE
	export OLD_PATH=$PATH
 	export PATH=/opt/metasploit-framework/embedded/bin:$PATH
}

function deselect_msfruby() {
	[[ -z "$OLD_PATH" ]] || export PATH="$OLD_PATH"
}
