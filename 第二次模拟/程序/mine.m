%% 在起点/村庄买够资源,从第i天开始算,最多支撑多少天
clc;clear;
weather = [2 2 1 3 1 2 3 1 2 2 3 2 1 2 2 2 3 3 2 2 1 1 2 1 3 2 1 1 2 2];
i = 15;
flag = input('沙暴天是否挖矿,是输入1,否输入0:');
% 第10天带的质量
m0 = 709;

% 第15天为止剩余的
if flag
    water = 0;
    food = 2;
else
    water = 0;
    food = 52;
end


weight = water * 3 + food * 2;
% spent = water * 5 + food * 10;
% 从第15天开始,需要的资源数量

need_water = 0;
need_food = 0;
need_spent = 0;

count_sandstorm = 0;
count_sunny = 0;
count_hot = 0;
while( weight <= (1200-m0) && i < 30)
    i  = i+1;
    
    if i <= 10
        if weather(1,i) == 1
        % 晴天行走
        water = water +10;
        food = food+ 14;
        count_sunny = count_sunny+1;

        need_water = need_water+10;
        need_food = need_food + 14;
        need_spent = need_spent + 190;
        elseif weather(1,i) == 2
        % 高温行走
        water = water + 16;
        food = food+ 12;
        count_hot = count_hot+1;
        
        need_water = need_water+16;
        need_food = need_food + 12;
        need_spent = need_spent + 200;
        elseif weather(1,i) == 3
        % 沙暴停留
        water = water + 10;
        food = food+ 10;
        % 还没到挖矿地点,沙暴天停留
        count_sandstorm = count_sandstorm +1;
        
        need_water = need_water+10;
        need_food = need_food + 10;
        need_spent = need_spent + 150;

        disp('沙暴,停留!');
        end
    else
        if weather(1,i) == 1
        % 晴天挖矿
        water = water + 15;
        food = food+ 21;
        count_sunny = count_sunny+1;

        need_water = need_water+15;
        need_food = need_food + 21;
        need_spent = need_spent + 285;
        
        elseif weather(1,i) == 2
        % 高温挖矿
        water = water + 24;
        food = food+ 18;
        count_hot = count_hot+1;

        need_water = need_water+24;
        need_food = need_food + 18;
        need_spent = need_spent + 300;
        
        elseif weather(1,i) == 3
        
            if flag  % 沙暴天挖矿
                water = water + 30;
                food = food+ 30;
               
                count_sandstorm = count_sandstorm +1;
               
                need_water = need_water+30;
                need_food = need_food + 30;
                need_spent = need_spent + 450;
            else 
                water = water + 10;
                food = food+ 10;
               
                count_sandstorm = count_sandstorm +1;
               
                need_water = need_water+10;
                need_food = need_food + 10;
                need_spent = need_spent + 150;
            end
        
        end

    end
    weight = water * 3 + food * 2;
    % TODO ?
    spent = water * 5 + food * 10;
    disp(['天:',num2str(i),'天气:',num2str(weather(1,i))]);
    disp(['带够这些天的资源,质量:',num2str(weight),'花费(不重要):',num2str(spent),'水:',num2str(water),'食物:',num2str(food)]);
    disp(['为了带够,在村庄补给, 水:',num2str(need_water),'食物:',num2str(need_food)]);
end

disp('------');
disp(['第',num2str(i),'天']);
disp(['spent:',num2str(spent)]);
disp(['weight:',num2str(weight)]);
disp(['water:',num2str(water)]);
disp(['food:',num2str(food)]);
disp(['沙暴天数:',num2str(count_sandstorm)]);
disp(['晴朗天数',num2str(count_sunny)]);
disp(['高温天数',num2str(count_hot)]);

disp('------');
disp(['因此,最多支撑到第几天',num2str(i-1)]);
% 在第一关的天气情况下,最多带18天的食物
% 刚好18天,水242箱,食物220箱,质量1130kg,还可以带70kg,需要分配
% 全部买食物,食物5元/kg,水1.6元/kg,还可以买35箱食物,350元
% 第8天到达村庄,身上带的质量:1166-490=676kg
