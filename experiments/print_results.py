from tabulate import tabulate
import os

rc_tasks = ['hotpot','squad','multiqa']
token_tasks = ['coref']
classification_tasks = ['sst','sts','memorization']
pair_tasks = ['rte','mrpc','mnli']

results = []
for file in os.listdir("."):
    if not file.endswith('.py'):
        probing_task = ' '.join(str(file).split('-')[0:-2])
        finetuned_model = ' '.join(str(file).split('-')[-2:-1])
        layer = ' '.join(str(file).split('-')[-1:])
        accuracy = "-"
        for line in reversed(list(open(file + '/run/log.log'))):
            if 'Best result seen so far for macro_avg' in line:
                accuracy = float(line.strip().split(' ')[-1])
                break

        if finetuned_model in rc_tasks:
            finetuned_model = "RC: " + finetuned_model
        elif finetuned_model in token_tasks:
            finetuned_model = "TOKEN: " + finetuned_model
        elif finetuned_model in classification_tasks:
            finetuned_model = "CLASSIFICATION: " + finetuned_model
        elif finetuned_model in pair_tasks:
            finetuned_model = "PAIR: " + finetuned_model
        else:
            finetuned_model = "OTHER: " + finetuned_model

        results.append([finetuned_model, layer, probing_task, accuracy])

results.append(["z","cat", " ", " "])
results.append(["z","only", " ", " "])
results.append(["z","mix", " ", " "])

results = sorted(results, key=lambda x: (x[1], x[0]))

returnVal = {}
for item in results:    
    finetuned_model, layer, probing_task, accuracy = item
    if finetuned_model == "z":
        returnVal[(" ", layer)] = [" "," "," "," "," "," ", " "]
        returnVal[("  ", layer)] = [" "," "," "," "," "," "," "]
        continue
    if (finetuned_model, layer) not in returnVal:        
        returnVal[(finetuned_model, layer)] = ["-","-","-","-","-","-","-"]
    if probing_task == "dep ud ewt":
        returnVal[(finetuned_model, layer)][0] = str(accuracy)
    elif probing_task == "srl ontonotes":
        returnVal[(finetuned_model, layer)][1] = str(accuracy)
    elif probing_task == "ner ontonotes":
        returnVal[(finetuned_model, layer)][2] = str(accuracy)
    elif probing_task == "rel semeval":
        returnVal[(finetuned_model, layer)][3] = str(accuracy)
    elif probing_task == "pos ontonotes":
        returnVal[(finetuned_model, layer)][4] = str(accuracy)
    elif probing_task == "spr2":
        returnVal[(finetuned_model, layer)][5] = str(accuracy)
    elif probing_task == "coref ontonotes":
        returnVal[(finetuned_model, layer)][6] = str(accuracy)
 
printResults = []
for key in returnVal:
    temp = []        
    temp.append(str(key[0]))   
    temp.append(str(key[1]))    
    temp.extend(returnVal[key])
    printResults.append(temp)

print(tabulate(printResults,headers=['Finetuning Task', 'Layer', 'Dependency', 'SRL', "NER",'Rel Semeval','POS', 'SPR2', "Coref"], tablefmt='orgtbl'))

