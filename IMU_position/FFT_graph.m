function [] = FFT_graph(data,freq)
data_in=data;

Fs = freq;            % 采样率
T = 1/Fs;             % 采样间隔
L = length(data_in);        % 信号长度
t = (0:L-1)*T;        % 时间向量
x = data_in;  % 信号

% 对信号进行FFT
y = fft(x);

% 计算频谱的单侧幅值谱
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% 定义频率向量
f = Fs*(0:(L/2))/L;

% 绘制单侧幅值谱
plot(f,P1)
title('单侧幅值谱')
xlabel('频率 (Hz)')
ylabel('|Y(f)|')


