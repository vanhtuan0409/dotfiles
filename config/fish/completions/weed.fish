
function __complete_weed
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /usr/bin/weed
end
complete -f -c weed -a "(__complete_weed)"

