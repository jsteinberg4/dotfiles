Setup Script Template
----

* `dotfiles/setup.sh` uses a [template method pattern](https://refactoring.guru/design-patterns/template-method) to run the installer for each script.
* These template methods are:
	- `run_install`:  Executes any steps necessary to install the given program
	- `clear_installers`: Unsets run_install and any other functions. Probably unecessary, but prevents any scripts from unintentionally running a function defined by another script.
* In addition, scripts should define the variable `NAME` as the name of the program. This is used to display the program name to the user.
* **NOTE**: Scripts will not be discovered unless they use the `.sh` file extension!

----

### Example Setup Script

```
#################
# MyProgram Setup
#################
NAME="MyProgram"
run_install() {
	line "Installing $MyProgram.app from homebrew"
	... # Do some installation stuff
	_install_helper "SOS"
	... # Do more stuff
}

_install_helper() {
	warn "We may have had some complications! I was the only helper :'("
	... # Do some other stuff
}

clear_installers() {
	unset run_install
	unset _install_helper
}
```

----

## Provided Helpers
### Functions/Aliases
* `line(string)` -- Prints a formatted line prefixed by `[*]`
* `note(string)` -- Prints a formatted line prefixed by `[NOTE]`
* `warn(string)` -- Prints a formatted line prefixed by `[WARN]`
* `fixme(string)` -- Prints a formatted line prefixed by `[FIXME]`
* `debug(string)` -- Prints a formatted line prefixed by `[DEBUG]`
* `box(string)` -- Prints `string` with divider lines above and below
### Variables
* `WORKING_DIR` -- The base repo directory (i.e. `pwd` run within `dotfiles/`)
* `NAME` -- Name of the program to be installed (defined in each script)
* `TIMEOUT` -- Total time before programs are installed by default
* `SCRIPT_DIR` -- Directory containing the setup scripts
