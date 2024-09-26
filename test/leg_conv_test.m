% 测试leg_conv函数
phi1=deg2rad(130);
phi4=deg2rad(55);

F=1;
Tp=1;
T = leg_conv(F,Tp,phi1,phi4);

disp(T);