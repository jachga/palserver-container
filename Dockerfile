FROM docker.io/cm2network/steamcmd:latest

# environment variables for both the Dockerfile and the entry script
ENV STEAMCMD="${HOMEDIR}/steamcmd/steamcmd.sh"
ENV STEAMAPPID=2394010
ENV STEAMAPP="palserver"
ENV STEAMAPPDIR="/game"
ENV GAMEPORT=8211

RUN set -x \
	mkdir -p ${STEAMAPPDIR} && \
	mkdir -p ~/.steam/sdk64/ && \
	${STEAMCMD} +login anonymous +app_update 1007 +quit && \
	cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/

VOLUME ["${STEAMAPPDIR}"]

EXPOSE ${GAMEPORT}/TCP
EXPOSE ${GAMEPORT}/UDP

CMD \
	${STEAMCMD} +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update ${STEAMAPPID} validate +quit && \
	chmod +x ${STEAMAPPDIR}/PalServer.sh && \
	${STEAMAPPDIR}/PalServer.sh
