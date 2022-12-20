###########################################
# 			Spotify Installer
###########################################
NAME="Spotify"

run_install() {
	# Curl the spotify installer ZIP and install
	line "Installing Spotify. You may be redirected..."

	# Download to a temp directory
	tmp_base="setup_spotify_sh"
	TMPDIR=`mktemp -d -t "$tmp_base"` || ( warn "spotify.sh was unable to allocate a temp directory" && exit 1 )

	echo "$TMPDIR"
	curl -LO --output-dir "$TMPDIR" "https://download.scdn.co/SpotifyInstaller.zip"
	unzip -d "$TMPDIR" "$TMPDIR/SpotifyInstaller.zip" > /dev/null

	# Wait until the installer finishes
	eval "open $TMPDIR/Install\ Spotify.app" 
	echo "\nWhen the installer finishes, press any key to continue..."
	read -n 1 -s -r -p '' key
	
	rm -rf "$TMPDIR" > /dev/null
	line "Spotify installed."
}

clear_installers() {
	unset run_install
}
