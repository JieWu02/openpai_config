export NCCL_BLOCKING_WAIT=1
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_TIMEOUT=20
NPROC_PER_NODE=8 \
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7,8 \
swift pt \
    --model_type qwen2_5-7b \
    --dataset data/filter_data.json \
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
    --learning_rate 5e-5 \
    --gradient_accumulation_steps 16 \
    --train_dataset_sample 100000 \
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
    --deepspeed default-zero2 \
#    --streaming true \
#    --max_steps 7000
#--dataset filter_data.json,data_1.json,data_2.json,data_3.json,data_4.json,data_5.json,data_6.json,data_7.json,data_8.json \
