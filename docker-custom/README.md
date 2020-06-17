# Build your own Docker image

The docker-custom directory contains files you need to build your own images.

The follow steps describe in short which steps to take to build your own images.

## 1. git clone this fork

Clone the Node-RED Docker project from github
```shell script
git clone  https://github.com/PaulWieland/node-red-docker.git
```

Change dir to docker-custom
```shell script
cd node-red-docker/docker-custom
```

## Download nwrfc
Download & Save the nwrfc750P_4-70002752.zip file into the docker-custom directory (same dir as docker-make.sh)

Instructions for getting nwrfc installed are here: http://sap.github.io/node-rfc/install.html#sap-nw-rfc-library-installation



## 3. **Run docker-make.sh**

Run `docker-make.sh`

```shell script
$ ./docker-make.sh
```

This starts building your custom image and might take a while depending on the system you are running on.

When building is done you can run the custom image by the following command:

```shell script
$ docker run -it -p1880:1880 pwieland/saprfc-node-red
```

With the following command you can verify your docker image:

```shell script
$ docker inspect pwieland/saprfc-node-red
```