%本程序用于计算simulink腿部参数
%sim("leg_sim.slx");

I = leg.I.data;
L = leg.L.data;
com = leg.com.data;
theta_J1 = leg.theta_J1.data;
theta_J2 = leg.theta_J2.data;
theta_bl = leg.theta_bl.data;

Lb = zeros(size(com, 3), 1);

for i = 1:size(com, 3)
    Lb(i) = sqrt(com(1, 1, i) ^ 2 + com(2, 1, i) ^ 2);
end
plot(L,Lb);
cftool("lb_sfit.sfit");

% Izz = squeeze(I(3, 3, :));
% plot(L,Izz);
% cftool("leg_sfit.sfit");%请在拟合中重新选一遍数据
