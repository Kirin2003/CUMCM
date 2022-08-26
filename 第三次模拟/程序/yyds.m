%% I. 清空环境变量
clear;
clc;
%warning off

%% II. 导入数据
load admet_training.mat
matrix=admet_training(:,6:734);
Caco_2=admet_training(:,1);
% CYP3A4 = admet_training(:,2);
% hERG = admet_training(:,3);
% HOB = admet_training(:,4);
% MN = admet_training(:,5);
%%
% 1. 随机产生训练集和测试集
n1 = randperm(494);
n2 = randperm(494);
n3 = randperm(493);
n4 = randperm(493);
%%
% 2. 训练集——346*4=1384（1974）个样本
P_train1 = matrix(n1(1:346),:);
P_train2 = matrix(494+n2(1:346),:);
P_train3 = matrix(494*2+n3(1:346),:);
P_train4 = matrix(494*2+493+n4(1:346),:);
P_train = [P_train1;P_train2;P_train3;P_train4];
T_train1 = Caco_2(n1(1:346),:);
T_train2 = Caco_2(494+n2(1:346),:);
T_train3 = Caco_2(494*2+n3(1:346),:);
T_train4 = Caco_2(494*2+493+n4(1:346),:);
T_train = [T_train1;T_train2;T_train3;T_train4];
%%
% 3. 测试集——2040（6800）个样本
P_test1 = matrix(n1(347:end),:);
P_test2 = matrix(494+n2(347:end),:);
P_test3 = matrix(494*2+n3(347:end),:);
P_test4 = matrix(494*2+493+n4(347:end),:);
P_test = [P_test1;P_test2;P_test3;P_test4];
T_test1 = Caco_2(n1(347:end),:);
T_test2 = Caco_2(494+n2(347:end),:);
T_test3 = Caco_2(494*2+n3(347:end),:);
T_test4 = Caco_2(494*2+493+n4(347:end),:);
T_test = [T_test1;T_test2;T_test3;T_test4];

%% III. 创建随机森林分类器
model = classRF_train(P_train,T_train);

%% IV. 仿真测试
[T_sim,votes] = classRF_predict(P_test,model);

%% V. 结果分析
count_1 = length(find(T_train == 1));
count_2 = length(find(T_train == 2));
count_3 = length(find(T_train == 3));
count_4 = length(find(T_train == 4));

total_1 = length(find(admet_training(:,7) == 1));
total_2 = length(find(admet_training(:,7) == 2));
total_3 = length(find(admet_training(:,7) == 3));
total_4 = length(find(admet_training(:,7) == 4));

number_1 = length(find(T_test == 1));
number_2 = length(find(T_test == 2));
number_3 = length(find(T_test == 3));
number_4 = length(find(T_test == 4));

number_1_sim = length(find(T_sim == 1 & T_test == 1));
number_2_sim = length(find(T_sim == 2 & T_test == 2));
number_3_sim = length(find(T_sim == 3 & T_test == 3));
number_4_sim = length(find(T_sim == 4 & T_test == 4));

disp(['总数：' num2str(6800)...
      '  类别1：' num2str(total_1)...
      '  类别2：' num2str(total_2)...
      '  类别3：' num2str(total_3)...
      '  类别4：' num2str(total_4)]);
disp(['训练集总数：' num2str(4760)...
      '  类别1：' num2str(count_1)...
      '  类别2：' num2str(count_2)...
      '  类别3：' num2str(count_3)...
      '  类别4：' num2str(count_4)]);
disp(['测试集总数：' num2str(2040)...
      '  类别1：' num2str(number_1)...
      '  类别2：' num2str(number_2)...
      '  类别3：' num2str(number_3)...
      '  类别4：' num2str(number_4)]);
disp(['类别1判别——' ...
      '  测试集总数：' num2str(number_1)...
      '  正确判别：' num2str(number_1_sim)...
      '  错误判别：' num2str(number_1 - number_1_sim)...
      '  正确率p1=' num2str(number_1_sim/number_1*100) '%']);
disp(['类别2判别——' ...
      '  测试集总数：' num2str(number_2)...
      '  正确判别：' num2str(number_2_sim)...
      '  错误判别：' num2str(number_2 - number_2_sim)...
      '  正确率p2=' num2str(number_2_sim/number_2*100) '%']);
disp(['类别3判别——' ...
      '  测试集总数：' num2str(number_3)...
      '  正确判别：' num2str(number_3_sim)...
      '  错误判别：' num2str(number_3 - number_3_sim)...
      '  正确率p3=' num2str(number_3_sim/number_3*100) '%']);
disp(['类别4判别——' ...
      '  测试集总数：' num2str(number_4)...
      '  正确判别：' num2str(number_4_sim)...
      '  错误判别：' num2str(number_4 - number_4_sim)...
      '  正确率p4=' num2str(number_4_sim/number_4*100) '%']);
disp(['总判别——' ...
      '  测试集总数：' num2str(2040)...
      '  正确判别：' num2str(number_1_sim+number_2_sim+number_3_sim+number_4_sim)...
      '  错误判别：' num2str(2040-(number_1_sim+number_2_sim+number_3_sim+number_4_sim))...
      '  正确率p4=' num2str((number_1_sim+number_2_sim+number_3_sim+number_4_sim)/2040*100) '%']);
  
%% VI. 绘图
figure

index = find(T_sim ~= T_test);
plot(votes(index,1),votes(index,2),'r*')
hold on

index = find(T_sim == T_test);
plot(votes(index,1),votes(index,2),'bo')
hold on

legend('错误分类样本','正确分类样本')

plot(0:500,500:-1:0,'r-.')
hold on

plot(0:500,0:500,'r-.')
hold on

line([100 400 400 100 100],[100 100 400 400 100])

xlabel('输出为类别1的决策树棵数')
ylabel('输出为类别2的决策树棵数')
title('随机森林分类器性能分析')


%% VII. 随机森林中决策树棵数对性能的影响
Accuracy = zeros(1,20);
for i = 50:50:1000
    i
    %每种情况，运行100次，取平均值
    accuracy = zeros(1,100);
    for k = 1:100
        % 创建随机森林
        model = classRF_train(P_train,T_train,i);
        % 仿真测试
        T_sim = classRF_predict(P_test,model);
        accuracy(k) = length(find(T_sim == T_test)) / length(T_test);
    end
     Accuracy(i/50) = mean(accuracy);
end

%%
% 1. 绘图
figure
plot(50:50:1000,Accuracy)
xlabel('随机森林中决策树棵数')
ylabel('分类正确率')
title('随机森林中决策树棵数对性能的影响')

%% 混淆矩阵
H=[];
H(1,1)=number_1_sim;
number_1_2= length(find(T_sim == 1 & T_test == 2));H(1,2)=number_1_2;
number_1_3= length(find(T_sim == 1 & T_test == 3));H(1,3)=number_1_3;
number_1_4= length(find(T_sim == 1 & T_test == 4));H(1,4)=number_1_4;
H(2,2)=number_2_sim;
number_2_1= length(find(T_sim == 2 & T_test == 1));H(2,1)=number_2_1;
number_2_3= length(find(T_sim == 2 & T_test == 3));H(2,3)=number_2_3;
number_2_4= length(find(T_sim == 2 & T_test == 4));H(2,4)=number_2_4;
H(3,3)=number_3_sim;
number_3_1= length(find(T_sim == 3 & T_test == 1));H(3,1)=number_3_1;
number_3_2= length(find(T_sim == 3 & T_test == 2));H(3,2)=number_3_2;
number_3_4= length(find(T_sim == 3 & T_test == 4));H(3,4)=number_3_4;
H(4,4)=number_4_sim;
number_4_1= length(find(T_sim == 4 & T_test == 1));H(4,1)=number_4_1;
number_4_2= length(find(T_sim == 4 & T_test == 2));H(4,2)=number_4_2;
number_4_3= length(find(T_sim == 4 & T_test == 3));H(4,3)=number_4_3;
H