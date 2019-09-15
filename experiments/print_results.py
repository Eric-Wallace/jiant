from tabulate import tabulate
import os
results = []
for file in os.listdir("."):
    if not file.endswith('.py'):
        probing_task = ' '.join(str(file).split('-')[0:-2])
        finetuned_model = ' '.join(str(file).split('-')[-2:-1])
        print(probing_task)
        print(finetuned_model)
        layer = ' '.join(str(file).split('-')[-1:])
        accuracy = "-"
        for line in reversed(list(open(file + '/run/log.log'))):
            if 'Best result seen so far for macro_avg' in line:
                print(line) 
                accuracy = float(line.strip().split(' ')[-1])
                print(accuracy)
                print()
                break

        results.append([finetuned_model, layer, probing_task, accuracy])

results = sorted(results, key=lambda x: (x[2], x[1], x[0]))

returnVal = {}
for item in results:    
    finetuned_model, layer, probing_task, accuracy = item
    if (finetuned_model, layer) not in returnVal:        
        returnVal[(finetuned_model, layer)] = ["_","_","_","_","_"]
    if probing_task == "dep ud ewt":
        returnVal[(finetuned_model, layer)][0] = str(accuracy)
    elif probing_task == "srl ontonotes":
        returnVal[(finetuned_model, layer)][1] = str(accuracy)
    elif probing_task == "ner ontonotes":
        returnVal[(finetuned_model, layer)][2] = str(accuracy)
    elif probing_task == "rel semeval":
        returnVal[(finetuned_model, layer)][3] = str(accuracy)

printResults = []
for key in returnVal:
    temp = []
    temp.append(str(key[0]))    
    temp.append(str(key[1]))    
    temp.extend(returnVal[key])
    printResults.append(temp)

print(tabulate(printResults,headers=['Finetuning Task', 'Layer', 'Dependency', 'SRL', "NER",'Rel Semeval','_'], tablefmt='orgtbl'))

