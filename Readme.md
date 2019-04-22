# Lightweight apline based docker image for Rclone

## Usage

### Running rclone
To run rclone via docker use:
```
docker run --rm cminor/rclone
```

### Configuring rclone
Rclone reads a configuration file in `/root/.config/rclone/rclone.conf` that contains the definitions
for the remotes.

#### Using an existing rclone.conf file
If you already have a configuration file, just volume-mount it to the docker image. Example:
```
docker run -v rclone.conf:/root/.config/rclone/rclone.conf --rm cminor/rclone
```

#### To create a new configuration file (and also save it locally to be reused later)
```
touch rclone.conf
docker run -v $(pwd)/rclone.conf:/root/.config/rclone/rclone.conf --rm cminor/rclone config
```
Note that absolute path is always needed (hence the $(pwd) for a conf file residing in current directory)

### Copying a file to a remote
Assuming you have configured a remote in your `rclone.conf` file, copying files from a folder with files `/tmp/data` means you need to volume mount it so that rclone container is aware of it. Then you can run (if for example you have a remote named gdrive):
```
docker run \
    -v $(pwd)/rclone.conf:/root/.config/rclone/rclone.conf \
    -v /tmp/data:/tmp/data \
    --rm cminor/rclone \
    copy /tmp/data gdrive:EventLobsterBackups/data
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

