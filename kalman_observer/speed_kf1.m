% kalman观测器实车数据测试
clear speed_kalmanfilter;%清除持久变量以重置
data_size=length(z_watch0);
v_hat=zeros(data_size,1);
for i=1:data_size
    z=[z_watch0(i);z_watch1(i)];
if(isnan(z_watch0(i))||isnan(z_watch1(i)))
    continue;
end
if(isinf(z_watch0(i))||isinf(z_watch1(i)))
    continue;
end
    v_hat(i)=speed_kalmanfilter(z,0.005,3.001601789602848e-04,0.011081122012732,0.001);
end

plot(z_watch0);
hold on;
plot(v_hat);
% 添加图例
legend('sd', 'v\_hat');