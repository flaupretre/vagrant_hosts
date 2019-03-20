#!/bin/bash

#-------------
#echo "---- Running shared provision"

. /shared/scripts/provision.sh

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
        pulp-deb-plugins \
		pulp-docker-plugins \
		pulp-ostree-plugins

#-------------
#echo "---- Configuring"

pulp-gen-key-pair
pulp-gen-ca-certificate

sudo -u apache pulp-manage-db

sf_check_copy /vagrant/etc/pulp_workers.txt /etc/default/pulp_workers

#-------------
echo "---- Starting services"

systemctl enable --now pulp_workers pulp_celerybeat pulp_resource_manager httpd

#-------------
echo "---- Installing admin client"

yuminst pulp-admin-client \
        pulp-rpm-admin-extensions \
        pulp-deb-admin-extensions \
        pulp-docker-admin-extensions \
        pulp-ostree-admin-extensions

sed -i '25,$s/^.*verify_ssl:.*$/verify_ssl: False/' /etc/pulp/admin/admin.conf

pulp-admin login -u admin -p admin

#============================================================================
# MANUEL:
#
# . /vagrant/pulp_repos.sh
# [ export PROXY_URL=http://ctp-prd-proxy ]
# [ export PROXY_PORT=1512 ]
# create_centos_repos 7.6.1810 7.6
# create_debian_repos 9.7 "main" "amd64" "stretch"
#
# Prevoir des FS séparés pour :
#   - /var/lib/pulp continet tous les fichiers
#   - /var/lib/mongodb 10 Go
#   - Déplacer /var/cache/pulp vers /var/lib/pulp/cache et créer lien symbolique


