############################
# << Utility functions  >	 #
############################
_DIVIDER=""
for _ in $(seq 1 50); do
	_DIVIDER=$_DIVIDER-
done

div() {
	echo "$_DIVIDER\n"
}
line_out() {
	printf "%-7s\t%s\n" "$1" "$2"
}
no_install() {
	line "$1 will not be installed."
}
num_box() {
	echo $_DIVIDER
	printf "%-20s$2\n" $1
	echo $_DIVIDER
}

# common uses of utility functions
box() {
	num_box ''
}
debug() {
	line_out '[DEBUG]'
}
fixme() {
	line_out '[FIXME]'
}
line() {
	line_out \"[*]\"
}
note() {
	line_out '[NOTE]'
}
warn() {
	line_out '[WARN]'
}

pause() {
	read -n 1 -s -r -p $'\nPress any key to continue...\n' key
}

export -f div
export TIMEOUT=30

prompt_execute() {
	program=$1
	loop=true
	warn "if you do not accept/deny within $TIMEOUT seconds, program(s) will be installed by default."
	while $loop; do
		printf -v prompt_text "%-7s\t%s%s%s: " "[*]" "Would you like to install " $program "? (Y/N)"
		read -t $TIMEOUT -n 1 -p "$prompt_text" answer
		[ -z "$answer" ] && answer='y' # Default to 'Yes' on timeout
		echo ""                        # Newline after input

		case $answer in
		[yY]*)
			loop=false
			run_install
			;;
		[nN]*)
			loop=false
			no_install $program
			;;
		*) line "Please answer Yes (y) or No (n)." ;;
		esac
	done
}

############################
# 			Prologue 					#
############################
box "Installer: jsteinberg4/dotfiles"

line "This script installs and configures the jsteinberg4/dotfiles repository."
line "The repository will be cloned onto your local computer, then various setup scripts will be executed."
line "You will have the option to skip some scripts or change installation locations."
pause

############################
#  Download Repo
############################
export REPO_DIR="$HOME/dotfiles"
export SCRIPT_DIR="$REPO_DIR/setup_scripts"

if [ -d "$REPO_DIR" ]; then
	line "git@github.com:jsteinberg4/dotfiles.git already installed. Continuing..."
else
	# TODO: -- Input download dir
	line "Repo location? TODO"
	pause
	git clone \
		--recursive \
		--depth 1 \
		"git@github.com:jsteinberg4/dotfiles.git" \
		"$REPO_DIR"
fi

############################
#  Link any hooks
############################
source "./refresh-hooks.sh"

############################
# 	 Locate scripts
############################
echo ""
line "Locating setup scripts..."

# StackOverflow suggested using shopt -s/-u nullglob
# https://stackoverflow.com/questions/18884992/how-do-i-assign-ls-to-an-array-in-linux-bash/18887210#18887210
# Seems to work, not sure why
shopt -s nullglob
cd $SCRIPT_DIR
SCRIPTS=(*.sh)
NUM_SCRIPTS="${#SCRIPTS[@]}"
shopt -u nullglob
cd ..

###############################
# Run scripts in alphabetical order
################################
if (($NUM_SCRIPTS == 0)); then
	line "No scripts found"
	line "Exiting..."
	free
	exit 1
else
	line "Executing setup scripts..."
	for ((x = 0; x < $NUM_SCRIPTS; x++)); do
		num_box "[$((x + 1))/$NUM_SCRIPTS]" "${SCRIPTS[$x]}"
		source "$SCRIPT_DIR/${SCRIPTS[$x]}"
		prompt_execute $NAME
		clear_installers
		echo ""
	done
fi

############################
# 		Exiting  		      	#
############################
div
line "All scripts completed!"
line "Goodbye."
