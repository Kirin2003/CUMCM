function tree=makerandomtree(D,a) 
tree=struct('isnode',1,'a',0.0,'mark',0.0,'child',{});%isnode判断是否是分支还是叶子，a表示节点属性，若节点是叶子，a表示分类结果，child是孩子
tree(1).a=1;%给tree分配一个确切的内存
if length(unique(D(:,end)))==1%D中样本属于同一类别
    tree.isnode=0;%把tree标记为树叶
    tree.a=D(1,end);%把tree的类别标记为D的类别
    return
end
if sum(a)==0 ||length(D)==0 %属性划分完毕
    tree.isnode=0;%把tree标记为树叶
    tree.a=mode(D(:,end));%把tree的类别标记为D出现最多的类别
    return
end
for i=1:length(a)
    if a(i)==1
        if length(unique(D(:,i)))==1
            tree.isnode=0;%把tree标记为树叶
            tree.a=mode(D(:,end));%把tree的类别标记为D出现最多的类别
            return
        end
    end
end
k=ceil(log2(sum(a)));%随机选k个属性进行学习
randomindices=zeros(length(a),1); %随机去掉属性的索引，结束之后要恢复随机去掉的属性
if k>1
i=1;
su=sum(a);
while 1 %随机去掉一些属性，使得剩下的属性是k个
    random1=randperm(length(a),1);
    if a(random1)==1
        randomindices(random1)=1;
        a(random1)=0;
        i=i+1;
    end
    if i==(su-k+1)
        break;
    end
end
end

gain=zeros(length(a),1); %保存每个属性的信息增益
best=zeros(length(a),1); %保存每个属性的最佳划分

for i=1:length(a)
    if a(i)==1
        t=D(:,i);
        t=sort(t);
    
        gain1=zeros(length(t)-1,1);
        for j=1:length(t)-1%二分划分
            ta=(t(j)+t(j+1))/2;
         
            Df=D(D(:,i)<=ta,:);
            Dz=D(D(:,i)>ta,:);
            gain1(j)=ent(D)-(ent(Df)*length(Df(:,end))/length(D(:,end))+ent(Dz)*length(Dz(:,end))/length(D(:,end)));
        end
     
        [gain(i),j]=max(gain1);
        ta=(t(j)+t(j+1))/2;
        best(i)=ta; 
    end
end
[~,m]=max(gain);%选择信息增益最大的属性
D1=D(D(:,m)<=best(m),:);
D2=D(D(:,m)>best(m),:);
a(m)=0;
for i=1:length(a)  %恢复随机去掉的属性
    if randomindices(i)==1
        a(i)=1;
    end
end
tree.a=best(m); %建立分支
tree.mark=m;
% disp('****************************')
% tree.a
% tree.mark
tree.isnode=1;
tree.child(1)=makerandomtree(D1,a);
tree.child(2)=makerandomtree(D2,a);

end
