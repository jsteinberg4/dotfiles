##############################
# 			Prezto Setup
##############################
NAME="Prezto"

run_install() {
	debug "prezto installer broken"
	debug "Cloning repo to default location. Link files manually."
	debug "Instructions: https://github.com/jsteinberg4/prezto#readme" 
	# Basic, totally unconfigured TODO -- Configuration
	eval "git clone --recursive https://github.com/jsteinberg4/prezto.git $HOME/.zprezto"
	#
	# setopt EXTENDED_GLOB
	# for rcfile in "$HOME"/.zprezto/runcoms/^README.md(.N); do
	# 	ln -s "$rcfile" "$HOME/.${rcfile:t}"
	# done

}

clear_installers() {
	debug "prezto.clear_installers"
	unset run_install
}

