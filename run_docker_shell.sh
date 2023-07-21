#!/bin/bash

docker run \
-it \
--gpus=all \
--rm \
--ipc=host \
--privileged \
--name llama2-container \
-v llama2:/home/ai/models \
-v ${PWD}:/home/ai/llama \
llama2 \
bash