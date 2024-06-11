clc
clear all

syms 

%% DH transformation matrices and direct kinematics 

clear all
clc

%% Define symbolic variables

syms alpha d d1 d2 d4 d6 a a1 a2 a3 a4 theta q1 q2 q3 q4 q5 q6

%% number of joints 

N=3;

%% Insert DH table of parameters

DHTABLE = [ pi/2  d1    0    q1;
            pi/2  q2    0    pi/2;
            0     0     a3   q3];

         
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

%se chiede velocità angolare w uso analitica
p_x = p_03(1)
p_y = p_03(2)
p_z = p_03(3)

J = simplify(jacobian(p_03, [q1 q2 q3]), steps = 100)

J_det = simplify(det(J), steps = 100)

J_q2_0 = simplify(subs(J, q2, -a3*sin(q3)))
J_q20_rank = rank(J_q2_0)
J_q20_null = null(J_q2_0)
J_q20_range = colspace(J_q2_0)
J_q20_comp = null(J_q2_0.')

J_q3_0 = simplify(subs(J, q3, 0))
J_q30_rank = rank(J_q3_0)
J_q30_null = null(J_q3_0)
J_q30_range = colspace(J_q3_0)
J_q30_comp = null(J_q3_0.')

J_q3_q2_0 = simplify(subs(J, [q2 q3], [0 0]))
J_q230_rank = rank(J_q3_q2_0)
J_q230_null = null(J_q3_q2_0)
J_q230_range = colspace(J_q3_q2_0)
J_q230_comp = null(J_q3_q2_0.')










