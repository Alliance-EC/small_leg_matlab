% 处理输入数据
clear;
data=readmatrix("gimbal_yaw.csv");
last=find(data(:,1),1,'last');
x=data(1:last,1);
y=data(1:last,2);