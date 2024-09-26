function v_world_yaw = body2world(q, v_body)
% 机体向量转世界向量，但是保留yaw旋转
    % 将四元数转换为旋转矩阵
    R = quat2rotm(q');
    yaw=atan2(2*(q(1)*q(4)+q(2)*q(3)),2*(q(1)*q(1)+q(2)*q(2))-1);
    % 构造旋转矩阵
    R_yaw = [cos(yaw),-sin(yaw),0;...
             sin(yaw),cos(yaw) ,0;...
             0       ,0        ,1];
    % 向量旋转到世界坐标系中
    v_world_yaw = R_yaw' * R * v_body;
end
