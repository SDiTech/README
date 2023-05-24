# Docker

General use and docker images.

### Use

```bash

# docker image, container, volume, and network commands

# SECTION: Images
# install or update an image
docker image pull ubuntu:latest
# show currently available images
docker image ls
# delete an image
docker rmi image_name:tag | container_id ;

# SECTION: Containers
# list ALL containers
docker container ls -a
# stop running container
docker container stop container_name | container_id;
# remove all inactive containers
docker container prune

# SECTION: Volumes
# list volumes
docker volume ls
# delete volume
docker volume rm volume_name
# prune volumes | unlearn to do this
docker volume prune

# SECTION: Networks
docker network ls
docker network create network_name
docker network prune

# SECTION: Use
# launch the container running the stated /bin/sh program
docker run -it image_name:tag /bin/sh

# launch a program against a currently running container instance
docker exec -it container_name /bin/sh

# launch a container with docker example
docker run  \
    -p 8080:80  \   # assign ports
    -v "$(pwd)"/data:/var/lib/data  \ # assign volumes
    --rm   \ # remove container on exit
    -it    \ # interactive + tty
    -h hostname  \   # set container hostname 
    --name containername  \  # set container name
    imagename:tag /bin/sh        

# SECTION: Docker Compose
# launch all services defined in ./docker-compose.yml with the following options:
#   -d                  detach from currently running terminal
#   --build             build the containers (relevant only for instances using a Dockerfile)
#   --force-recreate    recreate the containers even if they exist
#   --remove-orphans    remove any orphaned containers which may have been previously defined in the docker-compose.yml file
docker compose up -d --build --force-recreate --remove-orphans

# stop services
docker compose down

```

### Additional

#### BASE IMAGES
- alpine
- ubuntu

#### SERVERS
- nginx
- httpd

#### DEVELOPMENT
- mcr.microsoft.com/dotnet/sdk
- mcr.microsoft.com/dotnet/aspnet
- python
- node:lts-alpine
- rabbitmq:management-alpine
- wordpress
- ghcr.io/requarks/wiki

#### TESTING
- rnwood/smtp4dev

#### STORAGE

__relational__
- mariadb
- mysql
- postgres

__nosql__
- redis/redis-stack
- redis/redis-stack-server

#### DATABASE VIEWERS
- phpmyadmin
- adminer
- dpage/pgadmin4

#### REPORTS
- bitnami/reportserver
- bitnami/jasperreports
