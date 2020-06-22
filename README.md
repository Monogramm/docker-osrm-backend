[![License: AGPL v3][uri_license_image]][uri_license]
[![Docs](https://img.shields.io/badge/Docs-Github%20Pages-blue)](https://monogramm.github.io/osrm-backend/)
[![Build Status](https://travis-ci.org/Monogramm/docker-osrm-backend.svg)](https://travis-ci.org/Monogramm/docker-osrm-backend)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-osrm-backend.svg)](https://hub.docker.com/r/monogramm/docker-osrm-backend/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-osrm-backend.svg)](https://hub.docker.com/r/monogramm/docker-osrm-backend/)
[![Docker Version](https://images.microbadger.com/badges/version/monogramm/docker-osrm-backend.svg)](https://microbadger.com/images/monogramm/docker-osrm-backend)
[![Docker Size](https://images.microbadger.com/badges/image/monogramm/docker-osrm-backend.svg)](https://microbadger.com/images/monogramm/docker-osrm-backend)
[![GitHub stars](https://img.shields.io/github/stars/Monogramm/docker-osrm-backend?style=social)](https://github.com/Monogramm/docker-osrm-backend)

# **OSRM Backend** Docker image

Docker image for **OSRM Backend**.

:construction: **This image is still in development!**

## What is **OSRM Backend**

Open Source Routing Machine.

> [**OSRM Backend**](http://project-osrm.org/)

## Supported tags

[Dockerhub monogramm/docker-osrm-backend](https://hub.docker.com/r/monogramm/docker-osrm-backend/)

-   `latest`
-   `5.22`
-   `5.21`
-   `5.20`

## How to run this image

This image provides an OSRM Manager in the form of the Docker entrypoint.
It manages map downloads from Geofabrik and OSRM extraction/pre-processing/routing based on environment variables.

```shell
## mld or ch or corech
OSRM_ALGORITHM=mld

OSRM_THREADS=2

OSRM_PORT=5000

## Extraction profile
OSRM_PROFILE=/opt/car.lua

## OSRM map name
OSRM_MAP_NAME=berlin-latest

## Geofabrik relative path to download map
OSRM_GEOFABRIK_PATH=europe/germany/berlin-latest.osm.pbf
```

See **OSRM Backend** base image documentation for more details.

> [**OSRM Backend** GitHub](https://github.com/Project-OSRM/osrm-backend)

> [**OSRM Backend** DockerHub](https://hub.docker.com/r/Project-OSRM/docker-osrm-backend-base/)

## Questions / Issues

If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-osrm-backend) and write an issue.


[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg
