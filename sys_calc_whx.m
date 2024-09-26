% 王工模型系统建模计算
%% 建模部分
%theta : 摆杆与竖直方向夹角             R   ：驱动轮半径
%x     : 驱动轮位移                    L   : 摆杆重心到驱动轮轴距离
%phi   : 机体与水平夹角                LM  : 摆杆重心到其转轴距离
%T     ：驱动轮输出力矩                 l   : 机体重心到其转轴距离
%Tp    : 髋关节输出力矩                 mw  : 驱动轮转子质量
%N     ：驱动轮对摆杆力的水平分量        mp  : 摆杆质量
%P     ：驱动轮对摆杆力的竖直分量        M   : 机体质量
%Nm    ：摆杆对机体力水平方向分量        Iw  : 驱动轮转子转动惯量
%Pm    ：摆杆对机体力竖直方向分量        Ip  : 摆杆绕质心转动惯量
%Nf    : 地面对驱动轮摩擦力             Im  : 机体绕质心转动惯量
tic;
clear;
syms x(t) T R Iw mw M L LM theta(t) l phi(t) mp Tp Ip IM
syms f1 f2 f3 d_theta d_x d_phi theta0 x0 phi0
syms leg_len;

R1=0.09;                                                   %驱动轮半径
eta_l = 0.3088;
L1=eta_l * leg_len + 0.0380;                               %摆杆重心到驱动轮轴距离
LM1=leg_len - L1;                                          %摆杆重心到其转轴距离
l1=0.035;                                                 %机体质心距离转轴距离
mw1=0.39;                                                  %驱动轮质量
mp1=1.26;                                                  %杆质量
M1=13;                                                     %机体质量
Iw1=0.005;                                                 %驱动轮转动惯量
Ip1=0.3202 * leg_len * leg_len + 0.0556* leg_len + 0.0240; %摆杆转动惯量
IM1=0.2106;                                                %机体绕质心转动惯量
g = 9.80665;


NM = M*diff(x + (L + LM )*sin(theta)-l*sin(phi),t,2);
N = NM + mp*diff(x + L*sin(theta),t,2);
PM = M*g + M*diff((L+LM)*cos(theta)+l*cos(phi),t,2);
P = PM +mp*g+mp*diff(L*cos(theta),t,2);

eqn1 = diff(x,t,2) == (T -N*R)/(Iw/R + mw*R);
eqn2 = Ip*diff(theta,t,2) == (P*L + PM*LM)*sin(theta)-(N*L+NM*LM)*cos(theta)-T+Tp;
eqn3 = IM*diff(phi,t,2) == Tp +NM*l*cos(phi)+PM*l*sin(phi);

eqn10 = subs(subs(subs(subs(subs(subs(subs(subs(subs(eqn1,diff(theta,t,2),f1),diff(x,t,2),f2),diff(phi,t,2),f3),diff(theta,t),d_theta),diff(x,t),d_x),diff(phi,t),d_phi),theta,theta0),x,x0),phi,phi0);
eqn20 = subs(subs(subs(subs(subs(subs(subs(subs(subs(eqn2,diff(theta,t,2),f1),diff(x,t,2),f2),diff(phi,t,2),f3),diff(theta,t),d_theta),diff(x,t),d_x),diff(phi,t),d_phi),theta,theta0),x,x0),phi,phi0);
eqn30 = subs(subs(subs(subs(subs(subs(subs(subs(subs(eqn3,diff(theta,t,2),f1),diff(x,t,2),f2),diff(phi,t,2),f3),diff(theta,t),d_theta),diff(x,t),d_x),diff(phi,t),d_phi),theta,theta0),x,x0),phi,phi0);

[f1,f2,f3] = solve(eqn10,eqn20,eqn30,f1,f2,f3);

A=subs(jacobian([d_theta,f1,d_x,f2,d_phi,f3],[theta0,d_theta,x0,d_x,phi0,d_phi]),[theta0,d_theta,d_x,phi0,d_phi,T,Tp],[0,0,0,0,0,0,0]);
A=subs(A,[R,L,LM,l,mw,mp,M,Iw,Ip,IM],[R1,L1,LM1,l1,mw1,mp1,M1,Iw1,Ip1,IM1]);
A=vpa(A);
B=subs(jacobian([d_theta,f1,d_x,f2,d_phi,f3],[T,Tp]),[theta0,d_theta,d_x,phi0,d_phi,T,Tp],[0,0,0,0,0,0,0]);
B=subs(B,[R,L,LM,l,mw,mp,M,Iw,Ip,IM],[R1,L1,LM1,l1,mw1,mp1,M1,Iw1,Ip1,IM1]);
B=vpa(B);


A_calc = matlabFunction(A);
B_calc = matlabFunction(B);

%% 拟合部分
L0s=0.10:0.01:0.45; % L0变化范围
Ks=zeros(2,6,length(L0s)); % 存放不同L0对应的K

% 定义权重矩阵Q, R
Q=diag([1 1 500 100 5000 1]);
R=diag([1 0.25]);

for step=1:length(L0s)
    A_=A_calc(L0s(step));
    B_=B_calc(L0s(step));
    % 离散化
    [G,H]=c2d(A_,B_,0.001); %1000Hz
    
    % 定义权重矩阵Q, R
    Q=diag([1 1 500 100 5000 1]);
    R=diag([1 0.25]);
    
    % 求解反馈矩阵K
    Ks(:,:,step)=dlqr(G,H,Q,R);
end

fitresult_matrix = sym('fitresult', [2 6]);
rsquare_values = zeros(2, 6);
fit_funcs = cell(2, 6);
% 对K的每个元素关于L0进行拟合
K=sym('K',[2 6]);
syms L0 x;
for i=1:2
    for j=1:6
        % 准备拟合所需的数据
        K_data = squeeze(Ks(i, j, :));
        K_data = K_data(1:length(L0s), 1);
        K_data = K_data.';
        xData = L0s(:);
        yData = K_data(:);
        
        % 进行拟合
        ft = fittype('poly4');
        [fit_result, gof] = fit(xData, yData, ft);
        % R方
        rsquare_values(i, j) = gof.rsquare;
        % 存储拟合结果
        K(i, j) = str2sym(formula(fit_result));
        K(i, j) = subs(K(i, j), coeffnames(fit_result).', coeffvalues(fit_result));
        K(i, j) = subs(K(i, j), x, L0);
        
        % 绘制拟合图
        subplot(2, 6, (i - 1) * 6 + j);
        fitted_values = fit_result(xData);
        plot(xData, yData, 'b.', xData, fitted_values, 'r-');
        xlabel('L0');
        ylabel('K');
        title(['Fitted Curve (i = ', num2str(i), ', j = ', num2str(j), ')']);
        legend('Data', 'Fitted Curve');
    end
end

disp('R方');
disp(rsquare_values);

% 输出到m函数
matlabFunction(K, 'File', 'function/LQR_k_whx');

L0 = 0.2;
K = LQR_k_whx(L0);
disp('LQR数据  L=0.2');
disp(K);
toc;

