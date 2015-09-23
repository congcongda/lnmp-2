#!/bin/bash

if [ ! -f libiconv-1.14.tar.gz ];then
	wget ${cdn}/project/libiconv/libiconv-1.14.tar.gz
fi
rm -rf libiconv-1.14
tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14
rm -rf patch
mkdir patch
wget ${cdn}/patch/libiconv/libiconv-1.14/srclib/stdio.in.h.patch -P patch
patch -p1 < patch/stdio.in.h.patch
./configure --prefix=/usr/local
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
libtool --finish /usr/local/lib
cd ..

if [ ! -f zlib-1.2.8.tar.gz ];then
	wget ${cdn}/project/zlib/zlib-1.2.8.tar.gz
fi
rm -rf zlib-1.2.8
tar zxvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..

if [ ! -f freetype-2.6.tar.gz ];then
	wget ${cdn}/project/freetype/freetype-2.6.tar.gz
fi
rm -rf freetype-2.6
tar zxvf freetype-2.6.tar.gz
cd freetype-2.6
./configure --prefix=/usr/local/freetype.2.6
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f libpng-1.6.18.tar.gz ];then
    wget ${cdn}/project/libpng/libpng-1.6.18.tar.gz
fi
rm -rf libpng-1.6.18
tar zxvf libpng-1.6.18.tar.gz
cd libpng-1.6.18
./configure --prefix=/usr/local/libpng.1.6.18
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..

if [ ! -f libevent-2.0.22-stable.tar.gz ];then
	wget ${cdn}/project/libevent/libevent-2.0.22-stable.tar.gz
fi
rm -rf libevent-2.0.22-stable
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f libmcrypt-2.5.7.tar.gz ];then
	wget ${cdn}/project/libmcrypt/libmcrypt-2.5.7.tar.gz
fi
rm -rf libmcrypt-2.5.7
tar zxvf libmcrypt-2.5.7.tar.gz
cd libmcrypt-2.5.7
./configure --disable-posix-threads
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make
make install
cd ../..

if [ ! -f pcre-8.37.zip ];then
	wget ${cdn}/project/pcre/pcre-8.37.zip
fi
rm -rf pcre-8.37
unzip pcre-8.37.zip
cd pcre-8.37
./configure
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f jpegsrc.v9a.tar.gz ];then
	wget ${cdn}/project/jpegsrc/jpegsrc.v9a.tar.gz
fi
rm -rf jpeg-9a
tar zxvf jpegsrc.v9a.tar.gz
cd jpeg-9a
if [ -e /usr/share/libtool/config.guess ];then
cp -f /usr/share/libtool/config.guess .
elif [ -e /usr/share/libtool/config/config.guess ];then
cp -f /usr/share/libtool/config/config.guess .
fi
if [ -e /usr/share/libtool/config.sub ];then
cp -f /usr/share/libtool/config.sub .
elif [ -e /usr/share/libtool/config/config.sub ];then
cp -f /usr/share/libtool/config/config.sub .
fi
./configure --prefix=/usr/local/jpeg.9 --enable-shared --enable-static
mkdir -p /usr/local/jpeg.9/include
mkdir /usr/local/jpeg.9/lib
mkdir /usr/local/jpeg.9/bin
mkdir -p /usr/local/jpeg.9/man/man1
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install-lib
make install
cd ..

#load /usr/local/lib .so
touch /etc/ld.so.conf.d/usrlib.conf
echo "/usr/local/lib" > /etc/ld.so.conf.d/usrlib.conf
/sbin/ldconfig

if [ "$isMysql" == "yes" ];then
#create account.log
cat > account.log << END
########################################################
#                                                      #
#    thank you for using FlarumOne virtual machine     #
#                                                      #
########################################################

MySQL:
account:root
password:mysql_password

END
fi