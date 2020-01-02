clc;clear;close all;

%% System Identification Experiment Data
load FreqDataP

figure
scatter(log10(freq_data), 20*log10(mag_data), 10, 'r','filled'); grid on; % Experiment Data
title('Experiment Data of System Identification');
xlabel('Frequncy (log scale) [Hz]');ylabel('magnitude [dB]');
grid on;

%% Parameter setup
P = zpk([],[],0);      % unknown plant  
F = zpk([-0.001, 0, -50],[-0.1, -10,-10],1);      % Feedforward controller
%F = zpk([],[],0); 
%C = zpk([-0.001, 0, -50],[-0.1, -10, -10],1);      % Feedback controller
C = zpk([],[],0); 

%% Reference setup [DO NOT TOUCH]
load ref_R40 -ascii
Ts = 0.001;
t = 0:Ts:(length(ref_R40)-1)*Ts;
ref = timeseries(ref_R40-ref_R40(1),t);



%% Run simulation
sim('CtrlSyst_Comp2');
figure;
subplot(3,1,1);
plot(t,r,'g'); hold on;
plot(t,y,'b');
xlabel('Time (s)'); ylabel('Position (mm)');
legend('reference r','output y');

subplot(3,1,2);
plot(t,r-y,'b'); 
xlabel('Time (s)'); ylabel('Error (mm)');
legend('tracking error e=r-y');

subplot(3,1,3);
plot(t,u,'r'); 
xlabel('Time (s)'); ylabel('Input voltage (mV)');
legend('control input u');



%% Cost function [DO NOT TOUCH]
TrackingError = rms(r-y);
InputEnergy = sum(u.^2);
Cost = (1000*TrackingError+InputEnergy/(10^7))
