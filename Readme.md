# Lightweight apline based docker image for Rclone

Rclone : Rsync for cloud storage

For more info visit https://rclone.org/

This is a lightweight docker image in order to allow running rclone via docker.

## Why Rclone

In short: time saving.
I had a typical use case: upload regular server backups from some servers to a cloud storage for redundancy. For those that have tried Google Drive as storage, you might be familiar with the painful authentication process, app verification that takes weeks, libraries that are severly outdated (nodejs doesn't include promises, even though they are indeed implemented, the documented examples still use callback hell) and so on. Rclone is a feature-rich open source tool that supports *many* cloud storage providers and works right out of the box.

## Usage

### Running rclone
To run rclone via docker use:
```
docker run --rm cminor/rclone
```

### Configuring rclone
Rclone needs a configuration file at `/root/.config/rclone/rclone.conf` that contains the definitions
for the remotes (ie configuration for the cloud storage providers along with their credentials).

#### Using an existing rclone.conf file
If you already have a configuration file, you need to volume-mount its parent folder to the docker image, so that the container is aware of it. It is important to mount the parent folder (and by extension to have the conf file in a folder) because `Rclone` will try to backup the conf file and update it, when it needs to update the access tokens.
Example:
```
docker run \
    -v $(pwd)/rclone:/root/.config/rclone \
    --rm cminor/rclone
```

#### To create a new configuration file (and also save it locally to be reused later)

This command will guide you through filling the information needed to configure any of the supported remotes.

```
mkdir rclone
touch rclone/rclone.conf
docker run \
    -v $(pwd)/rclone:/root/.config/rclone \
    --rm cminor/rclone config
```

### Copying a file to a remote storage provider
For this example we will assume you already have gone through the configuration process as described above, and as a result you have a `rclone/rclone.conf` file which contains the configuration of a remote, lets say `gdrive`.

If you want to copy a file `test.txt` from a folder called `/tmp/data` to your Gdrive folder `Data`
then you need to volume mount the folder to the container so that the container is aware of it, and then just copy it:
```
docker run \
    -v $(pwd)/rclone:/root/.config/rclone \
    -v /tmp/data:/data \
    --rm cminor/rclone \
    copy /data/test.txt gdrive:Data
```

## To extend this image
In your dockerfile:
```
FROM cminor/rclone
# your stuff goes below
```

## Build
To build the image run the following command:
```
make build
```