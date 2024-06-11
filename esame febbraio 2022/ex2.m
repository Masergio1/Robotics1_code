clear all
clc

syms a1 a2 a3 phi

Ry1 = [cos(a1), 0, sin(a1);
       0, 1, 0;
       -sin(a1), 0, cos(a1)];

Rx = [1, 0, 0;
      0, cos(a2), -sin(a2);
      0, sin(a2), cos(a2)];

Ry2 = [cos(a3), 0, sin(a3);
       0, 1, 0;
       -sin(a3), 0, cos(a3)];

R_YXY = eval(subs(Ry1*Rx*Ry2, [a1,a2,a3],[pi/4,-pi/4,(2/3)*pi]))

R_0F = [0   sin(phi)   cos(phi);
        0   cos(phi)  -sin(phi);
       -1      0          0]

R_0F_subs = eval(subs(R_0F,phi,pi/3))

R = R_YXY.'*R_0F_subs

r_11 = R(1,1);
r_12 = R(1,2);
r_13 = R(1,3);
r_21 = R(2,1);
r_22 = R(2,2);
r_23 = R(2,3);
r_31 = R(3,1);
r_32 = R(3,2);
r_33 = R(3,3);

theta_pos = atan2(+sqrt((r_12-r_21)^2+(r_13-r_31)^2+(r_23-r_32)^2),r_11+r_22+r_33-1) 
theta_neg = atan2(-sqrt((r_12-r_21)^2+(r_13-r_31)^2+(r_23-r_32)^2),r_11+r_22+r_33-1) 

r_pos = (1/(2*sin(theta_pos)))*[r_32-r_23;r_13-r_31;r_21-r_12]
r_neg = (1/(2*sin(theta_neg)))*[r_32-r_23;r_13-r_31;r_21-r_12]

w = 1.1

T = theta_pos/w