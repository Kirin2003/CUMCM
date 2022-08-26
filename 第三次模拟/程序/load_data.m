x_training = readmatrix('/home/hxq/Desktop/2022spring/mathmatical_modeling/problem2.xlsx','Sheet','Sheet1','Range','D2:W1975');

IC50_nM_training = readmatrix('/home/hxq/Desktop/2022spring/mathmatical_modeling/problem2.xlsx','Sheet','Sheet1','Range','B2:B1975');

pIC50_training =  readmatrix('/home/hxq/Desktop/2022spring/mathmatical_modeling/problem2.xlsx','Sheet','Sheet1','Range','C2:C1975');

x_test = readmatrix('/home/hxq/Desktop/2022spring/mathmatical_modeling/test_predicate.xlsx','Sheet','Sheet1','Range','B2:U51');

admet_training = readmatrix('/home/hxq/Desktop/2022spring/mathmatical_modeling/数学建模国赛/第三次模拟/实验/ADMET_training.xlsx','Sheet','Sheet1','Range','B2:ABG1975');
