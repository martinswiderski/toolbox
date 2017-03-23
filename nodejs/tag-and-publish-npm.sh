#!/usr/bin/env bash
clear
NL="\n"
CURRENT_NPM_VER=`npm version | grep '{' | cut -d "'" -f 2`
CURRENT_VCS=`cat package.json | grep '\.git' | cut -d '"' -f 4 | cut -d '+' -f 2`
CURRENT_MAINTAINER=`npm v | grep maintainers | cut -d "'" -f 2`
CURRENT_BRANCH=`git branch | grep "*" | cut -d " " -f 2`
CURRENT_WIP=`git status | grep "modified\|renamed"`
echo "+---------------------------+"
echo "| Release management script |"
echo "+---------------------------+"
echo ""
echo "Maintainer          : $CURRENT_MAINTAINER"
echo "Current version     : $CURRENT_NPM_VER"
echo "VCS                 : $CURRENT_VCS"
echo "Branch              : $CURRENT_BRANCH"
echo "Uncommitted WIP     : "
git status | grep "modified\|renamed"
echo ""
echo "---"
echo "login to npm..."
echo ""
#npm login
echo ""
echo "---"
echo "What is the version that you want to release?"
read RELEASE_VER
VER=`node src/tools/version.js --check $RELEASE_VER $CURRENT_NPM_VER`
if [ "$VER" == "Invalid version" ]
then
    echo "ERROR: $VER '$RELEASE_VER'";
    exit 1
fi
if [ "$VER" == "Wrong version number" ]
then
    echo "ERROR: Wrong version number: $RELEASE_VER (existing: $CURRENT_NPM_VER)";
    exit 1
fi
