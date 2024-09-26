% VMC解算优化版本，大幅减少计算量
if ~exist(fullfile(pwd, 'data', 'leg_calc.mat'), 'file')
clear;
tic;
syms phi1_t(t) phi2_t(t) phi3_t(t) phi4_t(t) phi_dot_1 phi_dot_4;
syms l1 l2 l3 l4 l5;
syms L0 phi0;

%进行几何计算
x_B = l1 * cos(phi1_t);
y_B = l1 * sin(phi1_t);
x_C = x_B + l2 * cos(phi2_t);
y_C = y_B + l2 * sin(phi2_t);
x_D = l5 + l4 * cos(phi4_t);
y_D = l4 * sin(phi4_t);

x_dot_B = diff(x_B, t);
y_dot_B = diff(y_B, t);
x_dot_C = diff(x_C, t);
y_dot_C = diff(y_C, t);
x_dot_D = diff(x_D, t);
y_dot_D = diff(y_D, t);

% dphi2公式
phi_dot_2 = ((x_dot_D - x_dot_B) * cos(phi3_t) + (y_dot_D - y_dot_B) * sin(phi3_t)) / l2 / sin(phi3_t - phi2_t);
% 将表达式中 diff(X,t) 类型的符号变量替换为记作 X_dot 的基本符号变量
x_dot_C = subs(x_dot_C, diff(phi2_t, t), phi_dot_2);
x_dot_C = subs(x_dot_C, ...
    [diff(phi1_t, t), diff(phi4_t, t)], ...
    [phi_dot_1, phi_dot_4]);
y_dot_C = subs(y_dot_C, diff(phi2_t, t), phi_dot_2);
y_dot_C = subs(y_dot_C, ...
    [diff(phi1_t, t), diff(phi4_t, t)], ...
    [phi_dot_1, phi_dot_4]);
% 求雅可比矩阵
x_dot = [x_dot_C; y_dot_C];
q_dot = [phi_dot_1; phi_dot_4];
x_dot = simplify(collect(x_dot, q_dot));
J = simplify(jacobian(x_dot, q_dot));

R = [cos(phi0 - pi / 2) -sin(phi0 - pi / 2);
     sin(phi0 - pi / 2) cos(phi0 - pi / 2)];
M = [0 -1 / L0;
     1 0];
M_v = [1 0;
     0 -1 / L0];
% 动力雅可比矩阵
Tf = J.' * R * M;
Tf = simplify(Tf);
% 位置雅可比矩阵
Ts = M_v * R \ J;
Ts = simplify(Ts);
% 逆向动力雅可比矩阵
syms T1 T2;
T_tr = Tf \ [T1; T2];
T_tr = simplify(T_tr);
disp('几何计算完毕');
%% 带入角度计算
A0 = 2 * l2 * (x_D - x_B);
B0 = 2 * l2 * (y_D - y_B);
C0 = l2 ^ 2 + (x_D - x_B) ^ 2 + (y_D - y_B) ^ 2 - l3 ^ 2;
phi2_t_ = 2 * atan((B0 + sqrt(A0 ^ 2 + B0 ^ 2 - C0 ^ 2)) / (A0 + C0));
phi2_t_ = simplify(phi2_t_);
phi3_t_ = atan((y_B - y_D + l2 * sin(phi2_t_)) / (x_B - x_D + l2 * cos(phi2_t_)));
phi3_t_ = simplify(phi3_t_);

x_C_ = x_B + l2 * cos(phi2_t_);
y_C_ = y_B + l2 * sin(phi2_t_);

L0_ = simplify(sqrt((x_C_ - l5 / 2) ^ 2 + y_C_ ^ 2));
phi0_ = atan2(y_C_, (x_C_ - l5 / 2));
theta = simplify(pi / 2 - phi0_);
% 求得腿部姿态
syms phi1 phi4;
pos_t = [L0_; theta];
pos = formula(pos_t);
pos = subs(pos, [phi1_t(t) phi4_t(t)], [phi1 phi4]);
disp('5%');
% 求得腿部运动速度
syms dphi1 dphi4;
Ts = subs(Ts, [phi2_t(t) phi3_t(t) L0 phi0], [phi2_t_ phi3_t_ L0_ phi0_]);
Ts = simplify(Ts);

spd_t = Ts * [dphi1; dphi4];
spd = formula(spd_t);
spd = subs(spd, [phi1_t(t) phi4_t(t)], [phi1 phi4]);
disp('45%');
% 求得VMC转换矩阵
syms F Tp;
Tf = subs(Tf, [phi2_t(t) phi3_t(t) L0 phi0], [phi2_t_ phi3_t_ L0_ phi0_]);
Tf = simplify(Tf);

T_t = Tf * [F; Tp];
T = formula(T_t);
T = subs(T, [phi1_t(t) phi4_t(t)], [phi1 phi4]);
disp('60%');
% 反解VMC
T_tr = subs(T_tr, [phi2_t(t) phi3_t(t) L0 phi0], [phi2_t_ phi3_t_ L0_ phi0_]);
T_tr = simplify(T_tr);

T_r = formula(T_tr);
T_r = subs(T_r, [phi1_t(t) phi4_t(t)], [phi1 phi4]);
disp('带入角度计算完毕，储存结果');
save("data/leg_calc.mat");
toc;
end
%% 赋值计算
clear;
tic;
load("data/leg_calc.mat");
l1_ = 0.148; l2_ = 0.265; l5_ = 0.14; l3_ = l2_; l4_ = l1_; % UP腿长，Down腿长，关节电机距离
pos = subs(pos, [l1 l2 l3 l4 l5], [l1_ l2_ l3_ l4_ l5_]);
spd = subs(spd, [l1 l2 l3 l4 l5], [l1_ l2_ l3_ l4_ l5_]);
T = subs(T, [l1 l2 l3 l4 l5], [l1_ l2_ l3_ l4_ l5_]);
T_r = subs(T_r, [l1 l2 l3 l4 l5], [l1_ l2_ l3_ l4_ l5_]);
% [l0; theta] = leg_pos(phi1, phi4)
matlabFunction(pos, 'File', 'function/leg_pos');
% [dl0; dphi0] = leg_spd(dphi1, dphi4, phi1, phi4) 计算有问题，不要用
matlabFunction(spd, 'File', 'function/leg_spd');
% [T1; T2] = leg_conv(F, Tp, phi1, phi4)
matlabFunction(T, 'File', 'function/leg_conv');
% [F; Tp] = leg_conv_reverse(T1, T2, phi1, phi4)
matlabFunction(T_r, 'File', 'function/leg_conv_reverse');
disp('函数已生成');
toc;












