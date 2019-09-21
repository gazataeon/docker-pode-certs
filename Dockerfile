FROM mcr.microsoft.com/powershell:7.0.0-preview.4-centos-7  

RUN yum install git -y
RUN yum install nano -y
RUN cd /usr ; git clone https://github.com/Badgerati/Pode.git
RUN cd /usr ; cd Pode ; git checkout pode-listener
COPY ./web-sockets.ps1 /usr/Pode/examples/web-sockets.ps1
COPY ./entrypoint.sh /usr/Pode/examples/certs/entrypoint.sh 
RUN chmod +x /usr/Pode/examples/certs/entrypoint.sh
RUN yum install openssl -y

EXPOSE 9001
CMD [ "/usr/Pode/examples/certs/entrypoint.sh" ] 