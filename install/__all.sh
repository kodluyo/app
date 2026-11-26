apt update
apt install curl unzip
curl -L -o app.zip https://github.com/kodluyo/app/archive/refs/heads/master.zip
unzip app.zip
mv app-main/ /app
rm app.zip
