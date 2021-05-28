# The container with dev environment

The Dockerfile contains configuration of the container with development environment:

- C++20
- Python3
- Conan
- Meson
- Git
- Packages for Yocto build host

### Build image

In `tools/dev_env` use:

`docker build -t autosar-adaptive-yocto .`

### Run container
`docker run -d -t --name <container_name> -v <repository_path>:<workspace_path> autosar-adaptive-yocto`

i.e

`docker run -d -t --name autosar-adaptive-yocto-container -v C:\AUTOSAR-Adaptive:/home/dev/workspace autosar-adaptive-yocto`

### Connect to Container bash console
`docker exec -it autosar-adaptive-yocto-container /bin/bash`

### Credentials 
`dev:dev`