%% Setup the plant
s = tf('s');
P = -1.202*(s-1)/(s*(s+9)*(s^2+12*s+56.25));
figure; 
subplot(2,1,1);
step(P,10);
title('Open-loop step response');

%% Design the PID controller
% Kp = 10;
% Ki = 10;
% Kd = 0;
% C = pid(Kp,Ki,Kd);
C = (s*(s+9)*(s^2+12*s+56.25))/(s-1)*(s-2);
H = feedback(C*P,1);
S = stepinfo(H);
ts = S.SettlingTime;
tr = S.RiseTime;
Mo = S.SettlingMax;
ess = 0;

%% Simulate the closed-loop step response
figure; 
subplot(2,1,2);
step(H,10);
title('Closed-loop step response');
J = 10*tr + ts + 20*Mo + 100*ess;
