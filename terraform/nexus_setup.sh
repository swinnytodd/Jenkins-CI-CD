#!/bin/bash

# Установка Java
yum install -y java-1.8.0-openjdk

# Создание директорий
mkdir -p /opt/nexus /data/nexus 

# Скачивание Nexus 
NEXUS_URL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUS_URL -O /tmp/nexus.tar.gz

# Распаковка
tar xzf /tmp/nexus.tar.gz -C /opt/nexus --strip-components=1
rm -f /tmp/nexus.tar.gz

# Пользователь Nexus
useradd nexus -d /opt/nexus
chown -R nexus:nexus /opt/nexus /data/nexus

# Конфигурация
echo "nexus.scripts.allowCreation=true" >> /opt/nexus/etc/nexus.properties
echo "nexus.data=/data/nexus" >> /opt/nexus/etc/nexus.properties

# Сервис Systemd
cat <<EOF > /etc/systemd/system/nexus.service
[Unit]
Description=Nexus service
After=network.target

[Service] 
Type=forking
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable nexus

# Запуск и проверка
sudo -u nexus /opt/nexus/bin/nexus start
sleep 30
curl http://localhost:8081/ 

if [ $? -eq 0 ]; then
  echo "Nexus was installed and started successfully"
else
  echo "Nexus start failed" >&2
  exit 1
fi