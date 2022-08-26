%% 在起点/村庄买够资源,从第i天开始算,最多支撑多少天
clc;clear;
weather = [2 2 1 3 1 2 3 1 2 2 3 2 1 2 2 2 3 3 2 2 1 1 2 1 3 2 1 1 2 2];
i = 0;
% 到村庄时剩余质量
m_left = 709;

weight = 0;
water = 0;
food = 0;
spent = 0;

flag = input('沙暴天是否挖矿:');

count_sandstorm = 0;
count_sunny = 0;
count_hot = 0;
while( weight <= (1200+1200-m_left) && i < 30)
    i  = i+1;
    
    if i <= 10
        if weather(1,i) == 1
        % 晴天
        water = water +10;
        food = food+ 14;
        count_sunny = count_sunny+1;
        weight = weight + 58;
        elseif weather(1,i) == 2
        % 高温
        water = water + 16;
        food = food+ 12;
        count_hot = count_hot+1;
        weight = weight + 72;
        elseif weather(1,i) == 3
        % 沙暴
        water = water + 10;
        food = food+ 10;
        % 沙暴天停留
        count_sandstorm = count_sandstorm +1;
        weight = weight + 50;
        disp('沙暴,停留!');
        end
    else
        if weather(1,i) == 1
        % 晴天
        water = water + 15;
        food = food+ 21;
        count_sunny = count_sunny+1;
        weight  = weight + 87;
        elseif weather(1,i) == 2
        % 高温
        water = water + 24;
        food = food+ 18;
        count_hot = count_hot+1;
        weight = weight + 108;
        elseif weather(1,i) == 3
        % 沙暴
            if flag % 沙暴挖矿
                water = water + 30;
                food = food+ 30;
                
                count_sandstorm = count_sandstorm +1;
                weight = weight + 150;
            else % 沙暴停留
                water = water + 10;
                food = food+ 10;
                % 沙暴天停留
                count_sandstorm = count_sandstorm +1;
                weight = weight + 50;
            end


        
        end

    end

    % TODO?
    spent = water * 5 + food * 10;
    disp(['天:',num2str(i),'天气:',num2str(weather(1,i))]);
    disp(['带够这些天的资源,质量:',num2str(weight),'花费:',num2str(spent),'水(箱):',num2str(water),'水(kg)',num2str(water * 3),'食物(箱):',num2str(food),'食物(kg):',num2str(food * 2)]);
    disp(['沙暴天数:',num2str(count_sandstorm)]);
    disp(['晴朗天数',num2str(count_sunny)]);
    disp(['高温天数',num2str(count_hot)]);
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
disp(['因此,最多支撑天数',num2str(i-1)]);
% 在第一关的天气情况下,最多带18天的食物
% 刚好18天,水242箱,食物220箱,质量1130kg,还可以带70kg,需要分配
% 全部买食物,食物5元/kg,水1.6元/kg,还可以买35箱食物,350元
% 第8天到达村庄,身上带的质量:1166-490=676kg
