#!/bin/bash
set -ex

export NODE_RANK=${PAI_CURRENT_TASK_ROLE_CURRENT_TASK_INDEX:=0}
split_num=32
node_count=${PAI_TASK_ROLE_TASK_COUNT_worker} # 64
node_rank=$NODE_RANK
blobkey="?sv=2023-01-03&st=2024-11-27T03%3A02%3A36Z&se=2024-12-03T03%3A02%3A00Z&skoid=c275b492-fed2-47ef-8704-1bb10e68fcf2&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2024-11-27T03%3A02%3A36Z&ske=2024-12-03T03%3A02%3A00Z&sks=b&skv=2023-01-03&sr=c&sp=racwdxltf&sig=lNZS14iL13QSIUCLw1Aro%2FNqVZmNBnUg072a2L6AXT4%3D"

./azcopy copy --recursive "https://xinzhanginterns.blob.core.windows.net/jiewu/data/sft_data?sv=2023-01-03&st=2024-11-27T03%3A02%3A36Z&se=2024-12-03T03%3A02%3A00Z&skoid=c275b492-fed2-47ef-8704-1bb10e68fcf2&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2024-11-27T03%3A02%3A36Z&ske=2024-12-03T03%3A02%3A00Z&sks=b&skv=2023-01-03&sr=c&sp=racwdxltf&sig=lNZS14iL13QSIUCLw1Aro%2FNqVZmNBnUg072a2L6AXT4%3D" "/our_data/code_data/data/sft_data"
./azcopy copy --recursive "https://xinzhanginterns.blob.core.windows.net/jiewu/data/output/test/qwen2_5-7b/v0-20241127-184146/checkpoint-7147?sv=2023-01-03&st=2024-11-27T03%3A02%3A36Z&se=2024-12-03T03%3A02%3A00Z&skoid=c275b492-fed2-47ef-8704-1bb10e68fcf2&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2024-11-27T03%3A02%3A36Z&ske=2024-12-03T03%3A02%3A00Z&sks=b&skv=2023-01-03&sr=c&sp=racwdxltf&sig=lNZS14iL13QSIUCLw1Aro%2FNqVZmNBnUg072a2L6AXT4%3D" "/our_data/code_data/data/output/test/qwen2_5-7b/v0-20241127-184146/checkpoint-7147"

# for split_id in $(seq 0 $((split_num-1))); do
#     remainder=$((split_id % node_count))
#     if [ $remainder -eq $node_rank ]; then
#         if [ $split_id -lt 10 ]; then
#             split_id="0"$split_id
#         else
#             split_id=$split_id
#         fi

#         ./azcopy copy --recursive "https://xinzhanginterns.blob.core.windows.net/jiewu/data?sv=2023-01-03&st=2024-11-27T03%3A02%3A36Z&se=2024-12-03T03%3A02%3A00Z&skoid=c275b492-fed2-47ef-8704-1bb10e68fcf2&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2024-11-27T03%3A02%3A36Z&ske=2024-12-03T03%3A02%3A00Z&sks=b&skv=2023-01-03&sr=c&sp=racwdxltf&sig=lNZS14iL13QSIUCLw1Aro%2FNqVZmNBnUg072a2L6AXT4%3D" "/our_data/code_data"
        
#         # ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/finewebedu-100BT-split64/split_"$split_id"/"$blobkey "/our_data/text_data"

#     fi
# done

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/thestackv2/tokenized_data/"$blobkey "/our_data/code_data"

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/starcoderdata_code_related_text/"$blobkey "/our_data"

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/proof-pile-2/"$blobkey "/our_data"
