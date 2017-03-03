# docker-mediaelch

Container for MediaElch (http://www.kvibes.de/mediaelch/)

Run MediaElch over SSH with X11 Forwarding !

Exported Volumes 

## Usage
Containerizd MediaElch and allow remote accesss through SSH with X11 Forwarding.

SSH user : mediaelch
SSH password : *disabled*, use Key authentication (see below to provide authorized_keys)

Run MediaElch : MediaElch

## Parameters
* `-p 22` - the port(s)
* `-v /home/mediaelch/.config/kvibes` - where MediaElch should store config files.
* `-v /home/mediaelch/.ssh/authorized_keys` - where SSH Authorized Keys are stored
* `-v /movies` - your movies folder
* `-v /shows` - your tv-shows folder
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

### User / Group Identifiers
You can specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user.
