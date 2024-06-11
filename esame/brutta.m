clc
clear all
syms alpha d  a  theta q1 q2 q3 r h0 h v t

clear all
clc
syms alpha d  a  theta q1 q2 q3
%% number of joints
N=3;
%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!
DHTABLE = [ pi/2,   0,   0.7,  q1;
           0,      0.5,  0,   q2;
           0    0.5,  0    q3; ];
       
TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
       sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
         0             sin(alpha)             cos(alpha)            d;
         0               0                      0                   1];
A = cell(1,N);
for i = 1:N
   alpha = DHTABLE(i,1);
   a = DHTABLE(i,2);
   d = DHTABLE(i,3);
   theta = DHTABLE(i,4);
   A{i} = subs(TDH);
end
T = eye(4);
for i=1:N
   T = T*A{i};
   T = simplify(T);
end
T0N = T;
p = T(1:3,4);
n = T(1:3,1);
s = T(1:3,2);
a = T(1:3,3);
A_0_1 = A{1};
A_0_2 = A{1} * A{2};
A_0_3 = A{1} * A{2} * A{3};
p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);
p_0_E = p_03;
p_1_E = p_03 - p_01;
p_2_E = p_03 - p_02;
R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3);
z_0 = [0;
      0;
      1];
z_1 = simplify(R_0_1*z_0, Steps=100);
z_2 = simplify(R_0_2*z_0, Steps=100);
z_3 = simplify(R_0_3*z_0, Steps=100);
p_z_0 = simplify(cross(z_0, p_0_E), steps = 100);
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100);
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100);
J_L_A = [p_z_0, p_z_1, p_z_2;
        z_0, z_1, z_2;]
simplify(det(J_L_A.'*J_L_A),steps=100)
