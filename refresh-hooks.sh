#!/bin/sh

if [ "$REPO_DIR" == "" ]; then
	REPO_DIR="$(git rev-parse --show-toplevel)"
fi

yellow='\033[0;33m'
cd "$REPO_DIR/hooks/"
for FILE in *; do
	echo "${yellow} > Linking hook:  $(pwd)/$FILE"
	ln -sF "$REPO_DIR/hooks/$FILE" "$REPO_DIR/.git/hooks/$FILE"
done
cd "$REPO_DIR"
