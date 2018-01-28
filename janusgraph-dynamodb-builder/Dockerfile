# this image generates the zipped plugin from the
# dynamodb-janusgraph-storage-backend repo

FROM openjdk:8-jdk-slim

COPY entrypoint.sh /

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install \
    git \
    zip \
    maven \
    wget \
    gpg \
    gpg-agent

ENTRYPOINT [ "bash" ]
CMD [ "/entrypoint.sh" ]
