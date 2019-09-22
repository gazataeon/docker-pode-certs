FROM mcr.microsoft.com/powershell:7.0.0-preview.4-centos-7  

RUN yum install git -y
RUN yum install nano -y
RUN yum install openssl -y

RUN cd /usr ; git clone https://github.com/Badgerati/Pode.git
RUN cd /usr/Pode ; git checkout pode-listener

COPY ./web-sockets.ps1 /usr/web-sockets.ps1
COPY ./entrypoint.sh /entrypoint.sh 

RUN chmod +x /entrypoint.sh

EXPOSE 9001
CMD [ "/entrypoint.sh" ] 