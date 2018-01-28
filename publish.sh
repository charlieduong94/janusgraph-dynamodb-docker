#!/bin/bash

set -e

IMAGE_NAME=charlieduong94/janusgraph-dynamodb

docker push ${IMAGE_NAME}
