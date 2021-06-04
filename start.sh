#!/bin/bash


# 检查config配置文件，并创建
if [ ! -e "/config/qBittorrent/config/qBittorrent.conf" ] ;  then 
mkdir -p /config/qBittorrent/config/
cp /usr/local/qbittorrent/defaults/qBittorrent.conf  /config/qBittorrent/config/qBittorrent.conf
fi

# permissions
chown 0777 -R /config \
    /downloads

git clone https://github.com/wwpry/qbittorrent_heroku
mkdir /upload/
mv /qbittorrent_heroku/upload/* /upload/
chmod 0777 /qbittorrent_heroku/upload/ -R
rm -rf /qbittorrent_heroku


nohup yes "" | qbittorrent-nox --webui-port=$PORT  --profile=/config  &
python3 /qbittorrent_heroku/upload/config.py
python3 /qbittorrent_heroku/upload/dingshi.py
