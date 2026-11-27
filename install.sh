sudo apt update
sudo apt install curl unzip -y
sudo curl -L -o app.zip https://github.com/kodluyo/app/archive/refs/heads/master.zip
sudo unzip app.zip
sudo mv app-main/ /app
sudo rm app.zip
sudo sh /app/install/php.sh
sudo sh /app/install/golang.sh 1.20
