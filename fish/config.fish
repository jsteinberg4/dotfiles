# Equivalent to a bashrc file
# file:///opt/homebrew/Cellar/fish/3.7.1/share/doc/fish/language.html#configuration-files

# Helpful for homebrew setup: https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262
if status is-interactive
    # Commands to run in interactive sessions can go here
    function _warn -a msg
        begin
            set_color --bold yellow
            echo "[WARNING] $msg"
            set_color normal
        end >&2
    end

    # Example from file:///opt/homebrew/Cellar/fish/3.7.1/share/doc/fish/interactive.html#abbreviations
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    if type -q lazygit
        abbr --add lg lazygit
    end
    # Use uv instead of raw pip
    if type -q uv
        abbr --add pip uv pip
    end

    # Use bat instead of cat if present
    if type -q bat
        # `--wraps` tells fish to use the completion options from bat
        function cat --wraps=bat
            _warn "Use bat instead of cat"
            command bat $argv
        end
    end

    # Use eza instead of ls
    if type -q eza
        set -l eza_universal_args --icons=always --git
        abbr --add eza eza $eza_universal_args

        function ls --wraps=eza
            _warn "Use `eza` instead of `ls`" >&2
            command eza $eza_universal_args $argv
        end

        function ll --wraps=eza
            set -l common_args -A --long --header
            set -l lines (command eza -A --oneline $argv 2>/dev/null | wc -l | string trim)

            if test "$lines" -ge 30
                command eza $eza_universal_args $common_args --grid $argv
            else
                command eza $eza_universal_args $common_args $argv
            end
        end

        function tree --wraps=eza
            command eza $eza_universal_args -T --long --header $argv
        end
    end

    # Vim keybind
    fish_vi_key_bindings
end
