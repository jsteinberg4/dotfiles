###########################################
# 			Homebrew Setup
###########################################
_name="brew.sh"

line "This script installs Homebrew at its default location."
note "If you do not accept/deny within 10 seconds, it will install by default."

yesexpr="y|Y"
noexpr="n|N"
loop=true

abort() {
	line $1
	exit 1
}

run_install () {
	line "Installing Homebrew..."

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

no_install() {
	line "Homebrew will not be installed."
}

while $loop; do
	read -t 10 -n 1 -p "[*]     Would you like to install homebrew? (Y/N):  " answer
	[ -z "$answer" ] && answer="Y"  # If no reply, default to Yes
	echo "" # Newline after input
	case $answer in
		[Yy]* ) loop=false; run_install ;;
		[Nn]* ) loop=false; no_install ;;
		* ) line "Please answer Yes/No." ;;
	esac
done

line "End of $_name."
