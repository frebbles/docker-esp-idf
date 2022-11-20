#!/bin/bash

CDIR=`pwd`

# Check Workdir exists prior to running
if [ ! -d "./workdir" ]; then
  mkdir workdir
fi

if [ -e "/dev/ttyUSB0" ]; then
docker run -ti --rm --device /dev/ttyUSB0:/dev/ttyUSB0 -v $CDIR/workdir:/workdir espdev
else
docker run -ti --rm -v $CDIR/workdir:/workdir espdev
fi
