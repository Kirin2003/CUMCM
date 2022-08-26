function randomforest()
clc
clear;
T=3;%bagging采样的次数
M = importdata('D:\MATLAB\13.xlsx');  %读取数据
[sm,sn]=size(M);
% for i=1:sm             %归一化
%     mins=min(M(i,1:sn-1));
%     maxs=max(M(i,1:sn-1));
%     for j=1:sn-1
%         M(i,j)=2*(M(i,j)-mins)/(maxs-mins)-1;
%     end
% end
indices=crossvalind('Kfold',M(1:sm,sn),10); %十折交叉，划分训练集和测试集
testindices=(indices==1); %测试集索引
trainindices=~testindices;%训练集索引
trainset=M(trainindices,:); %获取训练集
testset=M(testindices,:);%获取测试集
[testm,~]=size(testset);
[trainm,trainn]=size(trainset);

predict=zeros(trainm,T);
for t=1:T %开始bagging采样
    D=[];%训练集
    for i=1:trainm%采样
        k=randperm(trainm,1);
        D=[D;trainset(k,:)];
    end
    [~,sn]=size(D);
    a=ones(sn-1,1);%属性集合a，1代表该属性未被划分
    
    tree=makerandomtree(D,a);%递归构造简单决策树
    
    for i=1:trainm
        treet=tree;
        while 1
           
            if treet.isnode==0
                predict(i,t)=treet.a;
                break;
            end
            if trainset(i,treet.mark)<=treet.a
                treet=treet.child(1);
            else
                treet=treet.child(2);
            end
          
        end
    end
    
end
acc=0;
for i=1:trainm
    if trainset(i,end)==mode(predict(i,:))
        acc=acc+1;
    end
end
acc=acc/trainm
end
