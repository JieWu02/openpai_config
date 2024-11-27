#!/bin/bash
# 设置NCCL参数
export NCCL_BLOCKING_WAIT=1
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_TIMEOUT=100

# 使用swift内置的分布式训练支持
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
NNODES=2 \
NODE_RANK=$NODE_RANK \
MASTER_ADDR=$MASTER_ADDR \
MASTER_PORT=$MASTER_PORT \
NPROC_PER_NODE=8 \
swift pt \
    --model_type qwen2_5-7b \
    --dataset /our_data/code_data/data/filter_data.json \
    --num_train_epochs 1 \
    --sft_type full \
    --output_dir test \
    --lazy_tokenize true \
    --dataset_test_ratio 0.001 \
    --template_type AUTO \
    --dtype bf16 \
    --max_length 2048 \
    --check_dataset_strategy warning \
    --batch_size 8 \
    --weight_decay 0.1 \
    --learning_rate 3e-5 \
    --gradient_accumulation_steps 16 \
    --train_dataset_sample 30000 \
    --max_grad_norm 1.0 \
    --warmup_ratio 0.03 \
    --eval_steps 2000 \
    --save_steps 2000 \
    --save_total_limit 2 \
    --logging_steps 2 \
    --lr_scheduler_type cosine \
    --gradient_checkpointing true \
    --ddp_backend nccl \
    --use_flash_attn true \
    --deepspeed default-zero2
