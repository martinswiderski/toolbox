#!/usr/bin/env bash
clear
echo "+++++++++++++++++++++++++++++++"
echo "+ masterless puppet config    +"
echo "+++++++++++++++++++++++++++++++"
echo ""
DIR=$1
GIT=$2
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH
WHOAMI=`whoami`
if [ -d "_tmp" ]
then
  rm -fr _tmp/
fi
git clone $GIT _tmp >/dev/null 2>&1
echo "User                           : [ X ] $WHOAMI"
if [ ! "$WHOAMI" == "root" ]
then
    echo "User error                     : [   ] root only!!!"
    exit 1
fi
DIREXISTS=`[ -d "$DIR" ] && echo "[ X ]" || echo "[   ]"`
echo "Your Puppet directory          : $DIREXISTS $DIR"
GITEXISTS=`[ -d "_tmp" ] && echo "[ X ]" || echo "[   ]"`
if [ -d "_tmp" ]
then
  rm -fr _tmp/
fi
echo "Your git repository for Puppet : $GITEXISTS $GIT"

echo "@todo: complete"
exit 1
