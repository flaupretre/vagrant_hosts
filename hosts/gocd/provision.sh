#!/bin/bash

#-------------
#echo "---- Running shared provision"

. /shared/scripts/provision.sh

#-------------
echo "---- Installing GoCD pre-requisites"

curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo

# at least Java 8 is required, you may use other jre/jdk if you prefer

yuminst java-1.8.0-openjdk

for i in server agent ; do
  echo "---- Installing GoCD $i"
  svc="go-$i"
  yuminst $svc
done

#-------------
echo "---- Starting GoCD services"

for i in server agent ; do
  svc="go-$i"
  chkconfig $svc on
  service $svc start
done



