#!/usr/bin/env bash

apt-get update
apt-get purge ruby -y

apt-get install build-essential libyaml-dev libssl-dev openssl -y

wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz

tar -xvzf ruby-2.2.2.tar.gz
cd ruby-2.2.2

./configure --enable-shared --disable-install-doc --disable-install-rdoc --disable-install-capi

make -j4 ; make install

echo "gem: --no-document" >> ~/.gemrc

gem install chef --no-ri --no-rdoc

chef-client --version