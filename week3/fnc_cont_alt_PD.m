function [u] = fnc_cont_alt_PD(h, h_dot, h_cmd)
h_cmd_dot = 0;
err = h_cmd - h;
err_dot = h_cmd_dot - h_dot;

K_p = -100;

K_d = -100;

u = K_p * err + K_d * err_dot;