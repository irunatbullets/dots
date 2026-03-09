
RED=$'\e[1;31m'
WHITE=$'\e[1;37m'
RESET=$'\e[0m'

if [[ -n "$CONTAINER_ID" ]]; then
    case "$CONTAINER_ID" in
        debian)
            export CONTAINER_PROMPT="${RED} ${RESET}"
            ;;
        *)
            export CONTAINER_PROMPT="${WHITE}📦 ${RESET}"
            ;;
    esac
fi

