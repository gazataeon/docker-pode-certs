#!/bin/bash

cd /usr/Pode/examples/certs ; openssl genrsa -des3 -passout pass:podeRocksSocks -out docker_pass.key 2048 
openssl rsa -passin pass:podeRocksSocks -in docker_pass.key -out docker.key 
openssl req -new -key docker.key -out docker.csr -subj "/C=UK/ST=Warrington/L=Birchwood/O=PODE/OU=Devops/CN=pode.com" 
openssl x509 -req -days 365 -in docker.csr -signkey docker.key -out docker.crt
openssl pkcs12 -export -out docker.pfx -inkey docker.key -passout pass:podeRocksSocks -in docker.crt

if [ -z "$podebranch" ]
then
echo "No Branch passed, defaulting to develop"
podebranch="develop"
fi

cd /usr/Pode/
git checkout $podebranch
git pull
cp /usr/web-sockets.ps1 /usr/Pode/examples/web-sockets.ps1


if [ -z "$examplefile" ]
then
echo "No examplefile passed, defaulting to web-sockets.ps1"
examplefile="web-sockets.ps1"
fi

pwsh -c "cd /usr/Pode/examples; ./$examplefile"