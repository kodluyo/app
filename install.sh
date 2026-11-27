sudo apt update
sudo apt install curl unzip -y
sudo curl -L -o app.zip https://github.com/kodluyo/app/archive/refs/heads/master.zip
sudo unzip app.zip
sudo mv app-main/ /app
sudo rm app.zip
sudo chmod +x /app/install/*
sudo sh /app/install/php
sudo sh /app/install/mariadb
sudo sh /app/install/nodejs 24.11.1
sudo sh /app/install/golang 1.20
# sudo sh /app/install/certbot
