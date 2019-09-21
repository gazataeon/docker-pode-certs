#!/bin/bash

cd /usr/Pode/examples/certs ; openssl genrsa -des3 -passout pass:podeRocksSocks -out docker_pass.key 2048 
openssl rsa -passin pass:podeRocksSocks -in docker_pass.key -out docker.key 
openssl req -new -key docker.key -out docker.csr -subj "/C=UK/ST=Warrington/L=Birchwood/O=PODE/OU=Devops/CN=pode.com" 
openssl x509 -req -days 365 -in docker.csr -signkey docker.key -out docker.crt
openssl pkcs12 -export -out docker.pfx -inkey docker.key -passout pass:podeRocksSocks -in docker.crt


pwsh -c "cd /usr/Pode/examples/certs; ../web-sockets.ps1"