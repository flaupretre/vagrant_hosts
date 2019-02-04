#!/bin/bash
#
# Don't forget to install the VB Guest addtions !
#
# After installing the VB guest additions, run :
# yum -y remove gcc make kernel-devel ; rm -rf /var/cache/yum/*
#
#============================================================================

#-------------
echo "---- Base"

yum -y upgrade

yum -y install  net-tools \
                deltarpm

#-------------
# Install pre-requisites for guest additions

yum -y install tar bzip2 gcc make perl kernel-devel

#-----

rm -rf /var/cache/yum/*

# Disable selinux

echo "SELINUX=disabled" >/etc/selinux/config
