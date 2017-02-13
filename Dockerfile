#############################################
# Dockerfile to deploy a Rust server
# Based on Ubuntu
#############################################

FROM ubuntu
MAINTAINER tcarrio
EXPOSE 28015
EXPOSE 28016
RUN  dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux tmux lib32gcc1 libstdc++6 libstdc++6:i386 -y
ENV SRVNAME "Rusty Docker"
ENV SRVPASS "RstSrvDef@ultPass"
ENV NUMPLAYERS 25
RUN useradd -u 1257 -m -p ${SRVPASS} rustserver
#RUN su - rustserver
USER 1257
WORKDIR /home/rustserver/ 
RUN wget https://gameservermanagers.com/dl/rustserver
RUN chmod +x ~/rustserver
RUN sed -i -e 's/CHANGE_ME/${SRVPASS}/' -e 's/servername=\"Rust\"/servername=\"${SRVNAME}\"/' rustserver
RUN ~/rustserver auto-install
RUN ~/rustserver start
