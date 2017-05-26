# Containerized TeamSpeak3 Server

The main goal of this repository is to provide a simple yet extensible way to start up a TeamSpeak3 server. The Docker image is using the latest version of TeamSeak3 Server (3.0.13.6).

## How to use this container?

There are two really simply ways to use the container, first is recommended for either development or try-out use cases.

### Using docker-compose

Check out the repository than `cd` into the directory containing the checked out code. In the directory simply issue a `docker-compose up -d` command. This will fire up two docker containers first is a `mariadb` the second one is the `ts3` server itself.

The command above will fire up the containers in the background using the `-d` flag. To check what's going on simply type in `docker-compose logs -f ts3`. Please note that it is expected that the `ts3` container restarts couple times. This is because the `mariadb` container needs some time to bootstrap itself.

### Using the Ts3 container only

Check out the repository than `cd`into the `docker/` directory containing the checked out code. Inside the directory issue a `docker build .` command so the docker daemon on your machine can build the image. After the build is done docker will report the image's unique id, take note of that than to start up the container issue a `docker up -it --rm <image id>`.

The above will start the container in _default_ mode and it will use SQLite as it's database, if you want to use MariaDB _(or MySQL)_ than read the configuration section below.

### Configuring the Ts3 container

The image can be used with SQLite database - default -, or MariaDB by supplying some environment
variables. The following variables are available:

 - `TS3_DB_HOST`: To indicate to use MariaDB and the Host of the MariaDB instance e.g. `localhost`
 - `TS3_DB_PORT`: To explicitly set database port. Default __3306__
 - `TS3_DB_USER`: __Required__ if `TS3_DB_HOST` is set. The user to connect to the database e.g. `ts3`
 - `TS3_DB_PASS`: To provide the password for the database user optional default to empty
 - `TS3_DB_NAME`: To what database name to use optional default to `ts3`
 - `TS_USER`: To set the Linux user running the TeamSpeak3 server instance __inside__ the container. Normally you'd not want to modify this. Default to _ts3_
 - `TS_VERSION`: To which version of TeamSpeak server to use. __NOTE:__ You have to supply your own binaries if you want to override this. Default to _3.0.16.6_
