#!/bin/bash

docker create --rm --name llama2-temp -v llama2:/home/ai/models llama2 bash
docker cp ${PWD}/data llama2-temp:/home/ai/models
docker container rm llama2-temp