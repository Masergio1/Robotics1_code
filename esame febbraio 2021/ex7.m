clc
clear all

syms s t T_time alfa beta gamma Ca0 Ca1 Ca2 Ca3 Ca4 Ca5 tau phi_in phi_f phi_vel_in

%usiamo questo metodo Euler
R_in_0 = [0.5 , 0 , -sqrt(3)/2;
        -sqrt(3)/2, 0 , -0.5;
        0,      1 ,       0];

R_fin_T = [sqrt(2)/2 , -sqrt(2)/2 , 0;
           -0.5 , -0.5 , -sqrt(2)/2;
           0.5 , 0.5 , -sqrt(2)/2];

[phi_0_1, phi_0_2] = rotm2eul(R_in_0, "XYZ")
[phi_T_1, phi_T_2] = rotm2eul(R_fin_T, "XYZ")

omega = [3 ; -2 ; 1]

R_x = [1       0        0;
       0    cos(alfa)   -sin(alfa);
       0    sin(alfa)    cos(alfa)];

R_y = [cos(beta)     0   sin(beta);
        0	    1     0;
       -sin(beta)     0   cos(beta)];

R_z = [cos(gamma)  -sin(gamma)    0;
           sin(gamma)   cos(gamma)    0;
             0        0       1];

R_xy = R_x * R_y

R_x_2 = [0 ; cos(alfa); sin(alfa)];

R_xy_3 = [sin(beta); -sin(alfa) * cos(beta); cos(alfa)*cos(beta)]

vector = [1; 0; 0]

T = [vector,  R_x_2, R_xy_3]

% in questo caso non ci serve ad un cazzo perchè non abbiamo vincoli sulle
% singolarità
T_det = simplify(det(T), steps = 100)

%prima condizione
w_in = [0 ; 0 ; 0]
phi_0_dot = simplify(subs(inv(T), [alfa, beta, gamma], [pi/2, -pi/3, 0]) * w_in, steps = 100) 

%seconda condizione
w_fin = [3 ; -2 ; 1]
phi_T_dot = simplify(subs(inv(T), [alfa, beta, gamma], [3*pi/4, 0, pi/4]) * w_fin, steps = 100)

% %terza condizione
% w_in = [0 ; 0 ; 0]
% phi_0_dot_dot = simplify(subs(inv(T), [alfa, beta, gamma], [pi/2, -pi/3, 0]) * w_in, steps = 100)
% 
% %quarta condizione
% w_fin = [0 ; 0 ; 0]
% phi_T_dot_dot = simplify(subs(inv(T), [alfa, beta, gamma], [3*pi/4, 0, pi/4]) * w_fin, steps = 100)

%tutte le condizioni
phi_0_1 = phi_0_1
phi_T_1 = phi_T_1
phi_0_dot = inv(T) * w_in 
phi_T_dot = simplify(subs(inv(T), [alfa, beta, gamma], [3*pi/4, 0, pi/4]) * w_fin, steps = 100)
phi_0_dot_dot = [0; 0; 0]
phi_T_dot_dot = [0; 0; 0]

tau = t/T_time

phi_t = phi_in + Ca0 + Ca1 * tau + Ca2 * tau^2 +  Ca3 * tau^3 + Ca4 * tau^4 + Ca5 * tau^5
phi_vel_t = simplify(diff(phi_t, t), Steps=100)
phi_acc_t = simplify(diff(phi_vel_t, t), Steps=100)

phi_t_0 = simplify(subs(phi_t, [t], [0]), Steps = 100)
phi_t_T = simplify(subs(phi_t, [t], [T_time]), Steps = 100)

phi_vel_t_0 = simplify(subs(phi_vel_t, [t], [0]), Steps = 100)
phi_vel_t_T = simplify(subs(phi_vel_t, [t], [T_time]), Steps = 100)

phi_acc_t_0 = simplify(subs(phi_acc_t, [t], [0]), Steps = 100)
phi_acc_t_T = simplify(subs(phi_acc_t, [t], [T_time]), Steps = 100)

A = [1, 0 ,  0 , 0 , 0 , 0;
     1, 1,  1 , 1 , 1 , 1;
     1, 1/T_time, 0, 0 , 0 , 0;
     1, 1/T_time , 2/T_time , 3/T_time , 4/T_time, 5/T_time;
     1, 0 , 2/(T_time^2) , 0 , 0 , 0;
     1, 0 , 2/(T_time^2) , 6/(T_time^2) , 12/(T_time^2), 20/(T_time^2)]

B = [0
     phi_f-phi_in;
     0;
     phi_vel_in;
     0;
     0]

matrix = simplify(A\B, steps = 100)

phi_t_Ca = simplify(subs(phi_t, [Ca0, Ca1 , Ca2, Ca3,Ca4, Ca5], [0,0,0,matrix(4),matrix(5),matrix(6)]), steps = 1000)

phi_without = simplify(subs(phi_t_Ca,{phi_f,phi_in, phi_vel_in},{phi_T_1.',phi_0_1.',phi_T_dot}),steps=100)

phi_TT=simplify(subs(phi_without,T_time,1),Steps=100)

phi_T_mid=double(subs(phi_TT,t,1/2))

R_T_mid=eul2rotm(phi_T_mid.','XYZ')

phi_dot_TT=simplify(diff(subs(phi_without,T_time,1),t),Steps=100)

phi_dot_T_mid=double(subs(phi_dot_TT,t,0.5))

T_mid = double(subs(T,[alfa, beta, gamma],phi_T_mid.'))

omega_mid = T_mid * phi_dot_T_mid 

