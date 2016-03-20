pkgin -y in rsync

# Copy staged files
cp --backup=t rsyncd.conf /opt/local/etc/rsync/
cp --backup=t rsyncd.secrets /opt/local/etc/rsync/

chmod 0600 /opt/local/etc/rsync/rsyncd.secrets

echo ===
echo edit /opt/local/etc/rsync/rsyncd.conf and rsyncd.secrets
echo then
echo svcadm enable rsyncd
echo ===
