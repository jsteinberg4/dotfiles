###########################################
# 			Homebrew Setup
###########################################
NAME="Homebrew"

abort() {
	line $1
	exit 1
}

# cURL the latest version of homebrew and install
run_install () {
	line "Downloading and running the installer for $NAME."

	# Download the Homebrew installer to a temp file
	tmp_base='homebrew_installer_sh'
	brew_tmp=`mktemp -t ${tmp_base}` || abort "Homebrew installer script failed to obtain a safe temp file"

	curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" > $brew_tmp
	# Subshell to unset POSIXLY_CORRECT w/o modifying parent shell
	(
		unset POSIXLY_CORRECT
		source $brew_tmp
	)
}

clear_installers() {
	debug "homebrew.clear_installers"
	unset run_install
	unset abort
}
