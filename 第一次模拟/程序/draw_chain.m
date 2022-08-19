%% 锚链形状图像


figure(1);
flag = 0;
gamma_h = 0;
theta_0_h =4.9956;
phi_0_h = 35.9266;
F_gamma_h = 4503.9159;
rho_chain = 28.13;
g_chain = 8.52;
l_chain = 22.05;

gamma_h = gamma_h.*pi./180;
theta_0_h = theta_0_h .* pi ./ 180;
phi_0_h = phi_0_h .*pi ./180;
k_complete = F_gamma_h.*cos(gamma_h)./(rho_chain.*g_chain);
k_incomplete = F_gamma_h./(rho_chain.*g_chain);
if flag 
    %全部悬空
    th_min = gamma_h;
    th_max = pi./2 - theta_0_h;
    th = th_min:0.001:th_max;
    xy = size(th);
    n = xy(1,2);
    x = zeros(n);
    y = zeros(n);
    for i = 1:n
%     s = @(th)(k.*(tan(th)-cot(theta_0_h)) + l_chain) ;
    thi = th(1,i);
    x(1,i) = k_complete .* abs(log(abs( (sec(thi) + tan(thi))./(sec(gamma_h) + tan(gamma_h) ))));
    y(1,i) = k_complete.*(abs( sec(thi) - sec(gamma_h) ));
    end
    plot(x,y,'.r');
    xlabel('x(m)');
    ylabel('y(m)');
    hold on;
    

else 
    %部分悬空
    th_min = 0;
    th_max = pi./2 - theta_0_h;
    th = th_min:0.001:th_max;
    xy = size(th);
    n = xy(1,2);
    x = zeros(n);
    y = zeros(n);
    for i = 1:n
%     s = @(th)(k.*(tan(th)-cot(theta_0_h)) + l_chain) ;
    thi = th(1,i);
    x(1,i) = k_incomplete .* log(abs( (sec(thi) + tan(thi)) )) + l_chain - k_incomplete.* tan(pi./2 - phi_0_h);
    y(1,i) = k_incomplete .*(abs(  sec(thi) -1 ));
    end
    plot(x,y,'.r');
    hold on;
    x2 = 0:0.001:0.5;
    x2xy = size(x2);
    n_y2 = x2xy(1,2);
    
    y2 = zeros(1,n_y2);
    plot(x2,y2,'.r');
    xlabel('x(m)');xlim([0 20]);
    ylabel('y(m)');
    hold on;
    

end
