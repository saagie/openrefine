FROM java:8-jre-alpine

ENV OPENREFINE_VERSION 3.3-beta
ENV OPENREFINE_FILE openrefine-linux-${OPENREFINE_VERSION}.tar.gz

WORKDIR /app

COPY ${OPENREFINE_FILE} /app

RUN set -xe && apk --update add bash curl jq tar

RUN tar xzf ${OPENREFINE_FILE} --strip 1

COPY refine /app

VOLUME /data
WORKDIR /data

# Nginx
#RUN apk update \
#  && apk add nginx 	
#  && apk clean \
#  && rm -rf /var/lib/apt/lists/

RUN apk update && apk add nginx netcat	
RUN mkdir -p /run/nginx

COPY server.conf /etc/nginx/sites-enabled/openrefine.conf

#RUN rm /etc/nginx/sites-enabled/default

EXPOSE 3333

#ENTRYPOINT ["/app/refine","-m", "2048m"]
#CMD ["-i", "0.0.0.0", "-d", "/data"]

ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
