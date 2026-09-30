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
	# Install with homebrew if available, otherwise just
	# download the prebuilt with curl
	read -n 1 -t 5 -p "$(line 'Try to install with Homebrew? (Y/N): ')" try_hb
	echo ""
	[ -z "$try_hb" ] && try_hb='y'

	case $try_hb in
		y | Y ) use_brew=true ;;
		n | N ) use_brew=false ;;
		* ) warn "Unexpected input. Attempting to use Homebrew by default." ; use_brew=true;;
	esac

	# Install as requested
	if command -v brew &> /dev/null && $use_brew
	then
		_install_brew
	else
		_install_curl
	fi

	# Configure
	_link_config
}

_install_brew () {
	line "Installing with homebrew"
	line "NeoVim will be installed at: /opt/homebrew/bin/nvim"
	brew install neovim
}

_install_curl () {
	line "Installing with curl"
	return_dir="$(pwd)"

	# Setup a temp directory to unpack & run files
	TMPDIR=/tmp/neovim-curl-install/
	mkdir -p $TMPDIR
	cd $TMPDIR

	# Download NeoVim to the tempdir
	FILE="nvim-macos"
	EXT="tar.gz"
	URL="https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
	curl -LO $URL
	xattr -c "./$FILE.$EXT"
	tar xzvf "$FILE.$EXT" &> /dev/null
	eval "./$FILE/bin/nvim"

	cd $return_dir
}

_link_config () {
	line "This script links NeoVim configuration files to \$HOME/.config/nvim/*"
	CONFIG_DIR="$HOME/.config/nvim"

	# Directory setup
	mkdir -p "$CONFIG_DIR"
	mkdir -p "$CONFIG_DIR/plugs"

	# Link the nvim directory
	ln -Fs "$(pwd)/nvim" "$CONFIG_DIR"

	# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

clear_installers() {
	debug "nvim.clear_installers"
	unset run_install
	unset _install_brew
	unset _install_curl
	unset _link_config
}
