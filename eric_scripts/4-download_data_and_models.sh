RCLONE_DIR=~/bin/rclone

#mkdir -p probing_data
#$RCLONE_DIR copy -v Eric:finetuning/probing_data/edges/ontonotes/const/ probing_data/edges/ontonotes/const/

mkdir -p models

mkdir -p models/rte
$RCLONE_DIR copy -v Eric:finetuning/models/rte models/rte
mkdir -p models/sts
$RCLONE_DIR copy -v Eric:finetuning/models/sts-b models/sts
#mkdir -p models/cola   # uses BERT-large right now
$RCLONE_DIR copy -v Eric:finetuning/models/cola models/cola
mkdir -p models/sst
$RCLONE_DIR copy -v Eric:finetuning/models/sst models/sst
mkdir -p models/mrpc
$RCLONE_DIR copy -v Eric:finetuning/models/mrpc models/mrpc
mkdir -p models/mnli
$RCLONE_DIR copy -v Eric:finetuning/models/mnli models/mnli
mkdir -p models/coref
$RCLONE_DIR copy -v Eric:finetuning/models/allan-coref models/coref
#mkdir -p models/agnews # in AllenNLP, need to extract pytorch-transformers part
#$RCLONE_DIR copy -v Eric:finetuning/models/agnews models/agnews
mkdir -p models/memorization
$RCLONE_DIR copy -v Eric:finetuning/models/random-memorization models/memorization
mkdir -p models/multiqa
$RCLONE_DIR copy -v Eric:finetuning/models/5-way-multiqa models/multiqa
mkdir -p models/hotpot
$RCLONE_DIR copy -v Eric:finetuning/models/hotpot models/hotpot
mkdir -p models/squad
$RCLONE_DIR copy -v Eric:finetuning/models/squad models/squad

