################################################################################
# Bash completion for clamscan
#
# Copyright (C) 2020  Red Cursor
#
# Author: Shakiba Moshiri
# Project: btc (Bash Tab Completion)
# Source: github.com/redcursor
################################################################################

cmd_name='clamscan';    # $1
current_arg='';         # $2
previous_arg='';        # $3

clam_path=$(which clamscan);
clam_long_opt=$(egrep -o '\-\-[a-z-]+=?' <($clam_path --help 2>&1));

_comp_clamscan () {
    COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
    current_arg=${COMP_WORDS[$COMP_CWORD]};
    previous_arg=${COMP_WORDS[$COMP_CWORD-1]};

    case ${previous_arg} in
        --alert-* | \
        --scan-*  | \
        --leave-temps | \
        --gen-json | \
        --official-db-only | \
        --recursive | \
        --allmatch | \
        --cross-fs | \
        --remove | \
        --bytecode | \
        --bytecode-unsigned | \
        --detect-pua | \
        --detect-structured | \
        --scan-mail | \
        --phishing-sigs | \
        --phishing-scan-urls | \
        --heuristic-alerts | \
        --heuristic-scan-precedence | \
        --normalize )

            COMPREPLY=(yes no '*');
            case ${current_arg} in
                y )
                    COMPREPLY=(yes)
                ;;
                n )
                    COMPREPLY=(no)
                ;;
                \* )
                    COMPREPLY=(\*)
                ;;
            esac
        ;;
        '--move=' )
            # all_dirs=$(compgen -d);
            # COMPREPLY=( $(egrep -o "$current_arg.+" <<< ${all_dirs[@]}) );
        ;;
    esac
    
    case ${current_arg} in
        --[a-z]* )
            COMPREPLY=( $(egrep -o "${current_arg//-/\\-}[^ ]+" <<< ${clam_long_opt[@]}) );
        ;;
        - | -- )
            COMPREPLY=(${clam_long_opt[@]});
        ;;
    esac
}

complete -o bashdefault -o default -F _comp_clamscan clamscan
