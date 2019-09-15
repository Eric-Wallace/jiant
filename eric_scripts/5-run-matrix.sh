source activate jiant
source user_config_template.sh

declare -a ALL_TASKS
# ALL_TASKS+=( "spr1" )
# ALL_TASKS+=( "spr2" )
# ALL_TASKS+=( "dpr" )
# ALL_TASKS+=( "nonterminal-ontonotes" )
ALL_TASKS+=( "dep-ud-ewt" )
ALL_TASKS+=( "pos-ontonotes" )
ALL_TASKS+=( "ner-ontonotes" )
ALL_TASKS+=( "srl-ontonotes" )
ALL_TASKS+=( "coref-ontonotes" )
ALL_TASKS+=( "rel-semeval" )
echo "All tasks to run: ${ALL_TASKS[@]}"

declare -a ALL_MODELS
ALL_MODELS+=( "None" ) # bert has pretrained_dir to None
ALL_MODELS+=( "RANDOM" )
ALL_MODELS+=( "RANDOM_WITH_GOOD_EMBEDDINGS" )

ALL_MODELS+=( "rte" )
ALL_MODELS+=( "sts" )
ALL_MODELS+=( "cola" )
ALL_MODELS+=( "sst" )
ALL_MODELS+=( "mrpc" )
ALL_MODELS+=( "mnli" )
ALL_MODELS+=( "coref" )
ALL_MODELS+=( "agnews" )
ALL_MODELS+=( "memorization" )
ALL_MODELS+=( "multiqa" )
ALL_MODELS+=( "hotpot" )
ALL_MODELS+=( "squad" )


declare -a All_LAYERS
All_LAYERS+=( "cat" )
All_LAYERS+=( "only" )
All_LAYERS+=( "top" )
All_LAYERS+=( "mix" )

CURRENT_RUNNING_JOBS=0
AVAILABLE_CUDA_DEVICES=(0 1 2 3 4 5 6 7)
for task in "${ALL_TASKS[@]}"
do
	for model in "${ALL_MODELS[@]}"
	do			
		for i in "${!All_LAYERS[@]}"	
		do			
			if [ -d "experiments/$task-$model-${All_LAYERS[$i]}" ]
			then  # directory exists, skip task
				echo "experiment already completed"
  				continue
			else 			
				echo "starting job"	
				export CUDA_VISIBLE_DEVICES=${AVAILABLE_CUDA_DEVICES[$CURRENT_RUNNING_JOBS]}	
				CURRENT_RUNNING_JOBS=$((CURRENT_RUNNING_JOBS + 1))			
				CURRENT_RUNNING_JOBS=$(($CURRENT_RUNNING_JOBS%${#AVAILABLE_CUDA_DEVICES[@]}))			
				python main.py --config_file jiant/config/edgeprobe/edgeprobe_bert.conf -o "target_tasks=edges-$task,exp_name=experiments/$task-$model-${All_LAYERS[$i]},input_module=bert-base-uncased,pytorch_transformers_output_mode=${All_LAYERS[$i]},pretrained_dir=models/$model" &						

				if [ $CURRENT_RUNNING_JOBS == 0 ]
				then								
					echo "WAITING"	
					wait		
	            fi	
            fi
		done
	done
done

