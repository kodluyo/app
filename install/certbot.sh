#!/bin/bash


sh /app/lib/message.sh light "CERTBOT SSL"
#------------------------------------------------
apt update
apt install certbot -y
#------------------------------------------------

if command -v certbot >/dev/null 2>&1 && certbot --version >/dev/null 2>&1; then
    sh /app/lib/message.sh success "Certbot kuruldu ve çalışıyor"
else
    sh /app/lib/message.sh alert "Certbot kurulamadı veya çalışmıyor"
    exit 1
fi

####################   Kullanım   #######################
# certbot certonly --standalone --preferred-challenges http -d yourdomain.com --register-unsafely-without-email
# /etc/letsencrypt/live/yourdomain.com/ -> içine dosyalar yüklenir
# cert.pem
# privkey.pem
#########################################################
