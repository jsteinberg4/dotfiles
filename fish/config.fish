# Equivalent to a bashrc file
# file:///opt/homebrew/Cellar/fish/3.7.1/share/doc/fish/language.html#configuration-files
if status is-interactive
    # Commands to run in interactive sessions can go here

    # NOTE: Wrap abbreviations/functions if slow. Avoids redefining them, should speed up shell startup
    # if not set -q _MY_ABBREV_SET
    #   set -U _MY_ABBREV_SET true
    # end

    # Example from file:///opt/homebrew/Cellar/fish/3.7.1/share/doc/fish/interactive.html#abbreviations
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    if type -q lazygit
        abbr --add lg lazygit
    end
end
