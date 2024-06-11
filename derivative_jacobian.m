
%% initialization

syms q1 q2 q3 real
syms q1_dot q2_dot q3_dot real

q = [q1 q2 q3];
q_dot = [q1_dot q2_dot q3_dot]

px = cos(q1) + cos(q1+q2) + cos(q1+q2+q3);
py = sin(q1) + sin(q1+q2) + sin(q1+q2+q3);



%% computing jacobian

J = jacobian([px, py], [q1, q2, q3]);
J = simplify(J, steps = 10)



%% derivative of jacobian

dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));

for i = 1:dim(1)
    J_dot(i,:) = diff(J(i,:), q(i));
end

J_dot = J_dot.*[q_dot; q_dot];
J_dot = simplify(J_dot, steps = 10)



%% n(q, q_dot)

J_dot_q_dot = J_dot * q_dot.';
J_dot_q_dot = simplify(J_dot_q_dot, steps = 10)
