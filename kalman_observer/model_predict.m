% 模型预测防打滑

syms s sd phi phid theta_ll theta_lld theta_lr theta_lrd theta_b theta_bd;
x=[s;sd;phi;phid;theta_ll;theta_lld;theta_lr;theta_lrd;theta_b;theta_bd];
syms T_lwl T_lwr T_bll T_blr;
T=[T_lwl;T_lwr;T_bll;T_blr];
syms dt;
F_k=eye(10)+A.*dt;
B_k=B.*dt;
x_hat=F_k*x+B_k*T;
speed_l_hat=1/Rw*(x_hat(2,1)-Rl*x_hat(4,1));
speed_r_hat=1/Rw*(x_hat(2,1)+Rl*x_hat(4,1));
speed_l_hat=simplify(speed_l_hat);
speed_r_hat=simplify(speed_r_hat);
speed_hat=[speed_l_hat;speed_r_hat];
matlabFunction(speed_hat, 'File', 'function/speed_hat');


