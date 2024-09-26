% 全状态卡尔曼
% syms sigma [10,1];
% syms s sd phi phid theta_ll theta_lld theta_lr theta_lrd theta_b theta_bd;
% x=[s;sd;phi;phid;theta_ll;theta_lld;theta_lr;theta_lrd;theta_b;theta_bd];
% syms T_lwl T_lwr T_bll T_blr;
% T=[T_lwl;T_lwr;T_bll;T_blr];
syms x [10,1];
syms T [4,1] ;
syms sigma [10,1];
syms dt;
syms ll lr;
state_estimate=states_KLM(x,T,A_calc(ll,lr),B_calc(ll,lr),dt,sigma);
state_estimate=simplify(state_estimate);
matlabFunction(state_estimate, 'File', 'function/state_estimate');