# Docker Setup and Usage Guide

## Prerequisites
- You need the **Docker client** installed on your system.

## Setup
1. Create directories for data persistence:

```bash
mkdir -p /home/$(users)/data/wordpress
mkdir -p /home/$(users)/data/mariadb
```
2. Edit the /etc/hosts file and add the following line:
```
127.0.0.1   mzouine.42.fr
```

## Makefile Usage
- Setup containers: make
- Stop containers: make clean

## Docker Compose Commands

### Build and start containers in detached mode:
```docker compose up --build -d```

### Stop and remove containers::
```docker compose down```

### Check running containers:
```docker ps```

### Access a container's bash shell:
```docker exec -it <container_name> bash```

### List Docker networks:
```docker network ls```

### List Docker volumes:
```docker volume ls```

### List Docker images:
```docker images```

### Clean up Docker system:
```docker system prune -a```
- ⚠️ Warning: This command deletes:
- All stopped containers
- All unused networks
- All dangling images (old layers with no name)
- All Build cache
- -a flag additionally deletes all unused images.