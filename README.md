# Go Ethereum
Simple to set up Go Ethereum client.

## Running the server
```bash
docker run --detach --name geth hetsh/geth
```

## Stopping the container
```bash
docker stop geth
```

## Configuring
The Go Ethereum client can be configured via [gethmgr](https://geth.berkeley.edu/wiki/Go Ethereum_Manager) or [gethcmd](https://geth.berkeley.edu/wiki/gethcmd_tool).
Remote connections require addition parameter:
```bash
docker run ... hetsh/geth --allow_remote_gui_rpc
```

## Creating persistent storage
```bash
STORAGE="/path/to/storage"
mkdir -p "$STORAGE"
chown -R 1371:1371 "$STORAGE"
```
`1371` is the numerical id of the user running the server (see Dockerfile).
The user must have RW access to the storage directory.
Start the server with the additional mount flags:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/geth-data ...
```

## Time
Synchronizing the timezones will display the correct time in the logs.
The timezone can be shared with this mount flag:
```bash
docker run --mount type=bind,source=/etc/localtime,target=/etc/localtime,readonly ...
```

## Automate startup and shutdown via systemd
The systemd unit can be found in my GitHub [repository](https://github.com/Hetsh/docker-geth).
```bash
systemctl enable geth --now
```
By default, the systemd service assumes `/apps/geth-data` for storage and `/etc/localtime` for timezone.
Since this is a personal systemd unit file, you might need to adjust some parameters to suit your setup.

## Fork Me!
This is an open project hosted on [GitHub](https://github.com/Hetsh/docker-geth).
Please feel free to ask questions, file an issue or contribute to it.