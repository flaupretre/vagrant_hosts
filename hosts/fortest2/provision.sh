#!/bin/bash

tmpf=/tmp/.tf$$

foreman_version=1.21

#-------------
#echo "---- Running shared provision"

. /shared/scripts/provision.sh

#-------------
#echo "---- Adding repos"

yuminst "https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm" \
  "http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" \
  "https://yum.theforeman.org/releases/$foreman_version/el7/x86_64/foreman-release.rpm"

#-------------
#echo "---- Adding foreman installer"

yuminst foreman-installer

#-------------
#echo "---- Running foreman installer"

# Foreman installer checks hostname and requires this

echo '192.168.56.102  fortest.canaltp.local fortest' >$tmpf
cat /etc/hosts >>$tmpf
cp $tmpf /etc/hosts

# Run installer

foreman-installer                                          \
  --enable-foreman-plugin-ansible                          \
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

# Creation compte flaupretre/tototiti dans foreman








