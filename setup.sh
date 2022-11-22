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

############################
# 			Prologue 					#
############################
SCRIPT_DIR="./setup_scripts"

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
SCRIPTS=($SCRIPT_DIR/*)
cd $SCRIPT_DIR
SCRIPT_NAMES=(*.sh)
cd ..

NUM_SCRIPTS="${#SCRIPTS[@]}"
line "Found $NUM_SCRIPTS setup scripts."
div

############################
# Run scripts in alphabetical order
############################
echo ""
line "Executing setup scripts..."
for (( x=0; x < $NUM_SCRIPTS; x++ )); do
	num_box "[$((x+1))/$NUM_SCRIPTS]" "${SCRIPT_NAMES[$x]}"
	source "${SCRIPTS[$x]}"
	echo ""
done


########################
# 	Unset script utilities
######################
unset div
unset line
unset note
unset fixme
unset box
