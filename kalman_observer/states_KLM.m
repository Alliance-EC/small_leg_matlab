function x_hat = states_KLM(z, t, A, B, dt, sigma)
% Ensure all inputs are symbolic if necessary
z = sym(z);
t = sym(t);
A = sym(A);
B = sym(B);
dt = sym(dt);
sigma = sym(sigma);

% Initialize state transition matrix
A_k = eye(10) + A .* dt;
B_k = B .* dt;
H = eye(10);    % Measurement matrix

% Process noise coefficient matrix W
W = sym(zeros(10));
for i = 1:10
     if mod(i, 2) == 1 % Odd rows
          W(i, i) = 1/2 * dt^2;
     else % Even rows
          W(i, i) = dt;
     end
end

% Process noise covariance matrix Q
Q_ = sym(zeros(10));
Q_(1:10+1:end) = sigma.^2; % Assuming sigma is a vector of standard deviations
Q = W .* Q_;   % Element-wise multiplication

% Measurement noise covariance matrix R
R = sym(zeros(10));
for i = 1:10
     R(i, i) = sigma(i)^2; % Assuming sigma is a vector of standard deviations
end

% Persistent variables for state and covariance estimates
persistent x_est p_est
if isempty(x_est)
     x_est = sym(zeros(10, 1));             % State estimate (initialize with zeros)
     p_est = sym(eye(10));                  % Covariance estimate (initialize with identity matrix)
end

% Predicted state and covariance
x_prd = A_k * x_est + B_k * t;
p_prd = A_k * p_est * A_k.' + Q;

% Kalman gain calculation
S = H * p_prd * H.' + R;
B_ = H * p_prd;
klm_gain = (S \ B_).';

% Update state and covariance estimates
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;

% Estimated state
x_hat = H * x_est;
end
