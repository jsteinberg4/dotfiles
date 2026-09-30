############################
# Install Command Line Utils with Homebrew
############################
utils=("ripgrep" "fd" )
utils_str=""
for u in "${utils[@]}"; do
	utils_str+="$u,"
done

NAME="CLI_Utils=($utils_str)"

run_install() {
	echo "brew install ${utils[@]}"
	eval "brew install ${utils[@]}"
}

clear_installers() {
	unset run_install
	unset utils
	unset utils_str
}
