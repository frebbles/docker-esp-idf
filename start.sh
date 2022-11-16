#!/bin/bash

# Check Workdir exists prior to running
if [ ! -d "./workdir" ]; then
  mkdir workdir
fi

if [ -e "/dev/ttyUSB0" ]; then
docker run -ti --rm --device /dev/ttyUSB0:/dev/ttyUSB0 -v /home/frebs/dev/docker-esp-idf/workdir:/workdir espdev
else
docker run -ti --rm -v /home/frebs/dev/docker-esp-idf/workdir:/workdir espdev
fi
