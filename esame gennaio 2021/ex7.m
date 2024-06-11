clc
clear all

syms q1 q2 q3 q4 F

%tau A
p_x_A = cos(q1) + cos(q1 + q2)
p_y_A = sin(q1) + sin(q1 + q2)

J_A = jacobian([p_x_A, p_y_A], [q1, q2])
J_A_subs = double(simplify(subs(J_A, [q1, q2], [3*pi/4, -pi/2]), steps = 100))

F_A = F * [cos(q1 + q2); sin(q1 + q2)]
F_A_subs = subs(F_A, [q1, q2, F], [3*pi/4, -pi/2, 10])
tau_A = J_A_subs.' * F_A_subs

%tau B
p_x_B = cos(q3) + cos(q3 + q4)
p_y_B = sin(q3) + sin(q3 + q4)

J_B = jacobian([p_x_B, p_y_B], [q3, q4])
J_B_subs = double(simplify(subs(J_B, [q3, q4], [pi/2, -pi/2]), steps = 100))

R_A_B = [cos(pi) , -sin(pi);
         sin(pi) , cos(pi)];

F_B_subs = R_A_B * -F_A_subs

tau_B = double(simplify(J_B_subs.' * F_B_subs, steps = 100))
