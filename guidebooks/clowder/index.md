

# Clone the CodeFlare-Clowder Template Extractors

The CodeFlare-Clowder Template Extractors are a set of extractors that can be used to extract metadata from a variety of file types. The extractors are written in Python and are designed to be run in the Clowder environment. The extractors are available on GitHub at [CodeFlare-Extractors](https://github.com/clowder-framework/CodeFlare-Extractors).

<!-- ```shell
git clone git@github.com:clowder-framework/CodeFlare-Extractors.git
``` -->

```shell
cd /Users/kastanday/code/ncsa/clowder
```

## Add the CodeFlare-Extractors to the Clowder Environment
Adding to Docker compose extractors.

```shell
echo """
  imgextractor:
    image: img-extractor:latest
    restart: unless-stopped
    networks:
      - clowder
    depends_on:
      - rabbitmq
      - clowder
    environment:
      - RABBITMQ_URI=${RABBITMQ_URI:-amqp://guest:guest@rabbitmq/%2F}
""" >> /Users/kastanday/code/ncsa/clowder/docker-compose.extractors.yml
```

## Starting Clowder with a template extractor
You may need to enter your sudo password for Docker.

```shell
sudo docker-compose -f docker-compose.yml -f docker-compose.extractors.yml up -d
```