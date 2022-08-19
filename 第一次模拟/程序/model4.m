function [my_theta_0,my_gamma,my_h,my_r,my_flag,my_phi_0,my_F_gamma] = model4(my_m_ball,my_v_wind,my_v_water,my_H,my_rho_chain)
disp(['本次计算,水速为:',num2str(my_v_water)]);
% 环境常量


% 浮标, 圆柱体
% 浮标直径
d_buoy = 2;
% 浮标高度
h_buoy_all = 2;
% 浮标质量
m_buoy = 1000;

% 钢管,i = 1,2,3,4
l_pipe = 1;
d_pipe = 0.05;
m_pipe = 10;

% 钢桶
l_bucket = 1;
d_bucket = 0.3;
m_bucket = 100;

% 第一问已知条件
% 锚链
% 锚链长度
l_chain = 22.05;
% 锚链线密度
rho_chain = my_rho_chain;
% 锚链虚化重力加速度
g_chain = 8.52;
% 水深
H=my_H;
% 风速,可以调节

v_wind=my_v_wind;
% 水速,可以调节
v_water=my_v_water;
% 海水密度
rho_water = 1025;
% 重物球
m_ball = my_m_ball;

% 假设
% 重物球密度
rho_ball = 7650;
% 重力加速度
g = 9.8;

% 其他常量
G_pipe_tilde = m_pipe .* g - rho_water .* g .* pi.*(d_pipe./2)^2;
G_buoy = m_buoy .* g;
G_bucket_tilde = m_bucket.*g-rho_water .* g .* pi.*(d_bucket./2)^2;
G_ball_tilde = m_ball .* g - rho_water .* g .* (m_ball./rho_ball);
F_wind_per_S = 0.625 .* (v_wind.^2);
F_water_per_S = 374 .* (v_water.^2);


% 控制变量: 是部分落地还是全部落地
flag = 1;

% 首先假设是全部悬空
% 以h为自变量的函数
% 风力
F_wind = @(h)(F_wind_per_S .* 2 .* (2-h));
% 水流力
F_water_buoy = @(h)(F_water_per_S .* 2 .* h);
F_water_pipe = F_water_per_S .* d_pipe .* l_pipe;
F_water_ball = F_water_per_S .* (pi .* ((3.*m_ball ./ (4.*rho_ball .* pi)).^(2./3)));
F_water_bucket = F_water_per_S .* d_bucket .* l_bucket;

% 浮标浮力
f_buoy = @(h)(rho_water .* g .* pi .* h);
% phi_i
phi_1 = @(h)(atan( (F_wind(h)+4.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 4 .* G_pipe_tilde)));
phi_2 = @(h)(atan( (F_wind(h)+3.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 3 .* G_pipe_tilde)));
phi_3 = @(h)(atan( (F_wind(h)+2.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 2 .* G_pipe_tilde)));
phi_4 = @(h)(atan( (F_wind(h)+F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy -  G_pipe_tilde)));
phi_5 = @(h)(atan( (F_wind(h) + F_water_buoy(h) )./ (f_buoy(h) - G_buoy )));

% phi_0
phi_0 = @(h)(atan((F_wind(h)+F_water_bucket + F_water_ball + 4 .* F_water_pipe + F_water_buoy(h)) ./ (f_buoy(h) - G_buoy - 4 .* G_pipe_tilde - G_bucket_tilde  - G_ball_tilde)));

% F_i
F_1 = @(h)( (F_wind(h) + F_water_buoy(h)+4.*F_water_pipe) ./ sin(phi_1(h)));
F_2 = @(h)( (F_wind(h) + F_water_buoy(h)+3.*F_water_pipe) ./ sin(phi_2(h)));
F_3 = @(h)( (F_wind(h) + F_water_buoy(h)+2.*F_water_pipe) ./ sin(phi_3(h)));
F_4 = @(h)( (F_wind(h) + F_water_buoy(h)+1.*F_water_pipe) ./ sin(phi_4(h)));
F_5 = @(h)( (F_wind(h) + F_water_buoy(h)) ./ sin(phi_5(h)));

F_0 = @(h)((F_wind(h) + F_water_buoy(h)+4.*F_water_pipe + F_water_bucket  + F_water_ball) ./ sin(phi_0(h)));
% gamma
gamma = @(h)( atan( (f_buoy(h) - G_buoy - (4 .* G_pipe_tilde + G_bucket_tilde + G_ball_tilde + rho_chain .* l_chain .*g_chain) )./ (F_wind(h)+4.*F_water_pipe + F_water_buoy(h)+F_water_bucket + F_water_ball) ) );


% F_gamma 
F_gamma = @(h)((F_wind(h) + F_water_ball + F_water_bucket + 4 .* F_water_pipe + F_water_buoy(h)) ./ cos(gamma(h)));

%theta_i
theta_0 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+4.*F_water_pipe + F_water_bucket./2  + F_water_ball./2) ./ (f_buoy(h)-G_buoy - 4.*G_pipe_tilde  - G_bucket_tilde ./ 2)));
theta_1 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+7.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 7 .* G_pipe_tilde ./ 2)));
theta_2 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+5.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 5 .* G_pipe_tilde ./ 2)));
theta_3 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+3.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 3 .* G_pipe_tilde ./ 2)));
theta_4 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+F_water_pipe./2) ./ (f_buoy(h) - G_buoy -  G_pipe_tilde ./ 2)));

% s_y
s_y_1 = @(h) (abs( F_gamma(h).*cos(gamma(h)) .* (sec(pi./2 - phi_0(h)) - sec(gamma(h))) / (rho_chain .* g_chain) ));
s_y = @(h)(s_y_1(h));

% l_vertical
l_vertical = @(h)(cos(theta_0(h)) +cos(theta_1(h)) + cos(theta_2(h)) + cos(theta_3(h)) + cos(theta_4(h)));
% 计算h
calculate_h = fsolve(@(h)(h + s_y(h) + l_vertical(h) - H),0.6);
disp(['通过零点计算h:',num2str(calculate_h)]);
disp(['gamma:',num2str(gamma(calculate_h).*180./pi)]);

% 检验全部悬空的条件是否满足
flag = gamma(calculate_h) > 0;

% 部分悬空,重新计算
if flag == 0

    disp('不满足全部悬空条件,部分悬空,重新计算');

    % 风力
    F_wind = @(h)(F_wind_per_S .* 2 .* (2-h));
    % 水流力
    F_water_buoy = @(h)(F_water_per_S .* 2 .* h);
    F_water_pipe = F_water_per_S .* d_pipe .* l_pipe;
    F_water_ball = F_water_per_S .* (pi .* ((3.*m_ball ./ (4.*rho_ball .* pi)).^(2./3)));
    F_water_bucket = F_water_per_S .* d_bucket .* l_bucket;

    % 浮标浮力
    f_buoy = @(h)(rho_water .* g .* pi .* h);
    % phi_i
    phi_1 = @(h)(atan( (F_wind(h)+4.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 4 .* G_pipe_tilde)));
    phi_2 = @(h)(atan( (F_wind(h)+3.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 3 .* G_pipe_tilde)));
    phi_3 = @(h)(atan( (F_wind(h)+2.*F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy - 2 .* G_pipe_tilde)));
    phi_4 = @(h)(atan( (F_wind(h)+F_water_pipe + F_water_buoy(h) )./ (f_buoy(h) - G_buoy -  G_pipe_tilde)));
    phi_5 = @(h)(atan( (F_wind(h) + F_water_buoy(h) )./ (f_buoy(h) - G_buoy )));

    % phi_0
    phi_0 = @(h)(atan((F_wind(h)+F_water_bucket + F_water_ball + 4 .* F_water_pipe + F_water_buoy(h)) ./ (f_buoy(h) - G_buoy - 4 .* G_pipe_tilde - G_bucket_tilde  - G_ball_tilde)));

    % F_i
    F_1 = @(h)( (F_wind(h) + F_water_buoy(h)+4.*F_water_pipe) ./ sin(phi_1(h)));
    F_2 = @(h)( (F_wind(h) + F_water_buoy(h)+3.*F_water_pipe) ./ sin(phi_2(h)));
    F_3 = @(h)( (F_wind(h) + F_water_buoy(h)+2.*F_water_pipe) ./ sin(phi_3(h)));
    F_4 = @(h)( (F_wind(h) + F_water_buoy(h)+1.*F_water_pipe) ./ sin(phi_4(h)));
    F_5 = @(h)( (F_wind(h) + F_water_buoy(h)) ./ sin(phi_5(h)));

    F_0 = @(h)((F_wind(h) + F_water_buoy(h)+4.*F_water_pipe + F_water_bucket  + F_water_ball) ./ sin(phi_0(h)));
    % gamma
    
    gamma = @(h)(0);

    % F_gamma
    F_gamma = @(h)((F_wind(h) + F_water_ball + F_water_bucket + 4 .* F_water_pipe + F_water_buoy(h)) ./ cos(gamma(h)));

    %theta_i
    theta_0 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+4.*F_water_pipe + F_water_bucket./2  + F_water_ball./2) ./ (f_buoy(h)-G_buoy - 4.*G_pipe_tilde  - G_bucket_tilde ./ 2)));
    theta_1 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+7.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 7 .* G_pipe_tilde ./ 2)));
    theta_2 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+5.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 5 .* G_pipe_tilde ./ 2)));
    theta_3 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+3.*F_water_pipe./2) ./ (f_buoy(h) - G_buoy - 3 .* G_pipe_tilde ./ 2)));
    theta_4 = @(h)(atan( (F_wind(h) + F_water_buoy(h)+F_water_pipe./2) ./ (f_buoy(h) - G_buoy -  G_pipe_tilde ./ 2)));

    % s_y
    s_y_2 = @(h) (F_gamma(h) .* abs(sec(pi./2 - phi_0(h)) - 1)./ (rho_chain .* g_chain) );
    s_y = @(h)(s_y_2(h));

    % l_vertical
    l_vertical = @(h)(cos(theta_0(h)) +cos(theta_1(h)) + cos(theta_2(h)) + cos(theta_3(h)) + cos(theta_4(h)));

    % 计算h
    calculate_h = fsolve(@(h)(h + s_y(h) + l_vertical(h) - H),0.9);

end

% 代回函数求值
h = calculate_h;
F_wind_h = F_wind(calculate_h);
f_buoy_h = f_buoy(calculate_h);
phi_0_h = phi_0(calculate_h);
phi_1_h = phi_1(calculate_h);
phi_2_h = phi_2(calculate_h);
phi_3_h = phi_3(calculate_h);
phi_4_h = phi_4(calculate_h);
phi_5_h = phi_5(calculate_h);
F_0_h = F_0(calculate_h);
F_1_h = F_1(calculate_h);
F_2_h = F_2(calculate_h);
F_3_h = F_3(calculate_h);
F_4_h = F_4(calculate_h);
F_5_h = F_5(calculate_h);
gamma_h = gamma(calculate_h);
F_gamma_h = F_gamma(calculate_h);
theta_0_h = theta_0(calculate_h);
theta_1_h = theta_1(calculate_h);
theta_2_h = theta_2(calculate_h);
theta_3_h = theta_3(calculate_h);
theta_4_h = theta_4(calculate_h);
s_y_h = s_y(calculate_h);
l_vertical_h = l_vertical(calculate_h);
F_water_buoy_h = F_water_buoy(calculate_h);

disp(['吃水深度:',num2str(h)]);

% 将h代入上式, 求得风力
disp(['风力:',num2str(F_wind_h)]);
% 将h代入上式, 求得水流力
disp(['浮标的水流力:',num2str(F_water_buoy_h)]);
disp(['钢管的水流力:',num2str(F_water_pipe)]);
disp(['钢桶的水流力:',num2str(F_water_bucket)]);
disp(['重物球的水流力:',num2str(F_water_ball)]);


% 将h代入上式, 求得浮标浮力
disp(['浮标浮力:',num2str(f_buoy_h)]);
% 将h代入上式, 求得phi_i
disp(['phi_0:',num2str(phi_0_h .* 180 ./ pi)]);
disp(['phi_1:',num2str(phi_1_h.* 180 ./ pi)]);
disp(['phi_2:',num2str(phi_2_h.* 180 ./ pi)]);
disp(['phi_3:',num2str(phi_3_h.* 180 ./ pi)]);
disp(['phi_4:',num2str(phi_4_h.* 180 ./ pi)]);
disp(['phi_5:',num2str(phi_5_h.* 180 ./ pi)]);
% 将h代入上式, 求得F_i
disp(['F_0:',num2str(F_0_h)]);
disp(['F_1:',num2str(F_1_h)]);
disp(['F_2:',num2str(F_2_h)]);
disp(['F_3:',num2str(F_3_h)]);
disp(['F_4:',num2str(F_4_h)]);
disp(['F_5:',num2str(F_5_h)]);
% 将h代入上式, 求得gamma
disp(['gamma:',num2str(gamma_h.*180./pi)]);
% 将h代入上式, 求得F_gamma
disp(['F_gamma:',num2str(F_gamma_h)]);
% 将h代入上式, 求得theta_i
disp(['theta_0:',num2str(theta_0_h.* 180 ./ pi)]);
disp(['theta_1:',num2str(theta_1_h.* 180 ./ pi)]);
disp(['theta_2:',num2str(theta_2_h.* 180 ./ pi)]);
disp(['theta_3:',num2str(theta_3_h.* 180 ./ pi)]);
disp(['theta_4:',num2str(theta_4_h.* 180 ./ pi)]);
% 将h代入上式, 求得s_y
disp(['s_y:',num2str(s_y_h)]);
% 将h代入上式, 求得l_vertical
disp(['l_vertical:',num2str(l_vertical_h)]);



k_complete = F_gamma_h.*cos(gamma_h)./(rho_chain.*g_chain);
k_incomplete = F_gamma_h./(rho_chain.*g_chain);

% 求解第一问
% s_x


s_x_1 =  k_complete.* abs(log(abs( (sec(pi./2-phi_0_h) + tan(pi./2-phi_0_h))./(sec(gamma_h) + tan(gamma_h) ))));
s_x_2 =  k_incomplete .* log(abs( (sec(pi./2-phi_0_h) + tan(pi./2-phi_0_h)) )) + l_chain - k_incomplete.* tan(pi./2-phi_0_h);


% l_horizon
l_horizon = sin(theta_0_h) +sin(theta_1_h) +sin(theta_2_h) +sin(theta_3_h) +sin(theta_4_h) ; 


s_x = 0;
if flag 
    s_x = s_x_1; % 全部悬空
    
    
else
    s_x = s_x_2; % 部分悬空
    
end

r = s_x + l_horizon;


disp(['s_x:',num2str(s_x)]);
disp(['l_horizon:',num2str(l_horizon)]);
disp(['r:',num2str(r)]);

%% 返回值
my_theta_0 = theta_0_h;
my_gamma = gamma_h;
my_h = calculate_h;
my_r = r;
my_flag = flag;
my_phi_0 = phi_0_h;
my_F_gamma = F_gamma_h;
end