% 日期,每天的行动,得到消耗的水和食物

clc;clear;
d = 1:30;
xy = size(d);
n = xy(1,2);

act = [-1 -1 -1 -1 -1   -1 -1 -1 -1  0    -1 -1 0     2 2 2 2 2   0 0    2 2 2 2 2 2 2 2    -1 0];
weather = [2 2 1 3 1 2 3 1 2 2 3 2 1 2 2 2 3 3 2 2 1 1 2 1 3 2 1 1 2 2];

water = 0;
food = 0;
for i = 20:30
    d1 = d(1,i);
    act1 = act(1,i);
if act1 == -1 || act1 == 0% 行走
    if weather(1,d1)== 1
    water = water + 10;
    food = food + 14;
    elseif weather(1,d1) == 2
        water = water + 16;
        food = food + 12;

    elseif weather(1,d1) == 3
        water = water + 10;
        food = food + 10;
    
    end
elseif act1 == 1 % 矿山不挖矿
    if weather(1,d1)== 1
    water = water + 5;
    food = food + 7;
    elseif weather(1,d1) == 2
        water = water + 8;
        food = food +6;

    elseif weather(1,d1) == 3
        water = water + 10;
        food = food + 10;
    
    end
elseif act1 == 2 % 矿山挖矿
    if weather(1,d1)== 1
    water = water + 15;
    food = food + 21;
    elseif weather(1,d1) == 2
        water = water + 24;
        food = food +18;

    elseif weather(1,d1) == 3
        water = water + 30;
        food = food + 30;
    
    end
end
end

disp(['水:',num2str(water),'食物',num2str(food)]);
