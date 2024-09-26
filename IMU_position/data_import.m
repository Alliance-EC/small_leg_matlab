% 导入数据
clear;
data = readmatrix('data__1.csv');

ax = data(:, 4);
ay = data(:, 5);
az = data(:, 6);

angle_x=data(:, 10);
angle_y=data(:, 11);
angle_z=data(:, 12);