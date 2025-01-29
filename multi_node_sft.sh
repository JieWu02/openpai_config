#!/bin/bash
export TORCH_NCCL_BLOCKING_WAIT=1
export TORCH_NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_TIMEOUT=2000
export NCCL_P2P_DISABLE=0
export NCCL_IB_DISABLE=0
export NCCL_IB_TIMEOUT=100
export NCCL_IB_HCA=mlx5
export NCCL_IB_TC=106
export NCCL_IB_QPS_PER_CONNECTION=4
export NCCL_IB_GID_INDEX=3
export NCCL_NET_GDR_READ=1
export NCCL_CROSS_NIC=1
export NCCL_CONNECT_RETRY_COUNT=5
export NCCL_IB_CUDA_SUPPORT=1

CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
NNODES=4 \
NODE_RANK=$NODE_RANK \
MASTER_ADDR=$MASTER_ADDR \
MASTER_PORT=$MASTER_PORT \
NPROC_PER_NODE=8 \
swift sft \
    --dataset /our_data/code_data/data/sft_data/instruct_dataset.json \
             /our_data/code_data/data/sft_data/chat_dataset.json \
             /our_data/code_data/data/sft_data/SFT_data.json \
    --num_train_epochs 1 \
    --model Qwen/Qwen2.5-7B \
    --train_type lora \
    --output_dir sft_output_from_base \
    --lazy_tokenize true \
    --torch_dtype bfloat16 \
    --max_length 2048 \
    --per_device_train_batch_size 8 \
    --dataloader_num_workers 8 \
    --lora_rank 32 \
    --lora_alpha 64 \
    --lora_dropout 0.05 \
    --weight_decay 0.1 \
    --learning_rate 1e-4 \
    --gradient_accumulation_steps 4 \
    --max_grad_norm 1.0 \
    --warmup_ratio 0.03 \
    --eval_steps 500 \
    --save_steps 500 \
    --save_total_limit 2 \
    --logging_steps 10 \
    --lr_scheduler_type cosine \
    --gradient_checkpointing true \
    --ddp_backend nccl \
    --attn_impl flash_attn 
