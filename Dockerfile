FROM cdue/nginx-subs-filter:latest

RUN mkdir -p /usr/share/man/man1/
RUN apt-get update && apt-get install -y curl jq tar procps default-jdk vim

WORKDIR /app

ENV OPENREFINE_VERSION 3.2
ENV OPENREFINE_FILE openrefine-linux-${OPENREFINE_VERSION}.tar.gz

RUN curl -O -L https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINE_VERSION/$OPENREFINE_FILE
RUN tar xzf ${OPENREFINE_FILE} --strip 1

COPY refine /app

VOLUME /data
WORKDIR /data

RUN sed -i '1iload_module modules/ngx_http_subs_filter_module.so;' /etc/nginx/nginx.conf
COPY server.conf /etc/nginx/conf.d/openrefine.conf
RUN rm /etc/nginx/conf.d/default.conf

#ENTRYPOINT ["/app/refine","-m", "2048m"]
#CMD ["-i", "0.0.0.0", "-d", "/data"]

ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
