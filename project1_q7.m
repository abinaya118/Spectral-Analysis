clc
clear all;
close all; 


a = [1 -1.3435 0.9025]; % AR coeffs
b = [1 1.3435 0.9025]; % MA coeffs
T = 3000;
e = randn(T,1); % generate gaussian white noise
y = filter(b,a,e); % generate y

L=2048;
M=[128,256,512,1024];
y=y(953:3000);
v1=rectwin(M(1));
v2=rectwin(M(2));
v3=rectwin(M(3));
v4=rectwin(M(4));

phi1=btse(y,v1,L);
phi2=btse(y,v2,L);
phi3=btse(y,v3,L);
phi4=btse(y,v4,L);

w=0:2*pi/L:2*pi*(L-1)/L;
w=w(1:L/2);
phi1=phi1(1:L/2);
phi2=phi2(1:L/2);
phi3=phi3(1:L/2);
phi4=phi4(1:L/2);

figure(1)
plot(w,10*log(phi1))
hold on
plot(w,10*log(phi2))
hold on
plot(w,10*log(phi3))
hold on
plot(w,10*log(phi4))
xlabel('w','fontweight','bold'); ylabel('PSD(dB)','fontweight','bold');
legend('M=128','M=256','M=512','M=1024','fontweight','bold');
title('Blackman Tuckey estimate with Rectangular Window');


