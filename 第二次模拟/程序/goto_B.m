function [flag]=goto_B(path,water,food,day,weather,G)
disp('到达B');
% 到达B(村庄)节点
% path表示前面的路径,water表示当前的水的箱数,food表示当前的食物的箱数,day表示当前是第几天,weather表示该关卡的天气,flag是继续向下遍历还是回溯
    
% 从邻接矩阵可知,从一个点到下一个点最短的距离 

% 常量!注意!
M = 1200;


flag = false;

water1 = max(water,5);
food1 = max(food,6);
while 1
    %所有的补给情况
%     water1 = max(water1 + 1,5);
%     food1 = floor((M-water1.*3)./2);
%     if food1 < food || food1 < 6
%         disp('food1 < food,break;');
%         break;
%     end

    
    % 向下遍历
    for i=1:4
        weight = G(2,i);% 去下一节点的路径
        if weight > 0
            [my_flag,my_water,my_food,my_day] = cost(water1,food1,weight, day,weather);
            if my_flag == false % 无法走到该邻接点
               
                continue; % 遍历找下一个邻接点
            end
            % 可以走到该邻接点
            adj_node = i; % 该邻接点
                
            if adj_node == 1
                
                [flag1]=goto_A([path 2],my_water,my_food,my_day,weather,G);
                if flag1 
                    flag = true;
                    
               
                end
            elseif adj_node == 2
                [flag2] = goto_B([path 2],my_water,my_food,my_day,weather,G);
                if flag2
                    flag = true;
                    
               
                end
            elseif adj_node == 3
                [flag3]=goto_C([path 2],my_water,my_food,my_day,weather,G);
                if flag3 
                    flag = true;
                    
               
                end
            elseif adj_node == 4
                [flag4]=goto_D([path 2],my_water,my_food,my_day,weather,G);
                if flag4 
                    flag = true;
                   
               
                end
            end


        end
    end
    
    disp(['在村庄补给水(箱):',num2str(water1-water),'补给食物(箱):',num2str(food1-food)]);

end

end
