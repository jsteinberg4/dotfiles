# dotfiles

* This is a collection of dotfiles (configuration files) I use on my personal computers.
* Clone this repo to your home directory, then setup in one of the following ways:
  * **Method 1**: Manual
    * Symlink each file to the correct location using `ln -s <src> <destination>`
  * **Method 2**: Automatic *[WIP]*
    * curl and execute `dotfiles/install.sh`. This will clone the repository
    to your local machine, then execute any scripts in `dotfiles/setup_scripts/*.sh`.
