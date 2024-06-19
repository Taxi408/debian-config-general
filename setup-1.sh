#!/bin/bash

export runningas=$(whoami)
echo "RUNNING AS ${runningas}"

mkdir /rts
mkdir /rts/cnf
mkdir /rts/cnf/system
mkdir /rts/cnf/system/apt
mkdir /rts/cnf/system/network
mkdir /rts/cnf/user
mkdir /home/root
mkdir /home/root/.tmp

cd /etc
rm resolv.conf
wget https://github.com/Taxi408/debian-config-general/raw/main/system/network/resolv.conf

cd /etc/ntpsec
rm ntp.conf
wget https://github.com/Taxi408/debian-config-general/raw/main/system/network/ntp.conf

cd /etc/apt/keyrings
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/nodesource.gpg
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/openvpn.asc

cd /etc/apt/sources.list.d
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/sources-bookworm.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/strato-bookworm.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/openvpn.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/nodesource.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/microsoft-vscode.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/mariadb.list
wget https://github.com/Taxi408/debian-config-general/raw/main/system/apt/docker.list

cd /usr/share/keyrings
wget https://github.com/Taxi408/debian-config-general/raw/main/usr/share/keyrings/deb.sury.org-apache2.gpg
wget https://github.com/Taxi408/debian-config-general/raw/main/usr/share/keyrings/deb.sury.org-php.gpg
wget https://github.com/Taxi408/debian-config-general/raw/main/usr/share/keyrings/docker.gpg
wget https://github.com/Taxi408/debian-config-general/raw/main/usr/share/keyrings/githubcli-archive-keyring.gpg
wget https://github.com/Taxi408/debian-config-general/raw/main/usr/share/keyrings/nodesource.gpg

cd /
apt -y update
apt -y upgrade
apt -y full-upgrade
apt-get -y dist-upgrade
apt-get -y update

apt -y install mc nano htop ca-certificates gnupg openssl certbot s3fs sshfs davfs2 cifs-utils php perl python3 python3-pip unzip git curl default-jre software-properties-common apt-transport-https
apt -y build-dep mc nano htop ca-certificates gnupg openssl certbot sshfs s3fs davfs2 cifs-utils php perl python3 python3-pip unzip git curl default-jre software-properties-common apt-transport-https

apt -y install gnupg2 rdate

apt -y install ufw
apt -y build-dep ufw

apt -y install snap snapd
apt -y build-dep snap snapd

rdate -4unp ptbtime1.ptb.de
rdate -4uns ptbtime1.ptb.de

cd /root
echo 'SELECTED_EDITOR="/bin/nano"' > .selected_editor
echo 'alias ls="ls -AGhopqls1 --color"' >> .bashrc
echo 'alias updateworker="apt -y update && apt -y upgrade && apt -y full-upgrade && apt-get -y dist-upgrade && apt-get -y update"' >> .bashrc
echo 'alias timesync="rdate -4un ptbtime1.ptb.de"' >> .bashrc

source /root/.bashrc

exit 0
