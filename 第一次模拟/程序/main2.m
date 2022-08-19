
clc;clear;
%% 定义
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
disp(['大范围循环遍历时,初始值为:',num2str(my_m_ball),'步长为:',num2str(step1)]);

while my_flag
    [my_theta_0,my_gamma,my_h,my_r] = model2(my_m_ball);
    my_flag = (( my_theta_0.*180./pi > 5) || (my_gamma.*180./pi > 16));
    disp(['当重物质量为:',num2str(my_m_ball),' 时,theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);
    my_m_ball = my_m_ball + step1;
    
end

my_m_ball = my_m_ball - step1;

disp(['小范围循环遍历时,初始值为:',num2str(my_m_ball),'步长为:',num2str(step2)]);
my_flag = 1;
while my_flag
    [my_theta_0,my_gamma,my_h,my_r] = model2(my_m_ball);
    my_flag = (( my_theta_0.*180./pi > 5) || (my_gamma.*180./pi > 16));
    disp(['当重物质量为:',num2str(my_m_ball),' 时,theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);
    my_m_ball = my_m_ball + step2;
end

disp(['调整后的重物质量:',num2str(my_m_ball)]);
disp(['theta_0:',num2str(my_theta_0.*180./pi),' gamma:',num2str(my_gamma.*180./pi)]);


%% 灵敏度分析
disp('灵敏度分析!');
my_m_ball_optimize = my_m_ball;
[my_theta_0_optimize, my_gamma_optimize,my_h_optimize,my_r_optimize] = model2(my_m_ball_optimize);
my_theta_0_optimize = my_theta_0_optimize .*180./pi;
my_gamma_optimize = my_gamma_optimize .*180./pi;
my_m_ball_min = my_m_ball_optimize - 0.1;
my_m_ball_max = my_m_ball_optimize + 0.1;
my_m = my_m_ball_min : 0.01 : my_m_ball_max;
xy = size(my_m);
n = xy(1,2);
my_the_n = zeros(1,n);
my_gam_n = zeros(1,n);
my_h_n = zeros(1,n);
my_r_n = zeros(1,n);
for i = 1:n
    [my_the_n(1,i),my_gam_n(1,i),my_h_n(1,i),my_r_n(1,i)] = model2(my_m(1,i));
end

my_the_n = my_the_n .*180./pi;
my_gam_n = my_gam_n .*180./pi;


figure(1);
plot(my_m,my_the_n,'-r');
hold on;
plot(my_m_ball_optimize,my_theta_0_optimize,'*');
xlabel('重物质量(kg)');ylabel('\theta_0(度)');ylim([4.565 4.57]);
figure(2);
plot(my_m,my_h_n,'-r');
hold on;
plot(my_m_ball_optimize,my_h_optimize,'*');
xlabel('重物质量(kg)');ylabel('吃水深度(m)');ylim([0.97985 0.98015]);
figure(3);
plot(my_m,my_r_n,'-r');
hold on;
plot(my_m_ball_optimize,my_r_optimize,'*r');
xlabel('重物质量(kg)');ylabel('游动区域半径(m)');ylim([18.922 18.9235]);





