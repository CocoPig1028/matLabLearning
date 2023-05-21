function [u] = fnc_cont_alt(h, h_cmd)
err = h_cmd - h;

K_p = -200;

u = K_p * err;