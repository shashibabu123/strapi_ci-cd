#!/bin/bash
apt update -y
apt install -y docker.io
systemctl start docker
systemctl enable docker
docker pull shashikumar025/strapi-app
docker run -d -p 1337:1337 --name strapi-app shashikumar025/strapi-app

