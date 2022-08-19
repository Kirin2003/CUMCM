clc;clear;
%% 定义
% 风速
v_wind_all = [12 24];
% 水速
v_water_all = [1.5];
% 链条线密度
rho_chain_all = [3.2 7 12.5 19.5 28.12];
% 水深
H_all = [16 18 20];
% 步长,step1为第一次循环遍历步长,step2为第二次循环遍历步长
step1 = 10;
step2 = 0.5;
% 角度
my_theta_0 = 100;
my_gamma = 100;
my_h = 3;
my_r = 100;
% 循环终止变量
my_flag = (( my_theta_0.*180./pi > 5) || (my_gamma.*180./pi > 16));
% 大范围循环遍历时的初始值
my_m_ball = 1200;
my_v_wind = 27;
my_v_water = 0.8;
my_H = 20;
my_rho_chain =28.13;
disp(['大范围循环遍历时,初始值为:',num2str(my_m_ball),'步长为:',num2str(step1)]);


while my_flag
    [my_theta_0,my_gamma,my_h,my_r] = model3(my_m_ball,my_v_wind,my_v_water,my_H,my_rho_chain);
    my_flag = (( my_theta_0.*180./pi > 5) || (my_gamma.*180./pi > 16));
    disp(['当重物质量为:',num2str(my_m_ball),' 时,theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);
    my_m_ball = my_m_ball + step1;
    
end

my_m_ball = my_m_ball - step1;

disp(['小范围循环遍历时,初始值为:',num2str(my_m_ball),'步长为:',num2str(step2)]);
my_flag = 1;
while my_flag
    [my_theta_0,my_gamma,my_h,my_r] = model3(my_m_ball,my_v_wind,my_v_water,my_H,my_rho_chain);
    my_flag = (( my_theta_0.*180./pi > 5) || (my_gamma.*180./pi > 16));
    disp(['当重物质量为:',num2str(my_m_ball),' 时,theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);
    my_m_ball = my_m_ball + step2;
end

disp(['调整后的重物质量:',num2str(my_m_ball)]);
disp(['theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);
