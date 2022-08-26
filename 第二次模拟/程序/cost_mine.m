function [flag,my_water,my_food,my_day] = cost_mine(water,food,length, day,weather)
% 经过length天需要的的消耗(在矿山节点时),water,food表示水和食物,day表示当前是第几天,weather是天气情况
    cur_weather = weather(1,day);
    i = 1;
    while(i <= length)
        if cur_weather == 1
            % 晴天挖矿,消耗15水,21食物
            my_water = water - 15;
            my_food = food - 21;
            my_day = day + 1;
        elseif cur_weather == 2
            % 高温挖矿,消耗24水,18食物
            my_water = water - 24;
            my_food = food - 18;
            my_day = day + 1;
        elseif cur_weather == 3
            % 沙暴挖矿,消耗30水,30食物
            my_water = water - 30;
            my_food = food - 30;
            my_day = day + 1;
            
        end
        i = i+1;
        if my_water <0 || my_food <0 || my_day > 30
            flag = false;
            return;
        end
    end

    if my_water <0 || my_food <0 || my_day > 30
        flag = false;
    else
        flag = true;
    end

end
