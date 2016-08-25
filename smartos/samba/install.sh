pkgin -y up
pkgin -y in samba

# TODO this won't run twice without screwing up
mv /opt/local/etc/samba/smb.conf /opt/local/etc/samba/smb.conf.original
mv ~/smb.conf /opt/local/etc/samba/smb.conf

groupadd -g 1001 james
useradd -u 1001 -g james james
smbpasswd -a -n james
# set password manually
# smbpasswd james

useradd sonos
smbpasswd -a -n sonos
# set password manually
# smbpasswd sonos

svcadm restart smbd
