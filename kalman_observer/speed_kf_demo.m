% 卡尔曼观测器test
clear;
clear speed_kalmanfilter;%清除持久变量以重置
t = 1:2500;
v = zeros(size(t));
v(501:1000) = 0.002 * (t(501:1000)-500);
v(1001:1500) = 1;
v(1501:2000) = 1 - 0.002 * (t(1501:2000) - 1500);
v(2001:2501) = 0;

v_noise=v;
v_noise(1101:1400)=1+0.01 * randn(1, 300)+0.1*sin(linspace(0, 10*pi, 300));
v_noise=v_noise+0.01 * randn(1, 2501);

a = diff(v);
a=a*1000;
a=a+0.2 * randn(1, 2500);

v=v(1:2500);
v_noise=v_noise(1:2500);
v_hat=zeros(size(t));
for i=1:2500
    z=[v_noise(i);a(i)];
    v_hat(i)=speed_kalmanfilter(z,0.01,0.1,0.011251308189067,0.001);
end

plot(v_hat);
hold on;
plot(v);
plot(v_noise);
legend('v\_hat', 'v','v\_noise');