#!/usr/bin/env bash

RESET="\e[0m"
YELLOW="\e[93m"
GREEN="\e[32m"
RED="\e[31m"
BOLD="\e[1m"
INVERT="\e[7m"
ERR=0

errorMessage() {
    echo -e "${BOLD}${YELLOW}${INVERT} Error ${RESET} no value set for ${BOLD}${YELLOW}${1}${RESET}"
}

validateBoolString() {
    BOOL=`echo "$1" | tr '[:upper:]' '[:lower:]'`
    if [[ "$BOOL" != "true" && "$BOOL" != "false" ]]
    then
        echo ""
    else
        echo "$BOOL"
    fi
}

# ------- input
#

echo ""
echo -e "${YELLOW}+--------------------------------------+${RESET}"
echo -e "${YELLOW}|${RESET} Local ${BOLD}${YELLOW}${INVERT} git ${RESET} repository configuration ${YELLOW}|${RESET}"
echo -e "${YELLOW}+--------------------------------------+${RESET}"
echo ""
echo -e "What is your git ${BOLD}${YELLOW}name/alias${RESET}?"
read NAME
echo -e "Your git (confirmed) ${BOLD}${YELLOW}(public) email${RESET}?"
read EMAIL
echo -e "Follow chmod file properties? ${BOLD}${YELLOW}true|false${RESET}"
read FILEPROPS

FILEPROPS=`validateBoolString "$FILEPROPS"`

echo ""
echo ""

# ------- errors
#

if [[ -z "${NAME// }" ]]
then
    ERR=$((ERR+1))
    errorMessage "git name/alias"
fi

if [[ -z "${EMAIL// }" ]]
then
    ERR=$((ERR+1))
    errorMessage "git (public) email"
fi

if [[ -z "${FILEPROPS// }" ]]
then
    ERR=$((ERR+1))
    errorMessage "file mode (or not true|false)"
fi

# ------- status
#

if [ "$ERR" != "0" ]
then
    echo ""
    echo -e "${RED}${BOLD}ERROR!${RESET} Setup failed.";
    echo ""
    exit 1
else
    git config user.name "$NAME"
    git config user.email "$EMAIL"
    git config core.fileMode "$FILEPROPS"
    echo ""
    echo -e "${GREEN}${BOLD}OK!${RESET} Setup complete.";
    echo ""
    exit 0
fi

