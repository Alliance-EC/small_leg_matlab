%测试leg_conv_reverse函数

T1=0.5;
T2=0.2;
phi1=deg2rad(180);
phi4=deg2rad(0);
T_r = leg_conv_reverse(T1,T2,phi1,phi4);

disp(T_r);