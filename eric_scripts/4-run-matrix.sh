source activate jiant
source user_config_template.sh

declare -a ALL_TASKS
# ALL_TASKS+=( "spr1" )
# ALL_TASKS+=( "spr2" )
# ALL_TASKS+=( "dpr" )
# ALL_TASKS+=( "dep-ud-ewt" )
# ALL_TASKS+=( "nonterminal-ontonotes" )
# ALL_TASKS+=( "pos-ontonotes" )
# ALL_TASKS+=( "ner-ontonotes" )
ALL_TASKS+=( "srl-ontonotes" )
# ALL_TASKS+=( "coref-ontonotes" )
# ALL_TASKS+=( "rel-semeval" )
echo "All tasks to run: ${ALL_TASKS[@]}"

declare -a ALL_MODELS
ALL_MODELS+=( "None" ) # bert has pretrained_dir to None
ALL_MODELS+=( "RANDOM" )
ALL_MODELS+=( "RANDOM_WITH_GOOD_EMBEDDINGS" )
ALL_MODELS+=( "models/MNLI" )
#ALL_MODELS+=( "coreference" )
#ALL_MODELS+=( "sst" )

declare -a All_LAYERS
All_LAYERS+=( "cat" )
All_LAYERS+=( "only" )
All_LAYERS+=( "mix" )
All_LAYERS+=( "top" )

CURRENT_RUNNING_JOBS=0
AVAILABLE_CUDA_DEVICES=(0) # 1 3 4 5)
for task in "${ALL_TASKS[@]}"
do
	for model in "${ALL_MODELS[@]}"
	do			
		for i in "${!All_LAYERS[@]}"	
		do				
			export CUDA_VISIBLE_DEVICE=${AVAILABLE_CUDA_DEVICES[$CURRENT_RUNNING_JOBS]}			
			CURRENT_RUNNING_JOBS=$((CURRENT_RUNNING_JOBS + 1))			
			CURRENT_RUNNING_JOBS=$(($CURRENT_RUNNING_JOBS%${#AVAILABLE_CUDA_DEVICES[@]}))
			python main.py --config_file jiant/config/edgeprobe/edgeprobe_bert.conf -o "target_tasks=edges-$task,exp_name=experiments/$task-$model-${All_LAYERS[$i]},input_module=bert-base-uncased,pytorch_transformers_output_mode=${All_LAYERS[$i]},pretrained_dir=$model" &						
			if [ $CURRENT_RUNNING_JOBS == 0 ]
			then								
				wait			
				echo "WAITING"	
			fi
		done
		wait
	done
done
