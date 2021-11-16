clc
clear all;
close all; 

a = [1 -1.3435 0.9025]; % AR coeffs
b = [1 1.3435 0.9025]; % MA coeffs
T = 3000;
e = randn(T,1); % generate gaussian white noise
y = filter(b,a,e); % generate y
L=2048;
M=[128,1024];
y=y(953:3000);
w=0:2*pi/L:2*pi*(L-1)/L;
[a1,gamma1]=mywarma(y,2,2,M(1));
[a2,gamma2]=mywarma(y,2,2,M(2));
for i=1:length(w)
    phi1(i)=(gamma1(1)+gamma1(2)*exp(-1i*w(i))+conj(gamma1(2))*exp(1i*w(i))+gamma1(3)*exp(-1i*2*w(i))+conj(gamma1(3))*exp(1i*2*w(i)))/abs(a1(1)+a1(2)*exp(-1i*w(i))+a1(3)*exp(-1i*2*w(i))).^2;
    phi2(i)=(gamma2(1)+gamma2(2)*exp(-1i*w(i))+conj(gamma2(2))*exp(1i*w(i))+gamma2(3)*exp(-1i*2*w(i))+conj(gamma2(3))*exp(1i*2*w(i)))/abs(a2(1)+a2(2)*exp(-1i*w(i))+a2(3)*exp(-1i*2*w(i))).^2;
end  
w=w(1:L/2);
phi1=phi1(1:L/2);
phi2=phi2(1:L/2);

figure(1)
plot(w,10*log(phi1),'LineWidth',2)
hold on
plot(w,10*log(phi2),'LineWidth',2)
xlabel('w','fontweight','bold'); ylabel('PSD(dB)','fontweight','bold');
title('Modified Yule Walker ARMA')
legend('M=128','M=1024','fontweight','bold');

[a3,b3,sig3]=lsarma(y,2,2,8);
[a4,b4,sig4]=lsarma(y,2,2,20);

for i=1:length(w)
    phi3(i)=(abs(b3(1)+b3(2)*exp(-1i*w(i))+b3(3)*exp(-1i*2*w(i))).^2/abs(a3(1)+a3(2)*exp(-1i*w(i))+a3(3)*exp(-1i*2*w(i))).^2)*sig3;
    phi4(i)=(abs(b4(1)+b4(2)*exp(-1i*w(i))+b4(3)*exp(-1i*2*w(i))).^2/abs(a4(1)+a4(2)*exp(-1i*w(i))+a4(3)*exp(-1i*2*w(i))).^2)*sig4;
end 

phi3=phi3(1:L/2);
phi4=phi4(1:L/2);

figure(2)
plot(w,10*log(phi3),'LineWidth',2)
hold on 
plot(w,10*log(phi4),'LineWidth',2)
xlabel('w','fontweight','bold'); ylabel('PSD(dB)','fontweight','bold');
legend('K=8','K=20','fontweight','bold');
title('Two Stage Least Squares Method ARMA');

for i=1:length(w)
    phi5(i)=(1/abs(a3(1)+a3(2)*exp(-1i*w(i))+a3(3)*exp(-1i*2*w(i))).^2)*sig3;
    phi6(i)=(1/abs(a4(1)+a4(2)*exp(-1i*w(i))+a4(3)*exp(-1i*2*w(i))).^2)*sig4;
end 

phi5=phi5(1:L/2);
phi6=phi6(1:L/2);

figure(3)
plot(w,10*log(phi5),'LineWidth',2)
hold on
plot(w,10*log(phi6),'LineWidth',2)
xlabel('w','fontweight','bold'); ylabel('PSD(dB)','fontweight','bold');
legend('K=8','K=20','fontweight','bold');
title('Two Stage Least Squares Method AR');

