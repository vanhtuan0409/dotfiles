
function __complete_vault
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /usr/bin/vault
end
complete -f -c vault -a "(__complete_vault)"

