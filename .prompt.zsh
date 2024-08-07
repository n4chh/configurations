case $PROMPT in 
p10k)
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
	. ~/powerlevel10k/powerlevel10k.zsh-theme
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh
  ;;
kali)
    PROMPT_ALTERNATIVE=twowhite
	. ~/.kali.zsh
  ;;
nachh)
    PROMPT_ALTERNATIVE=nachhsimple
	. ~/.nachh.zsh
  ;;
*)
	. ~/.kali.zsh
	;;
esac
