#!/bin/sh

set -e

PUID=${PUID:-20000}
PGID=${PGID:-20000}

groupmod -o -g "$PGID" mediaelch
usermod -o -u "$PUID" mediaelch

chown mediaelch:mediaelch /home/mediaelch
chown mediaelch:mediaelch /home/mediaelch/.*

exec "$@"
