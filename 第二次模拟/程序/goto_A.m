function [flag]=goto_A(path,water,food,day,weather,G)

disp('到达A');
% 变化到A(起点)节点
% path表示前面的路径,water表示当前的水的箱数,food表示当前的食物的箱数,day表示当前是第几天,weather表示该关卡的天气,flag是继续向下遍历还是回溯
      
    flag = false;
    % 向下遍历
    for i=1:4
        weight = G(1,i);% 去下一节点的路径
        if weight > 0
            [my_flag,my_water,my_food,my_day] = cost(water,food,weight, day,weather);
            if my_flag == false % 无法走到该邻接点
                
                continue; % 遍历找下一个邻接点
            end
            % 可以走到该邻接点
            adj_node = i; % 该邻接点
            
                
            if adj_node == 1                
                [flag1]=goto_A([path 1],my_water,my_food,my_day,weather,G);
                if flag1
                    flag = true;
               
                end
            elseif adj_node == 2
                [flag2] = goto_B([path 1],my_water,my_food,my_day,weather,G);
                if flag2 
                    flag = true;
             
                end
            elseif adj_node == 3
                [flag3]=goto_C([path 1],my_water,my_food,my_day,weather,G);
                if flag3 
                    flag = true;
                    
                end
            elseif adj_node == 4
                [flag4]=goto_D([path 1],my_water,my_food,my_day,weather,G);
                if flag4 
                    flag = true;
                  
                end
            end


        end
    end

    

end
