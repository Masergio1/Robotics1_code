clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6 Lb La q1_dot q2_dot q3_dot q4_dot

%% number of joints 
N=4;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [  0     0   q1    0;
           -pi/2   0   0    q2;
            pi/2   0   La   q3;
            0      Lb  0    q4];

         
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
    disp(i)
    disp(A{i})
end


T = eye(4);

for i=1:N 
    T = T*A{i};
    T = simplify(T);
end

T0N = T

p = T(1:3,4)

n = T(1:3,1)

s = T(1:3,2)

a = T(1:3,3)

A_0_1 = A{1}

A_0_2 = A{1} * A{2}

A_0_3 = A{1} * A{2} * A{3}

A_0_4 = A{1} * A{2} * A{3} * A{4}

p_01 = A_0_1(1:3, end)
p_02 = A_0_2(1:3, end)
p_03 = A_0_3(1:3, end)
p_04 = A_0_4(1:3, end)

p_04_subs_1 = subs(p_04,[q1,q2,q3,q4,La,Lb],[0,0,0,0,0.5,0.75])
p_04_subs_2 = subs(p_04,[q1,q2,q3,q4,La,Lb],[1,0,-pi/2,pi/2,0.5,0.75])


%% punto b
p_0_E = p_04
p_1_E = p_04 - p_01
p_2_E = p_04 - p_02
p_3_E = p_04 - p_03

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = A_0_2(1:3, 1:3)
R_0_3 = A_0_3(1:3, 1:3)
R_0_4 = A_0_4(1:3, 1:3)

z_0 = [0;
       0;
       1]

z_1 = simplify(R_0_1*z_0, Steps=100)
z_2 = simplify(R_0_2*z_0, Steps=100)
z_3 = simplify(R_0_3*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100)
p_z_3 = simplify(cross(z_3, p_3_E), steps = 100)

J_L_A = [z_0, p_z_1, p_z_2, p_z_3;
         [0;0;0], z_1, z_2, z_3]

rotation_mid_frame_1 = [R_0_1, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_1]


rotation_mid_frame_2 = [R_0_2, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_2]



rotation_mid_frame_3 = [R_0_3, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_3]



rotation_mid_frame_4 = [R_0_4, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_4]



J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
J_L_A_mid_frame_3 = simplify(rotation_mid_frame_3.' * J_L_A, steps=100)
J_L_A_mid_frame_4 = simplify(rotation_mid_frame_4.' * J_L_A, steps=100)

F = [0;0;1]

tau_mid_frame_4 = J_L_A_mid_frame_4(1:3, 1:4).'*F

tau_mid_frame_4_subs_1 = subs(tau_mid_frame_4, [q1,q2,q3,q4,La,Lb],[0,0,0,0,0.5,0.75])
tau_mid_frame_4_subs_2 = subs(tau_mid_frame_4, [q1,q2,q3,q4,La,Lb],[1,0,-pi/2,pi/2,0.5,0.75])

%% punto c
J_A = J_L_A(4:6, 1:4)

det_J_A = simplify(det(J_A*J_A.'), Steps=100)

null_space_1 = null(subs(J_A,q3,0))
null_space_2 = null(subs(J_A,q3,pi))

q_dot = [q1_dot; q2_dot; q3_dot; q4_dot]

omega = J_A*q_dot
















