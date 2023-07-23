#!/bin/bash
torchrun --nproc_per_node 1 interactive_chat.py --ckpt_dir /home/ai/models/data/llama-2-7b-chat/ --tokenizer_path /home/ai/models/data/tokenizer.model --max_seq_len 512 --max_batch_size 4