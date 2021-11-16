clc
clear all
close all

H = tf([1 -1.3435 0.9025],[1 1.3435 0.9025]);

figure(1)
pzmap(H)
grid on
a = [1 -1.3435 0.9025]; % AR coeffs
b = [1 1.3435 0.9025]; % MA coeffs


w = 0:0.01:pi; % frequencies to compute density
h = freqz(b,a,w); % returns frequency response
sd = abs(h).^2; % make into density 

figure(2)
plot(w,10*log(sd),'LineWidth',4);
xlabel('w','fontweight','bold');ylabel('True PSD (dB)','fontweight','bold');
title('True Power Spectral Density')
set(gcf,'color','w');
