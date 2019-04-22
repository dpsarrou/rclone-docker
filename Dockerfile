FROM alpine:latest as rclone
RUN apk add --no-cache wget unzip
WORKDIR /rclone
ARG RCLONE_VERSION="current"
ARG RCLONE_ARCH="amd64"
RUN wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 unzip rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 mv rclone-*-linux-${RCLONE_ARCH}/rclone /rclone/rclone

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=rclone /rclone/rclone /usr/bin
WORKDIR /root
ENTRYPOINT [ "rclone" ]