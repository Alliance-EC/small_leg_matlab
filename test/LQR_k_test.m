% 测试LQR_k函数
Ll = 0.11; Lr = 0.11;
K = LQR_k(Ll, Lr);

disp(K);
