#!/usr/bin/env bash
set -e



sh /app/lib/message.sh light "PHP 8.5.X"

apt update
apt install -y lsb-release ca-certificates curl

# Debian ise Sury PHP deposunu ekleyin; Ubuntu ise Ondrej PPA kullanin.
if grep -qi "debian" /etc/os-release; then
  curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
  dpkg -i /tmp/debsuryorg-archive-keyring.deb
  rm -f /tmp/debsuryorg-archive-keyring.deb
  tee /etc/apt/sources.list.d/php.sources >/dev/null <<EOF
Types: deb
URIs: https://packages.sury.org/php/
Suites: $(lsb_release -sc)
Components: main
Signed-By: /usr/share/keyrings/debsuryorg-archive-keyring.gpg
EOF
elif grep -qi "ubuntu" /etc/os-release; then
  apt install -y software-properties-common
  LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
fi

apt update

# Install PHP 8.5 and extensions.
apt install -y php8.5 php8.5-cli php8.5-fpm php8.5-curl php8.5-mbstring php8.5-xml php8.5-zip php8.5-mysql php8.5-gd


if command -v php >/dev/null 2>&1 && php -v >/dev/null 2>&1 && php -r 'echo "OK";' >/dev/null 2>&1; then
    PHP_VER="$(php -v | head -n 1)"
    echo "Mevcut Sürüm: ${PHP_VER}"
    sh /app/lib/message.sh success "PHP kuruldu ve çalışıyor (${PHP_VER})"
else
    sh /app/lib/message.sh alert "PHP kurulamadı veya çalışmıyor"
    exit 1
fi


echo "[.] Kısayol oluşturuluyor -> /app/php "
ln -sf  /usr/local/bin/php /app/php
