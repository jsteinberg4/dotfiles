dotfiles
---

* This is a collection of dotfiles (configuration files) I use on my personal computers.
* Clone this repo to your home directory, then setup in one of the following ways:
	* **Method 1**: Manual
		* Symlink each file to the correct location using `ln -s <src> <destination>`
	* **Method 2**: Automatic *[WIP]*
		* Simply run `dotfiles/setup.sh`. This will run any scripts in `dotfiles/setup_scripts/*.sh`. Assuming all the necessary scripts are present, this will do all the appropriate setup.
