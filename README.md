*This project has been created as part of the 42 curriculum by mzouine.*

# Inception

## Description
Inception is a System Administration project that aims to deepen the understanding of Docker and containerization. The goal is to set up a small infrastructure composed of different services (NGINX, WordPress, MariaDB).

Unlike standard usage where ready-made images are pulled from DockerHub, this project requires building custom Docker images for each service from the penultimate stable version of Debian. The infrastructure emphasizes security, isolation, and best practices, including the use of TLS v1.2/1.3, strict network isolation, and volume management.

#### 1. Virtual Machines vs Docker
| Feature | Virtual Machine (VM) | Docker (Container) |
| :--- | :--- | :--- |
| **Architecture** | Virtualizes hardware. Runs a full OS kernel per instance (Hypervisor layer). | Virtualizes the OS. Shares the host kernel (Docker Engine layer). |
| **Size** | Heavy (Gigabytes). Includes a full guest OS, binaries, and libraries. | Lightweight (Megabytes). Includes only the application and its dependencies. |
| **Performance** | Slower boot times (minutes) and higher resource overhead. | Instant boot times (seconds) and near-native performance. |
| **Isolation** | Complete isolation (hardware level). Generally considered more secure by default. | Process-level isolation (namespaces & cgroups). Efficient but shares the kernel surface. |
| **Portability** | Snapshots are large and can be cumbersome to migrate. | Images are portable and ensure consistency across development and production. |

*In the context of this project, Docker allows us to orchestrate three distinct services (NGINX, WordPress, MariaDB) on a single machine with minimal resource usage. Running three separate Virtual Machines for this stack would require three separate kernels and OS instances, wasting significant RAM and CPU resources.*

#### 2. Secrets vs Environment Variables
| Feature | Environment Variables (`.env`) | Docker Secrets |
| :--- | :--- | :--- |
| **Storage Location** | Stored as plain text in configuration files or the process environment. | Stored securely. In Swarm mode, they are encrypted on disk/network. In Compose, they are mounted as files. |
| **Visibility** | Highly visible. Can be seen by running `docker inspect`, `printenv`, or viewing logs if the app crashes. | Hidden from the host. Only accessible to the specific service that needs it via a mounted file (usually in `/run/secrets/`). |
| **Usage** | Best for non-sensitive configuration (e.g., Domain Name, Debug Mode, Paths). | Best for sensitive data (e.g., Database Passwords, API Keys, SSL Certificates). |
| **Security Risk** | High. If the repository is committed to Git without `.gitignore`, secrets are leaked instantly. | Low. They do not sit in environment variables and are harder to accidentally expose in logs. |

*In this project, we use a `.env` file for ease of configuration. But of course we don't push it in our github repository!*

#### 3. Docker Network vs Host Network
Docker **bridge networking** provides network isolation by placing containers on a private virtual network and exposing services through explicit port mappings, making it safer and more flexible for running multiple containers and typical applications. **Host networking** removes this isolation by allowing a container to share the host’s network directly, eliminating port mapping and reducing network overhead, but at the cost of security, portability, and the ability to run multiple services on the same ports.

#### 4. Docker Volumes vs Bind Mounts
Docker **volumes** are managed by Docker and stored in a dedicated location on the host, offering better portability, performance, and safety for persistent data, especially in production environments. **Bind mounts**, on the other hand, map a specific file or directory from the host into a container, giving direct access to the host filesystem, which is convenient for development and live file editing but easier to misconfigure.

## Instructions
* To build the containers:		make
* To shut the containers down:	make clean
* To restart the containers:	make re

### Host Setup
Before running the project, map the domain name to your local loopback address.
Open `/etc/hosts` and add:
```
127.0.0.1   mzouine.42.fr
```
Create the Wordpress directory in your host machine:

```mkdir -p /home/mzouine/data/wordpress```

Create the Mariadb directory in your host machine:

```mkdir -p /home/mzouine/data/mariadb```

## Ressources
* Official Docker documentation: https://docs.docker.com
* Docker: https://youtu.be/eGz9DS-aIeY?si=dpbcjmWltFUi9fHB
* Docker compose: https://youtu.be/DM65_JyGxCo?si=pshp9fBKgO-CkbCG
* Docker networking: https://youtu.be/bKFMS5C4CG0?si=JKUpZnhkxjDN4ipL
* Containers: cgroups, Linux kernel namespaces...: https://youtu.be/el7768BNUPw?si=rVsvcpcYG4zcCUMQ

#### AI was used to generate the initial structure of the project and provided guidance throughout its development.