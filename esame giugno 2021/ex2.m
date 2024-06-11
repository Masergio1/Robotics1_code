clc
clear all
 
syms q1 q2 q3 L px py

P = [q2 * cos(q1) + L * cos(q1 + q3);
     q2 * sin(q1) + L * sin(q1 + q3);
     q1 + q3]
 
J = simplify(jacobian(P, [q1 q2 q3]), steps = 100)

v = [0 ; -2.5; 0]
 
q_dot = simplify(inv(J) * v, steps = 100)

%inverse kinematic on the ipad
%subs of q
q_dot_subs = double(subs(q_dot, [q1, q2, q3, L], [0.4636, 2.2361, -2.0344, 0.6]))

% %second task
F = [15; 0; 6]

tau = double(subs(-J.' * F, [q1 q2 q3 L], [0.4636 2.2361 -2.0344 0.6]))
