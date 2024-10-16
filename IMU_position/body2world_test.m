% 定义机体坐标系到世界坐标系的四元数（假设为单位四元数，表示不进行旋转）
q = [1; 0; 0; 0]; % 四元数的格式为 [w; x; y; z]，其中 w 为实部，(x, y, z) 为虚部
% 定义机体坐标系中的向量（假设为向量 [1; 0; 0]）
v_body = [1; 0; 0]; % 在机体坐标系中的向量
% 调用函数进行转换
v_world = body2world(q, v_body);

disp('机体坐标系中的向量:');
disp(v_body);
disp('世界坐标系中的向量:');
disp(v_world);
