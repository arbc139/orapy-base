[![Python Version](https://img.shields.io/badge/python-3.6.8-blue)](https://www.python.org/downloads/release/python-368/)
[![Oracle Instant Client Version](https://img.shields.io/badge/oracle--cli-12.2.0.1.0-red)](https://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle12c-linux-12201-3608234.html)

# OraPy-base
Oracle Instant Client & Python base image for SKT-CDR Analyze Process

## How to make a docker image?
Use bash script for building docker image.
```bash
./scripts/build.sh
```

or type these native docker commands for building.
```bash
docker build sktcdr/base:1.0.0 .
```

## How to run docker image to container?
Docker image will be run on background.
```bash
docker-compose up -d
```

Stop docker container by this command.
```bash
docker-compose stop sktcdr
```

Remove docker container by this command.
```bash
docker-compose rm sktcdr
```

## How to access bash on container?
```bash
docker-compose exec sktcdr bash
```

## Image Export / Import Methods
### Image to Tar file
```bash
docker save -o sktcdr_img.tar sktcdr/base:1.0.0
```

### Tar to image (tar file must be created by 'save' command)
```bash
docker load -i sktcdr_img.tar
```

### Container to Tar file
```bash
docker export ${container_ID} > sktcdr_container.tar
```

### Tar to image (tar file must be created by 'export' command)
```bash
docker import sktcdr_container.tar ${image_name}
```
