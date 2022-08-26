%% 第一关求解
clc;clear;
diary diary;
weather = [2 2 1 3 1 2 3 1 2 2 3 2 1 2 2 2 3 3 2 2 1 1 2 1 3 2 1 1 2 2];
% 邻接矩阵
A = [0 6 0 0;
     6 0 2 3;
     0 2 1 0;
     0 3 0 0];
% 质量约束,单位kg
M = 1200;
% 水,单位:箱
water = 0;
% 食物,单位:箱
food = 0;
% 初始日期
day=1;

my_water = 5;
my_food = 6;

while 1
    % 枚举物资的所有可能性
    my_water = my_water + 1;
    my_food = floor((M-my_water.*3)./2);
    
    if my_food < food 
        break;
    end

    goto_A([],my_water,my_food,day,weather,A);
    
    
    disp(['在起点补给水(箱):',num2str(my_water-water),'补给食物(箱):',num2str(my_food-food)]);
    
end
