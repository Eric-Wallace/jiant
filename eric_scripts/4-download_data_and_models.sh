#mkdir -p probing_data
#/home/ericwallace/bin/rclone copy -v Eric:finetuning/probing_data/edges/ontonotes/const/ probing_data/edges/ontonotes/const/

mkdir -p models

mkdir -p models/rte
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/rte models/rte
mkdir -p models/sts-b
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/sts-b models/sts-b
mkdir -p models/cola
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/cola models/cola
mkdir -p models/sst
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/sst models/sst
mkdir -p models/mrpc
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/mrpc models/mrpc
mkdir -p models/mnli
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/mnli models/mnli
mkdir -p models/allan-coref
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/allan-coref models/allan-coref
mkdir -p models/agnews
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/agnews models/agnews
mkdir -p models/random-memorization
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/random-memorization models/random-memorization
mkdir -p models/5-way-multiqa
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/5-way-multiqa models/5-way-multiqa
mkdir -p models/hotpot
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/hotpot models/hotpot
mkdir -p models/squad
/home/ericwallace/bin/rclone copy -v Eric:finetuning/models/squad models/squad
