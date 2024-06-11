%% DH transformation matrices and direct kinematics 

clear all
clc

%% Define symbolic variables

syms alpha d d1 a a1 a2 a3 theta q1 q2 q3 D

assume(a1, 'positive')
assume(a2, 'positive')
assume(a3, 'positive')
assume(d1, 'positive')

%% number of joints 

N=3;

%% Insert DH table of parameters

DHTABLE = [ pi/2     d1    a1   q1;
            0        0     a2   q2;
            pi/2     0     a3   q3];

         
%% Build the general Denavit-Hartenberg trasformation matrix

TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
        sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
          0             sin(alpha)             cos(alpha)            d;
          0               0                      0                   1];

%% Build transformation matrices for each link
% First, we create an empty cell array

A = cell(1,N);

% For every row in 'DHTABLE' we substitute the right value inside
% the general DH matrix

disp('Printing the single A_i matrices:')

for i = 1:N
    % subs use alpha, a, d, and theta extracted from the DHTABLE 
    alpha = DHTABLE(i,1);
    d = DHTABLE(i,2);
    a = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = subs(TDH);
    disp(i)
    disp(A{i})
end

% at the end of this loop A should contains, for each i in N
% in position i the tranformation matrix from frame i to i + 1


%% Direct kinematics

disp('Direct kinematics of the robot in symbolic form (simplifications may need some time)')

disp(['Number of joints N=',num2str(N)])

% Note: 'simplify' may need some time

% eye(n) returns the n-by-n identity matrix
T = eye(4);

for i=1:N 
    T = T*A{i};
    T = simplify(T);
end

% output TN matrix
% T-O-N because it goes from frame 0 to frame N
T0N = T

% output ON position
% this is the position of the end-effector
% expressed in the base frame 0
p = T(1:3,4)

% output xN axis

n=T(1:3,1)

% output yN axis

s=T(1:3,2)

% output zN axis

a=T(1:3,3)

A_0_1 = A{1}

A_0_2 = A{1} * A{2}

A_0_3 = A{1} * A{2} * A{3}

% Extract the last column and the first three rows
p_01 = A_0_1(1:3, end)
p_02 = A_0_2(1:3, end)
p_03 = A_0_3(1:3, end)

p_0_E = p_03
p_1_E = p_03 - p_01
p_2_E = p_03 - p_02

R_0_1 = A_0_1(1:3, 1:3)
R_0_2 = A_0_2(1:3, 1:3)
R_0_3 = A_0_3(1:3, 1:3)

z_0 = [0;
       0;
       1]
z_1 = simplify(R_0_1*z_0, Steps=100)
z_2 = simplify(R_0_2*z_0, Steps=100)

p_z_0 = simplify(cross(z_0, p_0_E), steps = 100)
p_z_1 = simplify(cross(z_1, p_1_E), steps = 100)
p_z_2 = simplify(cross(z_2, p_2_E), steps = 100)

J_L_A = [p_z_0, p_z_1, p_z_2;
         z_0, z_1, z_2]

J_L = [p_z_0, p_z_1, p_z_2]

%domanda 2
J_L_det = simplify(det(J_L), steps = 100)

% Elimina la colonna 1 e ottieni una matrice 3x2
matrice_senza_colonna1 = J_L(:, [2 3]);

% Elimina la colonna 2 e ottieni una matrice 3x2
matrice_senza_colonna2 = J_L(:, [1 3]);

% Elimina la colonna 3 e ottieni una matrice 3x2
matrice_senza_colonna3 = J_L(:, [1 2]);

J_L_1 = simplify(det(matrice_senza_colonna1.' * matrice_senza_colonna1), steps = 100)
J_L_2 = simplify(det(matrice_senza_colonna2.' * matrice_senza_colonna2), steps = 100)
J_L_3 = simplify(det(matrice_senza_colonna3.' * matrice_senza_colonna3), steps = 100)

J_L_2_0 = simplify(subs(J_L_2, q3, 0), steps = 100)
J_L_2_pi = simplify(subs(J_L_2, q3, pi), steps = 100)
J_L_3_0 = simplify(subs(J_L_3, q3, 0), steps = 100)
J_L_3_pi = simplify(subs(J_L_3, q3, pi), steps = 100)

J_L_2_0 = simplify(solve(J_L_2_0 == 0, q2), steps = 100)
J_L_2_pi = simplify(solve(J_L_2_pi == 0, q2), steps = 100)
J_L_3_0 = simplify(solve(J_L_3_0 == 0, q2), steps = 100)
J_L_3_pi = simplify(solve(J_L_3_pi == 0, q2), steps = 100)

%domanda 3
J_A = [z_0, z_1, z_2]

J_A_rango = rank(J_A)

%prima e seconda colonna sono tutte le direzioni ammissibili per la
%velocita angolare (W)

%domanda 4
p_3 = [ 0; 0; D]

%soluzione professore(io e fra ci fidiamo del goat de luca)
p_A0 = simplify(A_0_3 * [p_3; 1], steps = 100)
%p_A0 = double(simplify(subs(p_A0, [q1 , q2, q3, D, a1, a2, a3, d1], [0 , pi/2, 0, 0.52, 0.04, 0.445, 0.04, 0.33]),steps = 100))

%domanda 5
p_A0 = p_A0([1 2 3], :)
J_D = jacobian(p_A0, [q1, q2, q3])

J_D = simplify(subs(J_D, [q1 , q2, q3, D, a1, a2, a3, d1], [0 , pi/2, 0, 0.52, 0.04, 0.445, 0.04, 0.33]), steps = 100)

q_dot = [0 ; pi/4; pi/2]

v_d = double(J_D * q_dot)


