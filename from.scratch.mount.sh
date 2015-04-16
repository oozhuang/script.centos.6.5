#!/usr/bin/env bash
CUR_DIR=$(cd `dirname $0`;pwd)

if [[ $# -lt 2 ]]; then
	echo "usage:$0 mount-dev mount-dir">&2; exit;
fi

if [[ ! -f "$1" ]]; then
	echo "mount-dev $1 doesnot exist.">&2; exit
fi

if [[ -f "$2" || -d "$2" ]]; then
	echo "mount-dir $2 already exists.">&2; exit
fi

m_dev="$1"
m_dir="$2"

set -e
sudo fdisk $m_dev
#fdisk -l
sudo mkfs.ext3 ${m_dev}1
#cat /etc/fstab 
sudo echo "${m_dev}1 $m_dir    ext3    defaults    0  0" >> /etc/fstab
#cat /etc/fstab 
sudo mkdir $m_dir
mount -a
