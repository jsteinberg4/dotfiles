###########################################
# 			Nvim Setup
###########################################
###################
# Function Definitions
###################

# Helpful vars
NAME="NeoVim"
CONFIG_DIR="$HOME/config/nvim"

run_install() {
	echo "nvim.run_install"
	line "NeoVim will be installed at: /opt/homebrew/bin/nvim" # TODO -- Use brew if available else cURL
	line "This script links NeoVim configuration files to \$HOME/.config/nvim/*"
}

_install_nvim () {
	echo $0
}

_link_config () {
	echo $0
}

clear_installers() {
	line "nvim.clear_installers"
	unset run_install
	unset _install_nvim
	unset _link_config
}
