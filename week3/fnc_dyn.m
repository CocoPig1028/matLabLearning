function [r_ddot, x_pqr_dot, Euler_dot] = fnc_dyn(x, u)
% known parameters
I_xx = 6*10^-3; %[kg m^2]
I_yy = I_xx; %[kg m^2]
I_zz = 12*10^-3; %[kg m^2]

I = [I_xx 0 0;
    0 I_yy 0;
    0 0 I_zz];

m = 0.8; %[kg]
L = 0.5; %[m]
g = 9.81; %[m/sec^2]


% state variables
p = x(1); % [deg/s]
q = x(2); % [deg/s]
r = x(3); % [deg/s]
phi = x(4); % [deg]
theta = x(5); % [deg]
psi = x(6); % [deg]

% input variables
omega(1) = u(1); %[rpm]
omega(2) = u(2); %[rpm]
omega(3) = u(3); %[rpm]
omega(4) = u(4); %[rpm]

% known values
k_F = 6.11*10^-8; %[N/rpm^2]
k_M = 1.5*10^-9; %[Nm/rpm^2]


for i = 1:4
    F(i) = k_F*omega(i)^2;
    M(i) = k_M*omega(i)^2;
end

G = [L*(F(2) - F(4));
    L*(F(3) - F(1));
    M(1)-M(2)+M(3)-M(4)];

x_pqr = [p, q, r]';

% Eqn.2
x_pqr_dot = inv(I) * (G - cross(x_pqr, I*x_pqr));

[R, R_Eul2ang] = fnc_rot(phi, theta, psi);

Euler_dot = inv(R_Eul2ang)*x_pqr;

% Eqn.1
r_ddot = [0, 0, -m*g]'/m + R*[0, 0, sum(F)]'/m;

