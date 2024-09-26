function x_hat = speed_kalmanfilter(z,sigma_q,sigma_v,sigma_a,dt)
%#codegen
% Initialize state transition matrix
A = [1 dt;...     % [v]
     0 1];       % [a]
H = [1 0;...
     0 1];     %测量矩阵
W = [1/2*dt^2 0;0 dt];     %过程噪声系数
Q = W.*[sigma_q^2 0;...
     0 sigma_q^2];   %过程噪声协方差
R = [sigma_v^2 0;...
     0 sigma_a^2];     %测量噪声协方差
persistent x_est p_est                % Initial state conditions
if isempty(x_est)
     x_est = zeros(2, 1);             % x_est=[v,a]'
     p_est = 1000*eye(2, 2);
end
% Predicted state and covariance
x_prd = A * x_est;
p_prd = A * p_est * A' + Q;
% Estimation
S = H * p_prd' * H' + R;
B = H * p_prd';
klm_gain = (S \ B)';
% Estimated state and covariance
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;
% Compute the estimated measurements
x_hat = H * x_est;
x_hat =x_hat(1,1);
end                % of the function