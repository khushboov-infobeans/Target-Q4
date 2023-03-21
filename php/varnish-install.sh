#!/bin/bash

set -e

#curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | sudo apt-key add -

apt-get update

apt-get -y install varnish

apt-get update

