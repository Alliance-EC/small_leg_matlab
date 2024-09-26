function x_hat = states_kalmanfilter(z,t,A,B,dt,sigma,sigma_q)
%#codegen
% Initialize state transition matrix
A_k = eye(10)+A.*dt;
B_k = B.*dt;
H = eye(10);    %测量矩阵
W = zeros(10);     %过程噪声系数
for i = 1:10
     if mod(i, 2) == 1 % 奇数行
          W(i, i) = 1/2 * dt^2;
     else % 偶数行
          W(i, i) = dt;
     end
end
Q_=zeros(10);
Q_(1:10+1:end) = sigma_q^2;
Q = W.*Q_;   %过程噪声协方差
R =zeros(10);     %测量噪声协方差
for i=1:10
     R(i,i)=sigma(i,1)^2;
end

persistent x_est p_est                % Initial state conditions
if isempty(x_est)
     x_est = zeros(10, 1);             % x_est=[v,a]'
     p_est = 1e4*eye(10, 10);
end
% Predicted state and covariance
x_prd = A_k * x_est+B_k*t;
p_prd = A_k * p_est * A_k' + Q;
% Estimation
S = H * p_prd' * H' + R;
B_ = H * p_prd';
klm_gain = (S \ B_)';
% Estimated state and covariance
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;
% Compute the estimated measurements
x_hat = H * x_est;
end                % of the function