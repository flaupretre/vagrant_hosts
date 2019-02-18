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
                bind-utils \
                deltarpm \
                tcpdump

#-------------
echo "---- Installing pre-requisites for guest additions"

yum -y install tar bzip2 gcc make perl kernel-devel

#-----
echo "---- Cleaning yum cache"

rm -rf /var/cache/yum/*

#-----
echo "---- Disabling selinux"

echo "SELINUX=disabled" >/etc/selinux/config

#-----
echo "---- Shutting down"

shutdown -h now

#============================================================================
# MANUEL
# Install guest additions
# yum -y remove gcc make kernel-devel
