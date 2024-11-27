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
export NCCL_IB_CUDA_SUPPORT=1

CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 \
NNODES=4 \
NODE_RANK=$NODE_RANK \
MASTER_ADDR=$MASTER_ADDR \
MASTER_PORT=$MASTER_PORT \
NPROC_PER_NODE=8 \
swift pt \
    --model_type qwen2_5-7b \
    --model_id_or_path /our_data/code_data/data/model/Qwen2.5-7B \
    --dataset /our_data/code_data/data/filter_data.json,/our_data/code_data/data/data_1.json,/our_data/code_data/data/data_2.json,/our_data/code_data/data/data_3.json,/our_data/code_data/data/data_4.json,/our_data/code_data/data/data_5.json,/our_data/code_data/data/data_6.json,/our_data/code_data/data/data_7.json,/our_data/code_data/data/data_8.json \
    --num_train_epochs 1 \
    --sft_type full \
    --output_dir test \
    --lazy_tokenize true \
    --dataset_test_ratio 0.01 \
    --template_type AUTO \
    --dtype bf16 \
    --max_length 2048 \
    --check_dataset_strategy none \
    --batch_size 8 \
    --dataloader_num_workers 8 \
    --weight_decay 0.1 \
    --learning_rate 3e-5 \
    --gradient_accumulation_steps 4 \
    --train_dataset_sample -1 \
    --max_grad_norm 1.0 \
    --warmup_ratio 0.03 \
    --eval_steps 1000 \
    --save_steps 1000 \
    --save_total_limit 4 \
    --logging_steps 10 \
    --lr_scheduler_type cosine \
    --gradient_checkpointing true \
    --ddp_backend nccl \
    --use_flash_attn true \
    --deepspeed default-zero2
