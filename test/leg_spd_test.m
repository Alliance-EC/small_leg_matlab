%测试leg_spd函数

phi1=deg2rad(180);
phi4=deg2rad(0);
dphi1=-0.1;
dphi4=-0.1;
spd = leg_spd(dphi1,dphi4,phi1,phi4);

disp(spd);
