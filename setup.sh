############################
# 		  Setup.sh 					#
############################
# This script applies the configurations found within this repository

# Utility functions
line_out() {
	printf "%-7s\t%s\n" "$1" "$2"
}
alias line="line_out \"[*]\""
alias note="line_out '[NOTE]'"
alias fixme="line_out '[FIXME]'"

_DIVIDER=""
for _ in $(seq 1 50); do
	_DIVIDER=$_DIVIDER-
done
div() {
	echo "$_DIVIDER\n"
}
num_box() {
	echo $_DIVIDER
	printf "%-20s$2\n" $1
	echo $_DIVIDER
}
alias box="num_box ''"
export -f div

export SCRIPT_DIR="./setup_scripts"
###########################
# 	Unset script utilities
##########################
free() {
	unset div
	unset line
	unset note
	unset fixme
	unset box
	unset SCRIPT_DIR
}
############################
# 			Prologue 					#
############################

box "jsteinberg4/dotfiles/setup.sh"
line "Hello! This configuration script attempts to apply any configurations saved within this repository."
line "It does this by executing all scripts matching the pattern \`$SCRIPT_DIR/*.sh\`. "
fixme "Script execution order cannot be guaranteed."
note "If you would like to add any additional configuration/setup scripts, add them to: \`$SCRIPT_DIR/\`"

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
if (( $NUM_SCRIPTS == 0 )); then
	line "No scripts found"
	line "Exiting..."
	free
	exit 1
else
	line "Executing setup scripts..."
	for (( x=0; x < $NUM_SCRIPTS; x++ )); do
		num_box "[$((x+1))/$NUM_SCRIPTS]" "${SCRIPTS[$x]}"
		source "$SCRIPT_DIR/${SCRIPTS[$x]}"
		echo ""
	done
fi

############################
# 		Exiting  		      	#
############################
line "All scripts completed!"
line "Goodbye."
free


