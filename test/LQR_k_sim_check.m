%检查LQR_k输出情况
Kout=LQR_k_out.data;
eout=LQR_eout.data;
outdata=zeros(10);
data_type=1;
figure;
for i=1:10
    outdata = squeeze(Kout(data_type, i, :)).*squeeze(eout(i, 1, :));
    plot(outdata);
    hold on;
end
