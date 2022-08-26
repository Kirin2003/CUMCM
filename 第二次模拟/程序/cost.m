function [flag,my_water,my_food,my_day] = cost(water,food,length, day,weather)
% 经过length天需要的的消耗(不包括在矿山节点时),water,food表示水和食物,day表示当前是第几天,weather是天气情况
    
    i = 1;
    my_day = day;
    while(i <= length)
        cur_weather = weather(1,my_day);
        if cur_weather == 1
            % 晴天行走,消耗10水,14食物
            my_water = water - 10;
            my_food = food - 14;
            my_day = my_day + 1;
        elseif cur_weather == 2
            % 高温行走,消耗16水,12食物
            my_water = water - 16;
            my_food = food - 12;
            my_day = my_day + 1;
        elseif cur_weather == 3
            % 不是矿山,沙暴停留,消耗10水,10食物
            my_water = water - 10;
            my_food = food - 10;
            my_day = my_day + 1;
            disp('容易犯错!沙暴停留!');
            length = length +1;
        end
        i = i+1;

        if my_water <0 || my_food <0 || my_day > 30
            flag = false;
            
            return;
        end
    end
    disp(['原来的水,食物,日期:',num2str(water),' ',num2str(food),' ',num2str(day),'现在的水,食物,日期:',num2str(my_water),' ',num2str(my_food),' ',num2str(my_day)]);

    if my_water <0 || my_food <0 || my_day > 30
        flag = false;
    else
        flag = true;
    end

end
