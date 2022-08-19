function weights = EntropyWeight(A)
%熵权法求指标权重,R 为输入矩阵,返回权重向量weights
[rows,cols]=size(R); % 输入矩阵的大小,rows 为对象个数，cols 为指标个数
k=1/log(rows); % 求k
f=zeros(rows,cols); % 初始化fij
sumBycols=sum(R,1); % 输入矩阵的每一列之和(结果为一个1*cols 的行向量)
% 计算fij
for i=1:rows
for j=1:cols
f(i,j)=R(i,j)./sumBycols(1,j);
end
end
lnfij=zeros(rows,cols); % 初始化lnfij
% 计算lnfij
for i=1:rows

for j=1:cols
if f(i,j)==0
lnfij(i,j)=0;
else
lnfij(i,j)=log(f(i,j));
end
end
end
Hj=-k*(sum(f.*lnfij,1)); % 计算熵值Hj
weights=(1-Hj)/(cols-sum(Hj));
end
A=[0.681/0.718,14.65/18.87,0.021/0.165;0.695/0.718,17.78/18.87,0.0797/0.165;1,1,1]'
EntropyWeight(A)