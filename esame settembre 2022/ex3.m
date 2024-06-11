clc
clear all

syms q1 q2 q3 L q1_dot q2_dot q3_dot q1_dot_dot q2_dot_dot q3_dot_dot

r = [q2 * cos(q1) + L * cos(q1 + q3);
     q2 * sin(q1) + L * sin(q1 + q3);
     q1 + q3];

J = simplify(jacobian(r, [q1 q2 q3]),steps = 100)

J_det = simplify(det(J), steps = 100)

%domanda 2
J_q2 = simplify(subs(J, q2, 0))

J_q2_range = simplify(colspace(J_q2), steps = 100)

%domanda 3
%J_null = simplify(null(J), steps = 100)

J_q2_null = simplify(null(J_q2), steps = 100)

%domanda 4
q = [q1; q2; q3]
q_dot = [q1_dot; q2_dot; q3_dot]
q_dot_dot = [q1_dot_dot; q2_dot_dot; q3_dot_dot]

dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
simplify(J_dot, steps = 100)

q_dot = [1; -1; -1]

J_q_dot = J_dot * q_dot

q_dot_dot = simplify(-inv(J) * J_q_dot, steps = 100)

q_dot_dot = subs(q_dot_dot, [q1 q2 q3 q1_dot q2_dot q3_dot], [pi/2 1 0 1 -1 -1])



