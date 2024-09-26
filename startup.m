%启动脚本
clear;
if ~exist(fullfile(pwd, 'data'), 'dir')
    mkdir('data');
end
addpath("function;data;test;IMU_position;kalman_observer;");

if ~exist(fullfile(pwd, 'data', 'leg_calc.mat'), 'file')
    msgbox('找不到leg_calc.mat 将重新计算', '提示');
    run('leg_calc.m');
end

if ~exist(fullfile(pwd, 'data', 'sys.mat'), 'file')
    msgbox('找不到sys.mat 将重新计算', '提示');
    run('sys_calc.m');
else
    load("data\sys.mat");
end


