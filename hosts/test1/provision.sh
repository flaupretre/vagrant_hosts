#!/bin/bash

#-------------
echo "---- Running shared provision"

. /shared/scripts/provision.sh

#-------------
echo "---- Installing packages"

yuminst git \
        ansible