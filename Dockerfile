FROM debian:9-slim
LABEL maintainer="BamButz \"bambutz@cryptonica.de\""

# Expose Ports
EXPOSE 22005/udp
EXPOSE 22006

# ------------------------
# Setup
# ------------------------

RUN apt update && \
    apt install wget gcc libunwind8 icu-devtools curl libssl-dev -y && \
    wget -O /tmp/server.tar.gz https://cdn.rage.mp/lin/ragemp-srv-037.tar.gz && \
	tar -xzf /tmp/server.tar.gz -C /tmp && \
	mkdir /serverfiles && \
	mv /tmp/ragemp-srv/server /serverfiles/server && \
	mv /tmp/ragemp-srv/bt.dat /serverfiles/bt.dat && \
	chmod +x /serverfiles/server && \
	wget -O /tmp/linux-bridge.tar.gz https://cdn.rage.mp/lin/bridge-linux-037.tar.gz && \
	tar -xzf /tmp/linux-bridge.tar.gz -C /serverfiles && \
	mkdir /ragemp

ADD entrypoint.sh /home/entrypoint.sh
ADD conf.json /serverfiles/conf.json

VOLUME /ragemp

ENTRYPOINT ["sh", "/home/entrypoint.sh"]