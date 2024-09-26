% kalman观测器实车数据测试，带打滑检测
clear speed_kalmanfilter;%清除持久变量以重置
data_size=length(z_watch0);
v_hat=zeros(data_size,1);
flag=zeros(data_size,1);
for i=1:data_size
    z=[sd(i);a(i)];
if(isnan(sd(i))||isnan(a(i)))
    continue;
end
if(isinf(sd(i))||isinf(a(i)))
    continue;
end
if(delta(i)>4)
    v_hat(i)=speed_kalmanfilter(z,0.01,1000,0.011081122012732,0.001);
    flag(i)=10;
else
    v_hat(i)=speed_kalmanfilter(z,0.01,3.001601789602848e-04,0.011081122012732,0.001);
end

end

plot(sd);
hold on;
plot(v_hat);
% 添加图例
legend('sd', 'v\_hat');