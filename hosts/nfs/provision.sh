#-------------
#echo "---- Running shared provision"

. /shared/scripts/provision.sh

#-------------
#echo "---- Configuring NFS server"

sf_svc_enable nfs-server
sf_svc_start nfs-server

echo "/home *(rw,sync)" >/etc/exports
exportfs -av

#-------------
#echo "---- Installing/configuring Samba"

yuminst samba

sf_check_copy /vagrant/etc/smb.conf /etc/samba/smb.conf

sf_svc_enable smb
sf_svc_start smb

#==============================================================================
# MANUEL:
#
# Mot de passe user:
# smbpasswd -a flaupretre

