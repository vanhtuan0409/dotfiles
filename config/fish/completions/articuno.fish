# articuno fish shell completion

function __fish_articuno_no_subcommand --description 'Test if there has been any subcommand yet'
    for i in (commandline -opc)
        if contains -- $i completions bash zsh generate help h
            return 1
        end
    end
    return 0
end

complete -c articuno -f
complete -c articuno -n '__fish_articuno_no_subcommand' -l config -s c -r -d 'Path to global config `FILE`'
complete -c articuno -n '__fish_articuno_no_subcommand' -l input-dir -s i -r -d 'Path to config `DIR`'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l jenkins-lib-version -r -d 'Version of Foody jenkins lib'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l no-color -d 'Disable log color'
complete -c articuno -n '__fish_articuno_no_subcommand' -l out-dir -s o -r -d 'Path to output `DIR`'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l registry-password -r -d 'Harbor registry password'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l registry-url -r -d 'Harbor registry url'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l registry-user -r -d 'Harbor registry user'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l sentry-token -r -d 'Sentry user token'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l sentry-url -r -d 'Sentry url address'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l verbose -d 'Show verbose log'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l help -s h -d 'show help'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l version -s V -d 'Print version and exit'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l help -s h -d 'show help'
complete -c articuno -n '__fish_articuno_no_subcommand' -f -l version -s V -d 'Print version and exit'
complete -c articuno -n '__fish_seen_subcommand_from completions' -f -l help -s h -d 'show help'
complete -r -c articuno -n '__fish_articuno_no_subcommand' -a 'completions' -d 'Generate completion'
complete -c articuno -n '__fish_seen_subcommand_from bash' -f -l help -s h -d 'show help'
complete -r -c articuno -n '__fish_seen_subcommand_from completions' -a 'bash' -d 'Generate bash completion'
complete -c articuno -n '__fish_seen_subcommand_from zsh' -f -l help -s h -d 'show help'
complete -r -c articuno -n '__fish_seen_subcommand_from completions' -a 'zsh' -d 'Generate zsh completion'
complete -c articuno -n '__fish_seen_subcommand_from generate' -f -l help -s h -d 'show help'
complete -r -c articuno -n '__fish_articuno_no_subcommand' -a 'generate' -d 'Generate files from config'
complete -c articuno -n '__fish_seen_subcommand_from generate' -f -l generators -r -d 'List of generators which will be applied. Available are: "enrich,helm,jenkins,rbac,traefik"'
complete -c articuno -n '__fish_seen_subcommand_from help h' -f -l help -s h -d 'show help'
complete -r -c articuno -n '__fish_articuno_no_subcommand' -a 'help h' -d 'Shows a list of commands or help for one command'

