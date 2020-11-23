FROM library/alpine:20200917
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
    geth@testing=7.16.1-r2 \
    ca-certificates=20191127-r5

# App user
ARG APP_UID=1371
ARG APP_USER="geth"
RUN sed -i "s|$APP_USER:x:[0-9]\+:|$APP_USER:x:$APP_UID:|" "/etc/group" && \
    sed -i "s|$APP_USER:x:[0-9]\+:[0-9]\+|$APP_USER:x:$APP_UID:$APP_UID|" "/etc/passwd"

# Volumes
ARG DATA_DIR="/geth-data"
RUN mkdir "$DATA_DIR" && \
    chown "$APP_USER":"$APP_USER" "$DATA_DIR"
VOLUME ["$DATA_DIR"]

#      RPC
EXPOSE 31416/tcp

USER "$APP_USER"
WORKDIR "$DATA_DIR"
ENTRYPOINT ["geth"]