clc;clear;
load data.mat;

[max_data,index] = max(data);
[min_data,index2] = min(data);

del_cols = [];
for i = 1:729
    if max_data(1,i) == min_data(1,i)
        del_cols = [del_cols i];
    end
end
