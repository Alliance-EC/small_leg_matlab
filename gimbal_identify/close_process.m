% 闭环转开环
tf_data=tf4;
tf_=tf(tf_data.Numerator,tf_data.Denominator);
G=tf_/(1-tf_);
speed_p=2.5;
G=G/speed_p;

figure;
bode(G);
grid on;
title('Bode Plot of Open Loop Transfer Function G(s)');