##########################
# Alacritty Terminal Setup
##########################

NAME="Alacritty"

run_install() {
	# TODO -- Clone & install

	# Post-build options -- terminfo, configuration files
	# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#post-build
	_terminfo
	_config
}

_terminfo() {
	# if exit status of `terminfo alacritty` == 1, then error. Need to do some extra steps
}

_config() {
	CONFIG_DIR="$HOME/.config/alacritty"
	CONFIG_FILE="$WORKING_DIR/alacritty/alacritty.yml"

	debug "Linking configurations to $CONFIG_DIR."
	mkdir -p $CONFIG_DIR
	ln -s "$CONFIG_FILE" "$CONFIG_DIR/alacritty.yml"
}

clean_installers() {
	unset run_install
	unset _config
}
