#!/bin/bash
clear

killsymlink () {
    cd $1
    if [ -L ".$2" ]
    then
        sudo unlink npm
    fi
    CD $3
}

installifmissing () {
    COMMAND=`command -v $1`
    if [[ -z "${COMMAND// }" ]]
    then
        echo " Prereq: Installing [$1]..."
        sudo apt-get install $1
    else
        echo " OK. Found [$1]..."
    fi
}


echo "++++++++++++++++++++++++++++++"
echo "+ nvm installer              +"
echo "++++++++++++++++++++++++++++++"
echo ""
PARAM=$1
NODEDEFAULT='v6.9.4'
NODEVER=${PARAM:=$NODEDEFAULT}
RUN_FROM="$PWD"
echo "------------------------------"
echo " Version: $NODEVER"
echo ""
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH
EXPECTED='Ubuntu'
SYSTEM=`./system.sh | grep $EXPECTED`
if [[ -z "${SYSTEM// }" ]]
then
    echo "System is not $EXPECTED"
    exit 1
fi
FOUND=`echo $SYSTEM | cut -d ':' -f 3`
echo "------------------------------"
echo " Found:$FOUND"
echo "----"
echo "Purging previous installs if exist..."
echo ""
killsymlink "/usr/bin" "node" "$SCRIPTPATH"
killsymlink "/usr/bin" "nodejs" "$SCRIPTPATH"
killsymlink "/usr/bin" "npm" "$SCRIPTPATH"
killsymlink "/usr/bin" "nvm" "$SCRIPTPATH"
installifmissing "git"
echo "------------------------------"
echo " Installing [nvm]..."
sudo rm -fr +/.nvm
curl https://raw.githubusercontent.com/creationix/nvm/v0.11.1/install.sh | bash
source ~/.profile
# Caution: If at this point your command line is saying nvm is not available
#          please reconnect your terminal by closing and reopening it
#          (it reads afresh all env vars)
nvm ls-remote
echo "------------------------------"
echo " Installing [node] $NODEVER"
nvm install "$NODEVER"
nvm use "$NODEVER"
# global alias
REAL=`type -a ~/.nvm/$NODEVER/bin/node`
REALPATH=`echo $REAL | cut -d ' ' -f 1`
REALPATHDIR=`dirname $REALPATH`
echo "symlink[1]: $REALPATHDIR/node as /usr/bin/node"
echo "symlink[2]: $REALPATHDIR/node as /usr/bin/nodejs"
echo "symlink[3]: $REALPATHDIR/npm as /usr/bin/npm"
echo "symlink[4]: $REALPATHDIR/npm-license as /usr/bin/npm-license"

cd /usr/bin
if [ -L "./npm" ]
then
    sudo unlink npm
fi
if [ -L "./node" ]
then
    sudo unlink node
fi
if [ -L "./nodejs" ]
then
    sudo unlink nodejs
fi
if [ -L "./npm-license" ]
then
    sudo unlink npm-license
fi
sudo ln -s "$REALPATHDIR/node"
sudo ln -s "node" "nodejs"
sudo ln -s "$REALPATHDIR/npm"
echo "------------------------------"
echo " Checking [nodejs] alias"
command -v node
echo "------------------------------"
echo " Both for [node] and [nodejs] alias:"
node --version
nodejs --version
echo "------------------------------"
echo " Checking [npm]"
npm --version
echo "------------------------------"
echo " Checking [nvm]"
nvm --version
echo "------------------------------"
echo " Installing [npm-license]..."
npm config set proxy "$http_proxy"
npm config set https-proxy "$http_proxy"
npm install -g npm-license
chmod +x "$REALPATHDIR/npm-license"
sudo ln -s "$REALPATHDIR/npm-license"
echo " Checking..."
npm-license --version
exit 0
