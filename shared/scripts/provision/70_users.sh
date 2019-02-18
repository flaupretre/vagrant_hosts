#-------------
echo "---- Users"

sf_create_group admin 2000
echo '%admin  ALL=(ALL) NOPASSWD:ALL' | sf_check_copy - /etc/sudoers.d/admin 400

grep '^flaupretre:' /etc/passwd >/dev/null || useradd --gid admin -u 2000 flaupretre

if [ `hostname` != 'nfs.canaltp.local' ]; then
  sf_check_line /etc/fstab \
    '^nfs.canaltp.local:/home/flaupretre' 'nfs.canaltp.local:/home/flaupretre /home/flaupretre nfs defaults 0 0'
  mount -a
fi
