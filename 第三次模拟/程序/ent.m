function f=ent(D)%计算信息商
l=unique(D(:,end));
if length(D)==0
    f=0;
    return
end
f=0;
t=zeros(length(l),1);
for i=1:length(D(:,end))
    for j=1:length(l)
        if D(i,end)==l(j)
            t(j)=t(j)+1;
            break;
        end
    end
end
n=length(D(:,end));
for i=1:length(l)
    f=f+(t(i)/n)*log2(t(i)/n);
end
f=-f;
end
