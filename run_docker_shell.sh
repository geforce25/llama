#!/bin/bash

docker run -it --gpus=all --rm --ipc=host --privileged --name llama2-container -v llama2:/home/ai/models llama2 bash