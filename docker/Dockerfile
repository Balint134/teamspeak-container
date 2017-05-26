FROM ubuntu:16.04
LABEL maintainer "SwankyPantie"
WORKDIR /opt/teamspeak3-server

EXPOSE 9987
EXPOSE 10011
EXPOSE 30033

ENV TS_VERSION 3.0.13.6
ENV TS_USER ts3

ADD teamspeak3-server_${TS_VERSION}.tar.bz2 ./
RUN ln -s teamspeak3-server_linux_amd64 etc

WORKDIR etc
COPY start.sh start.sh
RUN groupadd -r $TS_USER && useradd -r -g $TS_USER $TS_USER
RUN chown -R -f $TS_USER:$TS_USER . && chmod u+x *.sh

USER $TS_USER
ENTRYPOINT ./start.sh
