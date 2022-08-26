function [flag]=goto_C(path,water,food,day,weather,G)
disp('到达C');
% 变化到C(矿山)节点
% path表示前面的路径,water表示当前的水的箱数,food表示当前的食物的箱数,day表示当前是第几天,weather表示该关卡的天气,flag是继续向下遍历还是回溯
      
    flag = false;
    % 向下遍历
    for i=1:4
        weight = G(3,i);% 去下一节点的路径
        if weight > 0
            
            
            % 可以走到该邻接点
            adj_node = i; % 该邻接点
                
            if adj_node == 1
                [my_flag,my_water,my_food,my_day] = cost(water,food,weight, day,weather);
                if my_flag == false % 无法走到该邻接点
                    continue; % 遍历找下一个邻接点
                end
                [flag1]=goto_A([path 30],my_water,my_food,my_day,weather,G);
                if flag1 
                    flag = true;
                    
               
                end
            elseif adj_node == 2
                [my_flag,my_water,my_food,my_day] = cost(water,food,weight, day,weather);
                if my_flag == false % 无法走到该邻接点
                    continue; % 遍历找下一个邻接点
                end
                [flag2] = goto_B([path 30],my_water,my_food,my_day,weather,G);
                if flag2 
                    flag = true;
                    
               
                end
            elseif adj_node == 3
                disp('在矿山停留!');
                % 挖矿
                disp('选择在矿山挖矿!');
                [my_flag_mine,my_water_mine,my_food_mine,my_day_mine] = cost_mine(water,food,weight, day,weather);
                if my_flag_mine
                    
                    [flag3_mine]=goto_C([path 31],my_water_mine,my_food_mine,my_day_mine,weather,G);
                    if flag3_mine 
                        flag = true;
                    end
                end
                % 不挖矿
                disp('选择在矿山不挖矿!');
                [my_flag_no_mine,my_water_no_mine,my_food_no_mine,my_day_no_mine] = cost_no_mine(water,food,weight, day,weather);
                if my_flag_no_mine 
                    [flag3_no_mine]=goto_C([path 32],my_water_no_mine,my_food_no_mine,my_day_no_mine,weather,G);
                    if flag3_no_mine
                        flag = true;
                    end
                end
                
                
            elseif adj_node == 4
                [flag4]=goto_D([path 30],my_water,my_food,my_day,weather,G);
                if flag4 
                    flag = true;
                   
               
                end
            end


        end
    end

   

end
