if [[ -o interactive ]]; then
_omp_detect_theme() {
  if [[ -n "$_THEME_CACHE" ]]; then
    local cache_time=$((SECONDS - ${_THEME_CACHE_TIME:-0}))
    if [[ $cache_time -lt 60 ]]; then
      echo "$_THEME_CACHE"
      return
    fi
  fi
  
  local val
  val="$(gsettings get org.gnome.desktop.interface color-scheme)"
  local theme
  if [[ "${val:l}" =~ dark ]]; then
    theme="Dark"
  else
    theme="Light"
  fi
  
  export _THEME_CACHE="$theme"
  export _THEME_CACHE_TIME=$SECONDS
  
  echo "$theme"
}

  set_omp_theme() {
    local newval
    newval="$(_omp_detect_theme)"
    if [[ "$THEME" != "$newval" ]]; then
      typeset -g -x THEME="$newval"
    fi
  }

  autoload -Uz add-zsh-hook 2>/dev/null || true
  if (( ${+functions[add-zsh-hook]} )); then
    add-zsh-hook precmd set_omp_theme
  else
    if [[ -z "${precmd_functions[(r)set_omp_theme]}" ]]; then
      precmd_functions+=("set_omp_theme")
    fi
  fi

  set_omp_theme

  if command -v oh-my-posh >/dev/null 2>&1; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/gentoo.json)"
  fi
fi

