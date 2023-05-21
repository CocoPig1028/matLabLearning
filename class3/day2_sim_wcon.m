close all; clear all; clc;

% phi = 50
% theta = 0
% psi = 0
% R = fnc_rot(phi,theta,psi)

p(1) = 0;
q(1) = 0;
r(1) = 0;
phi(1) = 0;
theta(1) = 0;
psi(1) = 0;

omega1(1) = 2000;
omega2(1) = 2000;
omega3(1) = 2000;
omega4(1) = 2000;
u(:,1) = [omega1(1), omega2(1), omega3(1), omega4(1)]';

vel(:,1) = [0, 0, 0]';
pos(:,1) = [0, 0, 0]';
acc(:,1) = [0, 0, 0]';
pqr(:,1) = [p(1), q(1), r(1)]';
ptp(:,1) = [phi(1), theta(1), psi(1)]';

dt = 0.01;
t = 0:dt:100;

for i = 1:length(t)
    h_cmd(i) = 10;
    h(i) = pos(3,i);
    h_dot(i) = vel(3,i);

    u_ctl(i) = fnc_cont_alt_PD(h(i),h_dot(i),h_cmd(i));
    u(:,i) = ones(4,1)*u_ctl(i);

    x(:,i)=[pqr(:,i); ptp(:,i)];
    [acc(:,i), pqr_dot(:,i), ptp_dot(:,i)] = fnc_dyn(x(:,i),u(:,i));

    vel(:,i+1) = acc(:,i)*dt + vel(:,i);
    pos(:,i+1) = vel(:,i)*dt + pos(:,i);
    pqr(:,i+1) = pqr_dot(:,i)*dt + pqr(:,i);
    ptp(:,i+1) = ptp_dot(:,i)*dt + ptp(:,i);
end
figure()
plot(t,pos(3,1:end-1))
% figure()
% plot(t,u(1,:))
% figure()
% plot(t,h_cmd-h)
