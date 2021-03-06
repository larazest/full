#!/bin/bash
# ------------------------------------------------------------------------------
# Provisioning script for the Larazest web server stack
# ------------------------------------------------------------------------------

apt-get update

# ------------------------------------------------------------------------------
# Install Ruby and some gems
#
# The Nokogiri gem has to be compiled and linked against libxml2 and libxslt.
# ------------------------------------------------------------------------------

# Ruby
apt-get -y install ruby ruby-dev

# Gems
gem install systemu --no-ri --no-rdoc
gem install kramdown --no-ri --no-rdoc
gem install kwalify --no-ri --no-rdoc

# Nokogiri Gem (requires compilation). See this ticket for why an old version is needed (at time of writing):
# 	https://github.com/sparklemotion/nokogiri/issues/1196
apt-get -y install build-essential
apt-get -y install libxslt-dev libxml2-dev
gem install nokogiri -v 1.6.3.1 --no-ri --no-rdoc 

# ------------------------------------------------------------------------------
# Install wkhtmltopdf (PDF generator)
#
# Ubuntu ships with an old version so instead copy tool from this repository
#
# Libxrender is used for headless PDF generation on servers without a GUI
# ------------------------------------------------------------------------------

# wkhtmltopdf
apt-get -y install libxrender1
cp /provision/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

# ------------------------------------------------------------------------------
# Install test tools
# ------------------------------------------------------------------------------

# Selenium server (not available as a Ubuntu package)
apt-get -y install default-jre
mkdir /usr/local/selenium
curl -o /usr/local/selenium/selenium.jar http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar
mkdir -p /var/log/selenium/
chmod a+w /var/log/selenium/

# install selenium as an optional service
cp /provision/service/selenium.conf /etc/supervisord/selenium.conf

# PhantomJS headless browser (Ubuntu package is tool old)
curl -L -o /tmp/phantomjs.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
mkdir /tmp/phantomjs
tar xvfj /tmp/phantomjs.tar.bz2 -C /tmp/phantomjs --strip 1
cp /tmp/phantomjs/bin/phantomjs /usr/bin/phantomjs
chmod +x /usr/bin/phantomjs

# Enable XDEBUG (for remote code coverage reports)
apt-get -y install php5-xdebug
cp /provision/conf/xdebug.ini /etc/php5/mods-available/xdebug.ini

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------
rm -rf /provision