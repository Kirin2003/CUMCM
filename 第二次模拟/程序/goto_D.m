function [flag]=goto_D(path,water,food,day,weather,G)
disp('到达D');
% 到达D(终点)节点
% path表示前面的路径,water表示当前的水的箱数,food表示当前的食物的箱数,day表示当前是第几天,weather表示该关卡的天气,flag是继续向下遍历还是回溯
    if water < 0 || food < 0 || day > 30
      flag = false;         
      
    
    else
      path = [path 4];
      flag = true;
      disp(['剩余的水(箱):',num2str(water),'食物(箱):',num2str(food),'路径如下:']);
      disp(path);
    end


end
