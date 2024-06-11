clc
clear all

%domanda 1
syms a b q1 q2 q3 q4 

p_x = a * cos(q1) + q3 * cos(q1 + q2) + b * cos(q1 + q2 + q4);
p_y = a * sin(q1) + q3 * sin(q1 + q2) + b * sin(q1 + q2 + q4);
phi = q1 + q2 + q4;

J = jacobian([p_x, p_y, phi], [q1, q2, q3, q4])

J_sing = simplify(det(J * J.'), steps = 1000)

J_1 = J(:, 2:end);
J_2 = J(:, [1, 3, 4]);
J_3 = J(:, 1:3);
J_4 = J(:, 1:3);

J_1_det = simplify(det(J_1), steps = 100)
J_2_det = simplify(det(J_2), steps = 100)
J_3_det = simplify(det(J_3), steps = 100)
J_4_det = simplify(det(J_4), steps = 100)

J_subs = simplify(subs(J, [q1, q2, q3, q4], [0, pi/2, 0, 0]), steps = 100)
J_subs_rank = rank(J_subs)
J_subs_null = null(J_subs)
J_subs_range = simplify(colspace(J_subs), steps = 100)


