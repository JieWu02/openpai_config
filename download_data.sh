#!/bin/bash
set -ex

export NODE_RANK=${PAI_CURRENT_TASK_ROLE_CURRENT_TASK_INDEX:=0}
split_num=32
node_count=${PAI_TASK_ROLE_TASK_COUNT_worker} # 64
node_rank=$NODE_RANK
blobkey="?sv=2023-01-03&st=2024-11-17T04%3A56%3A53Z&se=2024-11-24T04%3A56%3A00Z&skoid=177064d6-da5f-4cf7-81f4-85009546e549&sktid=72f988bf-86f1-41af-91ab-2d7cd011db47&skt=2024-11-17T04%3A56%3A53Z&ske=2024-11-24T04%3A56%3A00Z&sks=b&skv=2023-01-03&sr=c&sp=racwdxltf&sig=2%2Fqq1JwQkemwGaC2jQkChxwnT%2FoDyGokA4ecQMVyX7A%3D"

for split_id in $(seq 0 $((split_num-1))); do
    remainder=$((split_id % node_count))
    if [ $remainder -eq $node_rank ]; then
        if [ $split_id -lt 10 ]; then
            split_id="0"$split_id
        else
            split_id=$split_id
        fi

        ./azcopy copy --recursive "https://xinzhanginterns.blob.core.windows.net/haoling/thestackv2/2filter_repolevel/tokenized/splited/split_"$split_id"/*"$blobkey "/our_data/code_data"
        
        # ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/finewebedu-100BT-split64/split_"$split_id"/"$blobkey "/our_data/text_data"

        # ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/split64/starcoderdata_code_related_text-split64/split_"$split_id"/"$blobkey "/our_data/starcoderdata_code_related_text"

    fi
done

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/thestackv2/tokenized_data/"$blobkey "/our_data/code_data"

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/starcoderdata_code_related_text/"$blobkey "/our_data"

# ./azcopy copy --recursive "https://openpaidata.blob.core.windows.net/data/haoling/code_pretrain/data/tokenized/proof-pile-2/"$blobkey "/our_data"
