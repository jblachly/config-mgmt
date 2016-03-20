# I prefer installation in /opt
pkgin -y in fail2ban

# Change path to IP Filter tool "ipf"
sed -e 's|/sbin/ipf|/usr/sbin/ipf|g' -i.orig /opt/local/etc/fail2ban/action.d/ipfilter.conf

# until fail2ban pull request #1365 integrated,
# need to add "failed" to "failure|error" in sshd.conf
sed -e 's/:failure|error/:failed|failure|error/g' -i.orig /opt/local/etc/fail2ban/filter.d/sshd.conf

# Grab the repo to get access to the SMF XML file
pkgin -y in git
git clone https://github.com/fail2ban/fail2ban.git

# copy staged files
cp jail.local paths-overrides.local /opt/local/etc/fail2ban/

# Make fail2ban an SMF service
# control script
sed -e 's|usr/local|opt/local|g' -e 's| /etc/| /opt/local/etc/|g' -i.orig fail2ban/files/solaris-svc-fail2ban
mkdir /var/svc/method
cp fail2ban/files/solaris-svc-fail2ban /var/svc/method/svc-fail2ban
chmod +x /var/svc/method/svc-fail2ban

# install SMF XML
sed -e 's|lib/svc|var/svc|g' -i.orig fail2ban/files/solaris-fail2ban.xml
svccfg import fail2ban/files/solaris-fail2ban.xml

# activate
svcadm enable fail2ban
