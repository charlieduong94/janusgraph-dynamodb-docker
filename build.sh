#!/bin/bash

set -e
JANUSGRAPH_IMAGE=janusgraph-dynamodb

BUILD_DIR="$(cd $(dirname "$BASH_SOURCE[0]") && pwd)"
BUILDER_IMAGE=${JANUSGRAPH_IMAGE}-builder
BUILDER_DIR=${BUILD_DIR}/${BUILDER_IMAGE}

PUBLISHED_IMAGE_NAME=charlieduong94/janusgraph-dynamodb

pushd ${BUILD_DIR}

# build the janusgraph dynamodb enabled
# (this exports a zip)
pushd ${BUILDER_DIR}
docker build \
  -t ${BUILDER_IMAGE} .

docker run \
  -v ${BUILDER_DIR}:/dist \
  ${BUILDER_IMAGE}
popd

# build the actual image
docker build -t ${JANUSGRAPH_IMAGE} .
docker tag ${JANUSGRAPH_IMAGE} ${PUBLISHED_IMAGE_NAME}

docker tag ${PUBLISHED_IMAGE_NAME}:latest
docker tag ${PUBLISHED_IMAGE_NAME}:${VERSION}
