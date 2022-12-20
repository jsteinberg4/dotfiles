#############################
#  Install brew casks
#############################
NAME="Homebrew-Casks"

taps=("homebrew/cask-fonts")
cask_names=("font-JetBrains-Mono-nerd-font" "alacritty")

run_install() {
	_tap taps
	_casks cask_names
}

_tap() {
	echo "brew tap ${taps[@]}"
	eval "brew tap ${taps[@]}"
}

_casks(){
	echo "brew install --cask ${cask_names[@]}"
	eval "brew install --cask ${cask_names[@]} 2>&1"
}

clear_installers() {
	unset taps
	unset _tap
	unset _casks
	unset run_install
}
