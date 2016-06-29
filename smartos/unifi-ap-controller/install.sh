pkgin -y up
pkgin -y unzip

# Install Java
# UnifiAPC reported to work with Java 6 or 7 but not 8
# https://community.ubnt.com/t5/UniFi-Wireless/Unifi-controller-fails-to-install-on-Ubuntu-16-04-LTS/td-p/1543665
# 8 may now work according to link
# However, unifi UAP Controller requires snappy, and pkgsrc has openjdk7 as a dependency of snappy-java10
pkgin -y in openjdk7
pkgin -y in snappy-java10


# mongodb
#pkgin -y in mongodb-3.2.3
# 3.2.3 did not work - constantly server restarted after accepting connections
pkgin -y in mongodb-3.0.11
svcadm disable mongodb

# UniFi AP Controller
cd /opt/local
wget http://dl.ubnt.com/unifi/5.0.7/UniFi.unix.zip
unzip UniFi.unix.zip
mv UniFi UniFi-5.0.7
ln -s UniFi-5.0.7/ UniFi
cd UniFi/bin
rm mongod
ln -s /opt/local/bin/mongod mongod

# Fix snappy-java
# Found this tip here: 
# https://community.ubnt.com/t5/UniFi-Wireless/Tried-upgrading-to-4-8-12-and-since-then-no-way-to-reach-the/td-p/1475318
cd /opt/local/UniFi/lib
mv /opt/local/UniFi/lib/snappy-java-1.0.5.jar /opt/local/UniFi/lib/snappy-java-1.0.5.jar.shipped
wget http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.2/snappy-java-1.1.2.jar
cp snappy-java-1.1.2.jar snappy-java-1.0.5.jar # not sure last step strictly necessary ?

# Install SMF manifest
cd
# check ensure unifi.xml exists in /root
svccfg import unifi.xml
# maintenance status

# Enable bonjour/multicast DNS
svcadm enable multicast
