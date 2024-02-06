#!/bin/bash

nvidia-docker run -it --gpus all \
 --env="DISPLAY=$DISPLAY" \
 --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
 --volume="$HOME/.ssh:/home/user/.ssh:ro" \
 --name sara_shield_panda_container \
 manuelvogel12/sara_shield_panda:latest \
 x-terminal-emulator
