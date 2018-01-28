FROM openjdk:8-jre

ENV SERVER=dynamodb-janusgraph-storage-backend-1.1.1
ENV SERVER_ZIP=${SERVER}.zip
COPY ./janusgraph-dynamodb-builder/${SERVER_ZIP} /

RUN apt-get update -y && \
  apt-get install -y zip && \
  unzip ${SERVER_ZIP} && \
  rm ${SERVER_ZIP} && \
  mv ${SERVER} janusgraph-dynamodb

WORKDIR /janusgraph-dynamodb

COPY ./conf/dynamodb-local.properties ./conf/gremlin-server/

ENTRYPOINT [ "./bin/gremlin-server.sh" ]
CMD [ "./conf/gremlin-server/gremlin-server.yaml" ]
