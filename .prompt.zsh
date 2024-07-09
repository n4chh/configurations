case $PROMPT in 
p10k)
	. ~/.p10k.zsh
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
	. ~/powerlevel10k/powerlevel10k.zsh-theme
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh
  ;;
nachh)
    PROMPT_ALTERNATIVE=nachh_ubuntu
	. ~/.nachh.zsh
  ;;
*)
	. ~/.p10k.zsh
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
	. ~/powerlevel10k/powerlevel10k.zsh-theme
	;;
esac
