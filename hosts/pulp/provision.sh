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
#echo "---- Configuring repositories"

yuminst "http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"

curl -o /etc/yum.repos.d/rhel-pulp.repo https://repos.fedorapeople.org/repos/pulp/pulp/rhel-pulp.repo

#-------------
#echo "---- Installing software"

yuminst mongodb-server
systemctl enable --now mongod

yuminst qpid-cpp-server qpid-cpp-server-linearstore
systemctl enable --now qpidd

yuminst pulp-server \
        python-gofer-qpid \
        python2-qpid \
        qpid-tools \
        pulp-rpm-plugins \
        pulp-deb-plugins

#-------------
#echo "---- Configuring"

pulp-gen-key-pair
pulp-gen-ca-certificate

sudo -u apache pulp-manage-db

cat >/etc/default/pulp_workers <<EOF

PULP_CONCURRENCY=2
PULP_MAX_TASKS_PER_CHILD=5
EOF

#-------------
echo "---- Starting services"

systemctl enable --now pulp_workers pulp_celerybeat pulp_resource_manager httpd

#-------------
echo "---- Installing admin client"

yuminst pulp-admin-client \
        pulp-rpm-admin-extensions \
        pulp-deb-admin-extensions \
        pulp-puppet-admin-extensions \
        pulp-docker-admin-extensions

 
#============================================================================
# MANUEL:
#
# Dans /etc/pulp/admin/admin.conf : verify_ssl = False
#
# . /shared/scripts/mk_pulp_repos.sh
# create_centos_repos 7.7.1810 7.6
# create_debian_repos 9.7 "main contrib" "amd64"



