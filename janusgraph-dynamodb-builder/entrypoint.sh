#!/bin/bash

set -e

git clone https://github.com/awslabs/dynamodb-janusgraph-storage-backend
cd dynamodb-janusgraph-storage-backend

# move to specified version
git checkout 85c69ba1ad2387ee24c6cc6ea20d73122a3ffaec

./src/test/resources/install-gremlin-server.sh

mv ./server/dynamodb-janusgraph-storage-backend-1.1.1.zip /dist
