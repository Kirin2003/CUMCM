function [flag,my_water,my_food,my_day] = cost_no_mine(water,food,length, day,weather)
% 经过length天需要的的消耗(在矿山节点时),water,food表示水和食物,day表示当前是第几天,weather是天气情况
    cur_weather = weather(1,day);
    i = 1;
    while(i <= length)
        if cur_weather == 1
            % 晴天不挖矿,消耗5水,7食物
            my_water = water - 5;
            my_food = food - 7;
            my_day = day + 1;
        elseif cur_weather == 2
            % 高温行走,消耗8水,6食物
            my_water = water - 8;
            my_food = food - 6;
            my_day = day + 1;
        elseif cur_weather == 3
            % 不是矿山,沙暴停留,消耗10水,10食物
            my_water = water - 10;
            my_food = food - 10;
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
