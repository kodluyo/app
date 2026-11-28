sudo apt update
sudo apt install curl unzip -y
sudo curl -L -o app.zip https://github.com/kodluyo/app/archive/refs/heads/master.zip
sudo unzip app.zip
sudo mv app-main/ /app
sudo rm app.zip
sudo chmod +x /app/install/*
sudo chmod +x /app/build
sudo chmod +x /app/run
sudo /app/install/php
sudo /app/install/mariadb
sudo /app/install/nodejs 24.11.1
sudo /app/install/golang 1.20
sudo /app/install/certbot
