% IMU速度估计

% 加速度计测量值
a = [ax, ay, az]; % 或者是一个大小为Nx3的矩阵，每行代表一个数据点

% 四元数表示的旋转矩阵
q = eul2quat([deg2rad(angle_x), deg2rad(angle_y), deg2rad(angle_z)]); % 或者是一个大小为Nx4的矩阵，每行代表一个数据点的四元数表示
linear_acc=zeros(length(ax),3);
for i=1:length(ax)
    q0=q(i,1);
    q3=q(i,2);
    q2=q(i,3);
    q1=q(i,4);
    g_body=[2*(q1*q3-q0*q2),2*(q2*q3+q0*q1),1-2*(q1^2+q2^2)];
    linear_acc(i,:)=a(i,:)-g_body;
end
g=9.81;
lax=linear_acc(:,1)*g;
lay=linear_acc(:,2)*g;
laz=linear_acc(:,3)*g;

lax=filter(LPF, lax);

% 初始化速度和位置数组
n = length(lax);
vx = zeros(n, 1);
vy = zeros(n, 1);
vz = zeros(n, 1);
x = zeros(n, 1);
y = zeros(n, 1);
z = zeros(n, 1);

t=0.001;
% 循环更新速度和位置
for i = 1:n
    if i > 1
        vx(i) = vx(i-1) + lax(i)*t;
        vy(i) = vy(i-1) + lay(i)*t;
        vz(i) = vz(i-1) + laz(i)*t;
        x(i) = x(i-1) + vx(i)*t;
        y(i) = y(i-1) + vy(i)*t;
        z(i) = z(i-1) + vz(i)*t;
    else
        vx(i) = lax(i)*t;
        vy(i) = lay(i)*t;
        vz(i) = laz(i)*t;
        x(i) = vx(i)*t;
        y(i) = vy(i)*t;
        z(i) = vz(i)*t;
    end
end

plot(vx);

