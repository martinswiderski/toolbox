#!/usr/bin/env bash
clear
echo "+++++++++++++++++++++++++++++++"
echo "+ masterless puppet installer +"
echo "+++++++++++++++++++++++++++++++"
echo ""
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH
# now running in directory that holds
# script: puppet-standalone-install.sh
GITDEFAULT='git@github.snei.sony.com:MSwiders/PDM-puppet.git'
echo "Enter your puppet git repository (full path via SSH)"
echo "or press [Enter] for default:"
read $INPUTGIT
GIT=${INPUTGIT:=$GITDEFAULT}
echo "git repository : $GIT"
echo ""
GITIN=`command -v git`
if [[ -z "${GITIN// }" ]]
then
    echo "git            : installing..."
    sudo apt-get install git
else
    echo "git            : installed"
fi
GITVERFULL=`git --version`
GITVER=`echo $GITVERFULL | cut -d ' ' -f 3`
echo "git version    : $GITVER"
echo ""
PUBKEY='/root/.ssh/id_rsa.pub'
SSHKEYROOT=`sudo cat $PUBKEY`
if [[ -z "${SSHKEYROOT// }" ]]
then
    echo "SSH key for [git] not installed"
    echo "Please install manually and re-run script"
    echo ""
    exit 1
else
    CHUNK1=`echo $SSHKEYROOT | cut -d ' ' -f 1`
    CHUNK2=`echo $SSHKEYROOT | cut -d ' ' -f 2`
    CHUNK3=`echo $SSHKEYROOT | cut -d ' ' -f 3`
    STRFIRST=${CHUNK2:0:3}
    STRLAST=${CHUNK2:(-6)}
    echo "SSH key        : \"$CHUNK1 $STRFIRST...$STRLAST $CHUNK3\""
    echo "In             : \"$PUBKEY\""
    echo ""
fi
# installation
PUPPETDEB='puppetlabs-release-trusty.deb';
PUPPETURL="http://apt.puppetlabs.com/$PUPPETDEB"
if [ -f "./$PUPPETDEB" ]
then
    rm $PUPPETDEB;
fi
echo "installing     : puppet"
wget $PUPPETURL  &> /dev/null
PUPPETMD5ALL=`md5sum ./$PUPPETDEB`
PUPPETMD5=`echo $PUPPETMD5ALL | cut -d ' ' -f 1`
echo "file           : $PUPPETDEB"
echo "MD5            : $PUPPETMD5"
sudo dpkg -i "./$PUPPETDEB"  &> /dev/null
sudo apt-get update &> /dev/null
apt-get install puppet git-core &> /dev/null
PUPPETVER=`puppet --version`
echo "installed      : $PUPPETVER"
# configuration
PUPPETDIR='/etc/puppet'
rm *.deb
echo "+---------------------------------------+"
echo "| Caution:   The rest of the operations |"
echo "|            we need to run as root     |"
echo "|            upon failure manually      |"
echo "|            repeat steps from:         |"
echo "| file:     ./puppet-config-as-root.sh  |"
echo "+---------------------------------------+"
echo "sudo ./puppet-config-as-root.sh $PUPPETDIR $GIT"
echo "+---------------------------------------+"
echo "Ready to run config as root? [Enter]"
read YES
sudo ./puppet-config-as-root.sh $PUPPETDIR $GIT
