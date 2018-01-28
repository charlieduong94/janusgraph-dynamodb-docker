# janusgraph-dynamodb-docker

This project builds a [Janusgraph](https://janusgraph.org) docker image
that is configured to use [DynamoDB](https://aws.amazon.com/dynamodb/)
as a storage backend.

The building and packaging of the Janusgraph server is done
[here](https://github.com/awslabs/dynamodb-janusgraph-storage-backend).
This project simply takes the result of the build and
makes it more accessible.

**NOTE:** I have not tried to deploy this into ECS yet.

## Building the image

Just run the `build.sh` script build the docker image.

```sh
./build.sh
```

## Usage

Add `dynamodb-local` and `janusgraph-dynamodb` to a docker-compose file.
Make sure that `./conf/gremlin-server/gremlin-server-local.yaml`
is passed in as a command for Janusgraph.

```yaml
version: '3'

services:
  dynamodb:
    image: cnadiminti/dynamodb-local
    healthcheck:
      test: [ 'CMD-SHELL', 'curl -f http://localhost:8000/shell/ || exit 1' ]
      interval: 1s
      timeout: 10s
      retries: 3
    ports:
      - 8000:8000
  janusgraph:
    image: charlieduong94/janusgraph-dynamodb
    command:
      - ./conf/gremlin-server/gremlin-server-local.yaml
    ports:
      - 8182:8182
    depends_on:
      - dynamodb
```

Next, run start up the containers.

```sh
docker-compose up -d
```

Find the container id of `janusgraph-dynamodb` using `docker ps` and
use it to invoke the Gremlin console.

```sh
docker exec -it <container id or name goes here> ./bin/gremlin.sh
```

Once you have access to the console, configure it to connect to the server.

```
:remote connect tinkerpop.server conf/remote.yaml
```

Then start the remote console.

```
:remote console
```
