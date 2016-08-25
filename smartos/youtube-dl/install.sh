# Update packages
pkgin -y up
pkgin -y fug

# pkgsrc ffmpeg is built with x264 and gnu components!
pkgin -y in ffmpeg3

# Development tools
pkgin -y in gmake
pkgin -y in gcc49
pkgin -y in autoconf
pkgin -y in automake

# AtomicParsley - metadata editor
# Currently does not compile for illumos
wget https://bitbucket.org/wez/atomicparsley/get/0.9.6.tar.gz
tar xfvz 0.9.6.tar.gz
cd wez-atomicparsley-da2f6e4fc120/
./autogen.sh
./configure
cd src
# illumos glibc has lroundf but was not detected
echo "#define HAVE_LROUNDF 1" >> config.h

# error in MIN macro (also tries to pull from stdlib without #including <algorithms>
echo "#undef MIN" >> AtomicParsley.h
echo "#define MIN(X,Y) (X < Y ? X : Y)" >> AtomicParsley.h

cd ..
make
# Currently fails due to undefined symbol in CDtoc.cpp
# only comiples on linux, mac osx, and windows
cd


# youtube-dl
wget https://github.com/rg3/youtube-dl/releases/download/2016.08.22/youtube-dl-2016.08.22.tar.gz
tar xfvz youtube-dl-2016.08.22.tar.gz
cd youtube-dl
make PREFIX=/opt/local install

# make user
groupadd -g 1001 james
useradd -g james -u 1001 -m james

