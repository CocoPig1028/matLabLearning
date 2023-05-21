function [R, R_Eul2ang] = fnc_rot(phi, theta, psi)

C_phi = cosd(phi);
C_theta = cosd(theta);
C_psi = cosd(psi);

S_phi = sind(phi);
S_theta = sind(theta);
S_psi = sind(psi);

R = [(C_psi*C_theta - S_phi*S_psi*S_theta), (-C_phi*S_psi),...
    (C_psi*S_theta + C_theta*S_phi*S_psi);
    (C_theta*S_psi + C_psi*S_phi*S_theta), (C_phi*C_psi),...
    (S_psi*S_theta - C_psi*C_theta*S_phi);
    (-C_phi*S_theta), (S_phi), (C_phi*C_theta)];

R_Eul2ang = [C_theta, 0 (-C_phi*S_theta);
    0, 1, S_phi;
    S_theta, 0, (C_phi*C_theta)];