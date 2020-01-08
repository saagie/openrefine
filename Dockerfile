FROM openjdk:8-jre-stretch

RUN apt-get update && apt-get install -y curl jq tar

WORKDIR /app

ENV OPENREFINE_VERSION 3.2
ENV OPENREFINE_FILE openrefine-linux-${OPENREFINE_VERSION}.tar.gz

RUN curl -O -L https://github.com/OpenRefine/OpenRefine/releases/download/$OPENREFINE_VERSION/$OPENREFINE_FILE
RUN tar xzf ${OPENREFINE_FILE} --strip 1

COPY refine /app

VOLUME /data
WORKDIR /data

RUN sed -i 's:CLASSPATH="\$REFINE_CLASSES_DIR\${SEP}\$REFINE_LIB_DIR\/\*":add_option "-Drefine.context_path=/totoq"\nCLASSPATH="\$REFINE_CLASSES_DIR\${SEP}\$REFINE_LIB_DIR\/\*":g' /app/refine

EXPOSE 3333

ADD entrypoint.sh /entrypoint.sh
RUN chmod 744 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
