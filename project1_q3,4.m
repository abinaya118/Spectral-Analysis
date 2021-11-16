clc
clear all;
close all; 

a = [1 -1.3435 0.9025]; % AR coeffs
b = [1 1.3435 0.9025]; % MA coeffs
T = 3000;
e=normrnd(0,1,[1,3000]);

y = filter(b,a,e); % generate y
L=[128, 256, 512, 1024];
y=y(953:3000);

v1=rectwin(L(1));
v2=rectwin(L(2));
v3=rectwin(L(3));

phi1=periodogramse(y,v1,L(1));
phi2=periodogramse(y,v2,L(2));
phi3=periodogramse(y,v3,L(3));


w1=0:2*pi/L(1):2*pi*(L(1)-1)/L(1);
w2=0:2*pi/L(2):2*pi*(L(2)-1)/L(2);
w3=0:2*pi/L(3):2*pi*(L(3)-1)/L(3);

w1=w1(1:L(1)/2);
w2=w2(1:L(2)/2);
w3=w3(1:L(3)/2);

phi1=phi1(1:L(1)/2);
phi2=phi2(1:L(2)/2);
phi3=phi3(1:L(3)/2);

figure(1)
plot(w1,10*log(phi1))
hold on
plot(w2,10*log(phi2))
hold on
plot(w3,10*log(phi3))

xlabel('w','fontweight','bold'); ylabel('PSD(dB)','fontweight','bold');
legend('N=128','N=512','N=2048','fontweight','bold');
title('Periodogram');
