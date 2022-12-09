####################
# Brave Browser
####################
NAME="Brave Browser"

_source_url="https://laptop-updates.brave.com/latest/osx"

run_install() {
	debug "$NAME run_install"

	# TODO -- Linux support?
	TMPDIR=`mktemp -d -t "brave-browser-install"` || ( warn "brave.sh was unable to allocate a temp directory" && exit 1 )
	line " -- Temp Directory: $TMPDIR"
	curl -fsSL -output-dir "$TMPDIR"  "$_source_url"
}

clear_installers() {
	unset run_install
}
