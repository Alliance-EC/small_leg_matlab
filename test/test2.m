data_s=zeros(50000,1);
for i=1:50000
    data_s(i,1)=wdenoise(speed_l(i,1));
end
plot(speed_l);
hold on;
plot(data_s);
