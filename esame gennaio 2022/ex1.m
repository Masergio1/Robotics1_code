clear all
clc

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6 D K psi alpha

%% number of joints 
N=3;


%% PAY ATTENTION TO THE POSITION OF
%% a and d: a is the second column
%% d the third!

DHTABLE = [ -pi/2   K   0    q1;
             pi/2   0   q2   0;
              0     D   0    q3];

         
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

T0N = T;

p = T(1:3,4);

n = T(1:3,1);

s = T(1:3,2);

a = T(1:3,3);

A_0_1 = A{1};

A_0_2 = A{1} * A{2};

A_0_3 = simplify(A{1} * A{2} * A{3}, steps=100);

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);

p_03_subs = subs(p_03,[q1,q2,q3],[0,0,0])

p_0_E = p_03
p_1_E = p_03 - p_01;
p_2_E = p_03 - p_02;

R_0_1 = A_0_1(1:3, 1:3);
R_0_2 = A_0_2(1:3, 1:3);
R_0_3 = A_0_3(1:3, 1:3)

R_0_3_subs = subs(R_0_3,[q1,q2,q3],[0,0,0]) 

z_0 = [0;
       0;
       1];

z_1 = simplify(R_0_1*z_0, Steps=100);
z_2 = simplify(R_0_2*z_0, Steps=100);

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100);
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100);
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100);

%% TO MODIFY BASED ON THE TYPE OF JOINTS
J_L_A = [p_z_0, z_1, p_z_2;
         z_0, [0;0;0], z_2]


rotation_mid_frame_1 = [R_0_1, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_1];


rotation_mid_frame_2 = [R_0_2, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_2];



rotation_mid_frame_3 = [R_0_3, [0, 0, 0; 
                                  0, 0, 0; 
                                  0, 0, 0;];
                        [0, 0, 0; 
                         0, 0, 0; 
                         0, 0, 0;], R_0_3];


% Matrice di rotazione intorno all'asse z
Rz = [cos(psi), -sin(psi), 0;
      sin(psi), cos(psi), 0;
      0, 0, 1];

% Matrice di rotazione intorno all'asse y
Ry = [cos(pi/2), 0, sin(pi/2);
      0, 1, 0;
      -sin(pi/2), 0, cos(pi/2)];

R_zy = Rz*Ry

% Matrice di rotazione intorno all'asse x per alpha
Rx1 = [1, 0, 0;
       0, cos(a1), -sin(a1);
       0, sin(a1), cos(a1)];

% Matrice di rotazione intorno all'asse y per beta
Ry = [cos(a2), 0, sin(a2);
      0, 1, 0;
      -sin(a2), 0, cos(a2)];

% Matrice di rotazione intorno all'asse x per gamma
Rx2 = [1, 0, 0;
       0, cos(a3), -sin(a3);
       0, sin(a3), cos(a3)];

% Matrice di rotazione totale
RXYX = Rx1 * Ry * Rx2

R_strana = [0    1/sqrt(2)   1/sqrt(2);
            0    1/sqrt(2)  -1/sqrt(2);
            -1      0           0     ];

r_11 = R_strana(1,1);
r_12 = R_strana(1,2);
r_13 = R_strana(1,3);
r_21 = R_strana(2,1);
r_31 = R_strana(3,1);

a2_pos = atan2(+sqrt((r_21)^2+(r_31)^2),r_11);
a2_neg = atan2(-sqrt((r_21)^2+(r_31)^2),r_11);

a3_pos = atan2(r_12/sin(a2_pos), r_13/sin(a2_pos));
a3_neg = atan2(r_12/sin(a2_neg), r_13/sin(a2_neg));

a1_pos = atan2(r_21/sin(a2_pos), -r_31/sin(a2_pos));
a1_neg = atan2(r_21/sin(a2_neg), -r_31/sin(a2_neg));

disp("angles: ")
disp("alpha 1 I: "+a1_pos)
disp("alpha 2 I: "+a2_pos)
disp("alpha 3 I: "+a3_pos)
disp(" ")
disp("alpha 1 II: "+a1_neg)
disp("alpha 2 II: "+a2_neg)
disp("alpha 3 II: "+a3_neg)
