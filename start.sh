#!/bin/bash

# Check Workdir exists prior to running
if [ ! -d "./workdir" ]; then
  mkdir workdir
fi

docker run -ti --rm --device /dev/ttyUSB0:/dev/ttyUSB0 -v /home/farran/dev/docker-esp-idf/workdir:/workdir espdev
