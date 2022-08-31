complete -c proxychains -s f -r -d "Configure File"
complete -c proxychains -s q -d "Quiet Mode"
complete -c proxychains -d "Command to run" -x -a "(__fish_complete_subcommand -f)"
