#!/bin/bash

function yumy()
{
yum -y $*
}

#---

function yuminst()
{
yumy install $*
}

#-------------
#echo "---- Ajout des repos"

yuminst "https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm" \
  "http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" \
  "https://yum.theforeman.org/releases/1.20/el7/x86_64/foreman-release.rpm"

#-------------
#echo "---- Ajout de foreman-installer"

yuminst foreman-installer

#-------------
#echo "---- Running foreman installer"

foreman-installer \
  --enable-foreman-plugin-ansible                    \
  --enable-foreman-plugin-docker                           \
  --enable-foreman-plugin-discovery                        \
  --enable-foreman-plugin-monitoring                       \
  --enable-foreman-plugin-openscap                         \
  --enable-foreman-plugin-remote-execution                 \
  --enable-foreman-compute-ec2                             \
  --enable-foreman-compute-vmware                          \
  --enable-foreman-proxy-plugin-ansible                    \
  --enable-foreman-proxy-plugin-discovery                  \
  --enable-foreman-proxy-plugin-monitoring                 \
  --enable-foreman-proxy-plugin-openscap                   \
  --enable-foreman-proxy-plugin-pulp                       \
  --enable-foreman-proxy-plugin-remote-execution-ssh       \
  --foreman-proxy-bmc true


#==========================================================================
#======= Manuel

# Creation compte flaupretre/toto








