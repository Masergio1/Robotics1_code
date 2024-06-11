clc 
clear all

syms alpha beta gamma

R_y = [cos(alpha), 0, sin(alpha);
       0,          1, 0;
      -sin(alpha), 0, cos(alpha)];

R_x = [1, 0,          0;
       0, cos(beta), -sin(beta);
       0, sin(beta), cos(beta)];

R_z = [cos(gamma), -sin(gamma), 0;
       sin(gamma), cos(gamma),  0;
       0,          0,           1];

R = [0,         1, 0;
     0.5,       0, sqrt(3)/2;
     sqrt(3)/2, 0, -0.5];

R_tot = simplify(R_y * R_x * R_z, steps = 100)

beta_sin = -R(2,3)
beta_cos_piu = sqrt((R(1,3))^2 + (R(3,3))^2)
beta_cos_meno = -sqrt((R(1,3))^2 + (R(3,3))^2)

beta_pos = atan2(beta_sin, beta_cos_piu)
beta_neg = atan2(beta_sin, beta_cos_meno)

gamma_pos = atan2(R(2,1)/cos(beta_pos), R(2,2)/cos(beta_pos))
gamma_neg = atan2(R(2,1)/cos(beta_neg), R(2,2)/cos(beta_neg))

alfa_pos = atan2(R(1,3)/cos(beta_pos), R(3,3)/cos(beta_pos))
alfa_neg = atan2(R(1,3)/cos(beta_neg), R(3,3)/cos(beta_neg))

det_R = simplify(det(R_tot), steps = 100)
rango_R = rank(R_tot)

R_tot_2 = subs(R_tot, [alpha, beta], [pi/2, 0])

rango_R_2 = rank(subs(R_tot, [alpha, beta], [0, pi/2])) 