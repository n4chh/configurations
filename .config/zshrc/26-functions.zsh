
function upgrade-shell ()
{
	# -----------------------------------------------------
	# Node Version Manager
	# -----------------------------------------------------
	export NVM_DIR="$HOME/.nvm"
	emulate bash
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	emulate zsh
	
	# -----------------------------------------------------
	# Pyenv
	# -----------------------------------------------------
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init - zsh)"
}
