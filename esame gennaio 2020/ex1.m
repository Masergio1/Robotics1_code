clear all
clc

syms alpha d d3 d7 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6 q7

%% number of joints 
N=7;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [  pi/2   0      0        q1;
            -pi/2   0      d2       q2;
             pi/2   0      d3       q3;
                0   a4     0        q4;
            -pi/2   0      0        q5;
             pi/2   0      0        q6;
                0   0      d7       q7]

         
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

A_0_5 = A{1} * A{2} * A{3} * A{4} * A{5} 

A_0_6 = A{1} * A{2} * A{3} * A{4} * A{5} * A{6}

A_0_7 = A{1} * A{2} * A{3} * A{4} * A{5} * A{6} * A{7}

p_01 = A_0_1(1:3, end)
p_02 = A_0_2(1:3, end)
p_03 = A_0_3(1:3, end)
p_04 = A_0_4(1:3, end)
p_05 = A_0_5(1:3, end)
p_06 = A_0_6(1:3, end)
p_07 = A_0_7(1:3, end)

p_0_E = p_07
p_1_E = p_07 - p_01
p_2_E = p_07 - p_02
p_3_E = p_07 - p_03
p_4_E = p_07 - p_04
p_5_E = p_07 - p_05
p_6_E = p_07 - p_06

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = A_0_2(1:3, 1:3)
R_0_3 = A_0_3(1:3, 1:3)
R_0_4 = A_0_4(1:3, 1:3)
R_0_5 = A_0_5(1:3, 1:3)
R_0_6 = A_0_6(1:3, 1:3)
R_0_7 = A_0_7(1:3, 1:3)

z_0 = [0;
       0;
       1]

z_1 = simplify(R_0_1*z_0, Steps=100)
z_2 = simplify(R_0_2*z_0, Steps=100)
z_3 = simplify(R_0_3*z_0, Steps=100)
z_4 = simplify(R_0_4*z_0, Steps=100)
z_5 = simplify(R_0_5*z_0, Steps=100)
z_6 = simplify(R_0_6*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100)
p_z_3 = simplify(cross(z_3, p_3_E), steps = 100)
p_z_4 = simplify(cross(z_4, p_4_E), steps = 100)
p_z_5 = simplify(cross(z_5, p_5_E), steps = 100)
p_z_6 = simplify(cross(z_6, p_6_E), steps = 100)

J_L_A = [p_z_0, p_z_1, p_z_2, p_z_3, p_z_4, p_z_5, p_z_6;
         z_0, z_1, z_2, z_3, z_4, z_5, z_6]

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

rotation_mid_frame_5 = [R_0_5, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_5]

rotation_mid_frame_6 = [R_0_6, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_6]

rotation_mid_frame_7 = [R_0_7, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_7]

J_L_A_mid_frame_1 = simplify(rotation_mid_frame_1.' * J_L_A, steps=100)
J_L_A_mid_frame_2 = simplify(rotation_mid_frame_2.' * J_L_A, steps=100)
J_L_A_mid_frame_3 = simplify(rotation_mid_frame_3.' * J_L_A, steps=100)
J_L_A_mid_frame_4 = simplify(rotation_mid_frame_4.' * J_L_A, steps=100)
J_L_A_mid_frame_5 = simplify(rotation_mid_frame_5.' * J_L_A, steps=100)
J_L_A_mid_frame_6 = simplify(rotation_mid_frame_6.' * J_L_A, steps=100)
J_L_A_mid_frame_7 = simplify(rotation_mid_frame_7.' * J_L_A, steps=100)














