close all; clear all; clc;

p(1) = 0;
q(1) = 0;
r(1) = 0;
phi(1) = 0;
theta(1) = 0;
psi(1) = 0;

x(:,1)=[p(1), q(1), r(1), phi(1), theta(1), psi(1)]';

vel(:,1) = [0, 0, 0]';
pos(:,1) = [0, 0, 0]';
acc(:,1) = [0, 0, 0]';
pqr(:,1) = [p(1), q(1), r(1)]';
ptp(:,1) = [phi(1), theta(1), psi(1)]';

dt = 0.01;
t = 0:dt:100;

for i = 1:length(t)
    x(:,i)=[pqr(:,i); ptp(:,i)];
    u(:,i) = ones(4,1)*8000;
    [acc(:,i), pqr_dot(:,i), ptp_dot(:,i)] = fnc_dyn(x(:,i),u(:,i));
    vel(:,i+1) = acc(:,i)*dt + vel(:,i);
    pos(:,i+1) = vel(:,i)*dt + pos(:,i);
    pqr(:,i+1) = pqr_dot(:,i)*dt + pqr(:,i);
    ptp(:,i+1) = ptp_dot(:,i)*dt + ptp(:,i);
end

plot(t,pos(3,1:end-1))
