clc
clear all

syms K  q1 q2 q3 D gamma

%domanda 1
r = [K* cos(q1) - q2 * sin(q1) + D * cos(q1 + q3);
     K* sin(q1) + q2 * cos(q1) + D * sin(q1 + q3);
     q1 + q3]

J_L_A = jacobian(r, [q1, q2, q3])

%domanda 2
singularity = simplify(det(J_L_A), steps = 100)

%domanda 3
J_L_A_sing = simplify(subs(J_L_A, q2 , 0),steps = 100)
J_L_A_null_space = simplify(null(J_L_A_sing), Steps = 100)

% for the range i need to compute the rank to obtain my range space
rank_J = rank(J_L_A_sing)
rank_J = rank(J_L_A_sing(:, 1:2))

%domanda 4
J_L_A_sobs = subs(J_L_A_sing, [K, D], [1, sqrt(2)])

r_dot = gamma * [-sin(q1);
                cos(q1);
                0]

inversA=simplify(inv(J_L_A_sobs.'* J_L_A_sobs)*J_L_A_sobs.',steps=100)

fine = linsolve(inversA,r_dot)

