
echo "Downloading OpenBSD 6.2 amd64 Sources";
cd /root
wget http://mirror.switch.ch/ftp/pub/OpenBSD/6.2/src.tar.gz
wget http://mirror.switch.ch/ftp/pub/OpenBSD/6.2/sys.tar.gz
wget http://mirror.switch.ch/ftp/pub/OpenBSD/6.2/ports.tar.gz
wget http://mirror.switch.ch/ftp/pub/OpenBSD/6.2/xenocara.tar.gz
wget http://mirror.switch.ch/ftp/pub/OpenBSD/patches/6.2.tar.gz

echo "Installing Packages";
export PKG_PATH=http://mirror.switch.ch/ftp/pub/OpenBSD/6.2/packages/amd64
pkg_add -v GeoIP-1.6.11
pkg_add -v ImageMagick-6.9.9.11
pkg_add -v aide-0.16p0
pkg_add -v alpine-2.21
pkg_add -v aspell-0.60.6.1p5
pkg_add -v awstats-7.6
pkg_add -v clamav-0.99.2p5
pkg_add -v courier-authlib-0.68.0p2
pkg_add -v courier-authlib-pgsql-0.68.0p2
pkg_add -v courier-imap-4.18.0p1
pkg_add -v courier-pop3-4.18.0p1
pkg_add -v courier-unicode-2.0
pkg_add -v curl-7.55.1
pkg_add -v cyrus-sasl-2.1.26p24-pgsql
pkg_add -v dante-1.4.1p0
pkg_add -v db-3.1.17p2v0
pkg_add -v djvulibre-3.5.27p2
pkg_add -v dsniff-2.3p16-no_x11
pkg_add -v emacs-25.3-no_x11
pkg_add -v expect-5.45p5
pkg_add -v fftw3-3.3.4p0
pkg_add -v fftw3-common-3.3.4p0
pkg_add -v firewalk-0.8p2
pkg_add -v flock-20110525p1
pkg_add -v fping-3.16
pkg_add -v gd-2.2.5
pkg_add -v gdbm-1.13
pkg_add -v gdk-pixbuf-2.36.10p0
pkg_add -v geolite-country-20170829
pkg_add -v gettext-0.19.8.1p1
pkg_add -v giflib-5.1.4
pkg_add -v glib2-2.52.3
pkg_add -v gmake-4.2.1
pkg_add -v gmp-6.1.2p1
pkg_add -v gnupg-1.4.21p2
pkg_add -v gnupg-2.1.23
pkg_add -v gnutls-3.5.15
pkg_add -v gtk-update-icon-cache-3.22.21p0
pkg_add -v hicolor-icon-theme-0.17
pkg_add -v hping-3.0.0pre1
pkg_add -v http_load-20140814
pkg_add -v ircd-hybrid-8.2.22
pkg_add -v irssi-1.0.4p0-socks
pkg_add -v jasper-1.900.1p5
pkg_add -v jbigkit-2.1
pkg_add -v jpeg-1.5.1p0v0
pkg_add -v lcms2-2.7
pkg_add -v libassuan-2.4.3p0
pkg_add -v libelf-0.8.13p3
pkg_add -v libexecinfo-0.3p0v0
pkg_add -v libffi-3.2.1p2
pkg_add -v libgcrypt-1.8.1
pkg_add -v libgpg-error-1.27p0
pkg_add -v libiconv-1.14p3
pkg_add -v libidn-1.33
pkg_add -v libidn2-2.0.0
pkg_add -v libksba-1.3.5p0
pkg_add -v libltdl-2.4.2p1
pkg_add -v libmilter-8.16.0.21
pkg_add -v libnet-1.0.2ap5v0
pkg_add -v libnettle-3.3p0
pkg_add -v libnids-1.24p0
pkg_add -v libpsl-0.17.0
pkg_add -v libsecret-0.18.5
pkg_add -v libtasn1-4.12
pkg_add -v libunistring-0.9.7
pkg_add -v libusb1-1.0.21
pkg_add -v libwebp-0.5.2
pkg_add -v libxml-2.9.5
pkg_add -v libxslt-1.1.30p0
pkg_add -v libyaml-0.1.7
pkg_add -v links-1.03p0
pkg_add -v lynx-2.8.9pl16
pkg_add -v mailman-2.1.23
pkg_add -v milter-spamd-0.6p3
pkg_add -v nano-2.8.7
pkg_add -v nemesis-1.4p1
pkg_add -v nghttp2-1.26.0
pkg_add -v nginx-1.12.1
pkg_add -v nginx-passenger-1.12.1
pkg_add -v node-6.11.2p0
pkg_add -v npth-1.5
pkg_add -v openjp2-2.2.0
pkg_add -v p11-kit-0.23.2p0
pkg_add -v p5-Crypt-OpenSSL-Bignum-0.08
pkg_add -v p5-Crypt-OpenSSL-RSA-0.28p1
pkg_add -v p5-Crypt-OpenSSL-Random-0.11
pkg_add -v p5-Digest-HMAC-1.03p0
pkg_add -v p5-Encode-Detect-1.01p6
pkg_add -v p5-Encode-Locale-1.05
pkg_add -v p5-Error-0.17024
pkg_add -v p5-File-Listing-6.04
pkg_add -v p5-Geo-IP-1.50p0
pkg_add -v p5-HTML-Parser-3.72
pkg_add -v p5-HTML-Tagset-3.20p1
pkg_add -v p5-HTTP-Cookies-6.04
pkg_add -v p5-HTTP-Daemon-6.01
pkg_add -v p5-HTTP-Date-6.02
pkg_add -v p5-HTTP-Message-6.13
pkg_add -v p5-HTTP-Negotiate-6.01
pkg_add -v p5-IO-HTML-1.001
pkg_add -v p5-IO-Socket-SSL-2.051
pkg_add -v p5-LWP-MediaTypes-6.02
pkg_add -v p5-Mail-DKIM-0.40p0
pkg_add -v p5-Mail-SPF-2.9.0p0
pkg_add -v p5-Mail-SpamAssassin-3.4.1p6
pkg_add -v p5-Mail-Tools-2.14
pkg_add -v p5-Net-CIDR-Lite-0.21
pkg_add -v p5-Net-DNS-1.12
pkg_add -v p5-Net-DNS-Resolver-Programmable-0.003p0
pkg_add -v p5-Net-HTTP-6.17
pkg_add -v p5-Net-Patricia-1.22p0
pkg_add -v p5-Net-SSLeay-1.81p0
pkg_add -v p5-NetAddr-IP-4.079
pkg_add -v p5-Socket6-0.28
pkg_add -v p5-Time-TimeDate-2.30
pkg_add -v p5-URI-1.71
pkg_add -v p5-WWW-RobotRules-6.02
pkg_add -v p5-libwww-6.15
pkg_add -v pcre++-0.9.5p7
pkg_add -v pcre-8.40p1
pkg_add -v pcre2-10.23
pkg_add -v pfstat-2.5p1
pkg_add -v pftop-0.7p16
pkg_add -v pinentry-1.0.0
pkg_add -v png-1.6.31
pkg_add -v postfix-3.3.20170910-sasl2-pgsql
pkg_add -v postgresql-client-9.6.5
pkg_add -v postgresql-server-9.6.5
pkg_add -v py-dnspython-1.15.0
pkg_add -v py-setuptools-28.6.1p0v0
pkg_add -v python-2.7.14
pkg_add -v quirks-2.367
pkg_add -v re2c-0.16p2
pkg_add -v ruby-2.3.5
pkg_add -v ruby23-bundler-1.15.1
pkg_add -v ruby23-passenger-5.0.30p0
pkg_add -v ruby23-rack-1.6.2
pkg_add -v shared-mime-info-1.9
pkg_add -v sqlite3-3.20.1
pkg_add -v sudo-1.8.21.2
pkg_add -v tcl-8.5.19p0
pkg_add -v tiff-4.0.8p1
pkg_add -v unzip-6.0p11
pkg_add -v vmm-firmware-1.10.2p4
pkg_add -v wget-1.19.1
pkg_add -v xz-5.2.3p0

echo "Creating Symlinks";
ln -sf /usr/local/bin/bundle23 /usr/local/bin/bundle
ln -sf /usr/local/bin/bundler23 /usr/local/bin/bundler
ln -sf /usr/local/bin/erb23 /usr/local/bin/erb
ln -sf /usr/local/bin/gem23 /usr/local/bin/gem
ln -sf /usr/local/bin/irb23 /usr/local/bin/irb
ln -sf /usr/local/bin/nokogiri23 /usr/local/bin/nokogiri
ln -sf /usr/local/bin/passenger-config23 /usr/local/bin/passenger-config
ln -sf /usr/local/bin/passenger-install-apache2-module23 /usr/local/bin/passenger-install-apache2-module
ln -sf /usr/local/bin/passenger-install-nginx-module23 /usr/local/bin/passenger-install-nginx-module
ln -sf /usr/local/bin/passenger-memory-stats23 /usr/local/bin/passenger-memory-stats
ln -sf /usr/local/bin/passenger-status23 /usr/local/bin/passenger-status
ln -sf /usr/local/bin/passenger23 /usr/local/bin/passenger
ln -sf /usr/local/bin/puma23 /usr/local/bin/puma
ln -sf /usr/local/bin/pumactl23 /usr/local/bin/pumactl
ln -sf /usr/local/bin/rackup23 /usr/local/bin/rackup
ln -sf /usr/local/bin/rake23 /usr/local/bin/rake
ln -sf /usr/local/bin/rdoc23 /usr/local/bin/rdoc
ln -sf /usr/local/bin/ri23 /usr/local/bin/ri
ln -sf /usr/local/bin/ruby23 /usr/local/bin/ri
ln -sf /usr/local/bin/unicorn23 /usr/local/bin/unicorn
ln -sf /usr/local/bin/unicorn_rails23 /usr/local/bin/unicorn_rails

echo "Copying Custom Kernel";

echo "Starting Copying Configurations";

#hostname myname mygate resolv.conf

echo "Copying OpenSSH conf";
cp conf/sshd_config /etc/ssh

echo "Copying nginx conf";
cp conf/nginx.conf /etc

echo "Copying awstats conf";
cp conf/awstats.reloaded.online /etc/awstats

echo "Copying postfix conf";
cp conf/main.cf /etc/postfix
cp conf/master.cf /etc/postfix
cp conf/pg_virtual_alias_maps.cf /etc/postfix
cp conf/pg_virtual_domains.cf /etc/postfix
cp conf/pg_virtual_mailboxes.cf /etc/postfix
cp conf/smtpd.conf /usr/local/lib/sasl2/

echo "Copying Clamav conf";
cp conf/clamav.conf /etc
cp conf/clamav-milter.conf /etc

echo "Copying postgresql conf";
cp conf/postgresql.conf /var/data/postgresql

echo "Copying courier conf";
cp conf/authdaemond /etc/courier
cp conf/authpgsql /etc/courier

echo "Copying ircd conf";
cp conf/d4xircd.conf /etc/ircd-hybrid

echo "Copying PF Firewall Rules";
cp conf/pf.d4x /etc/pf.conf

echo "Copying rc.conf.local conf";
cp conf/rc.conf.local /etc/rc.conf.local

echo "Copying rc.local conf";
cp conf/rc.local /etc/rc.local

echo "Copying rc.securelevel conf";
cp conf/rc.securelevel /etc/rc.securelevel

echo "Copying SSL Cert and Keys";

echo "Starting Services";
/etc/rc.d/sshd start
/etc/rc.d/postfix start
/etc/rc.d/courier-authdaemond start
/etc/rc.d/courier_imap_ssl start
/etc/rc.d/ircd-hybrid start

echo "Creating Jobs";
cp conf/jobs /root

echo "Adding Jobs to Cron";

echo "Creating Apps folder";
gunzip apps.tar.gz
tar -xf apps.tar -C /var/www/

echo "Creating Mail folder";
useradd -d /var/vmail -g =uid -u 2000 -s /sbin/nologin -c "Mailboxes Owner" -m vmail
gunzip vmail.tar.gz
tar -xf vmail.tar -C /var/www/

echo "Setting Files and Folder Permissions";

echo "Bundle Install";
export RAILS_ENV=production
cd /var/www/apps/reloaded
bundle exec bundle install

echo "Database Migrations";
export RAILS_ENV=production
cd /var/www/apps/reloaded
bundle exec rake db:migrate

echo "DONE";
echo "Ready to Reboot?";