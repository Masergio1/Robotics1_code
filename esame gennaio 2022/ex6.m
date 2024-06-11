clc
clear all 

syms l1 l2 q1 q2 a b v t

% domanda 2
p_x = a
p_y = b

c2 = subs(((0^2 + b^2 - (a^2 + b^2))/(2 * a * b)), [a , b], [1, 0.6])

s2_1 = sqrt(1 - c2^2)
s2_2 = -sqrt(1 - c2^2)

q2_1 = simplify(atan2(s2_1, c2), steps = 100)
q2_2 = simplify(atan2(s2_2, c2), steps = 100)

q1_1 = simplify(atan2(p_y, p_x) - atan2(b * s2_1, a + b * c2), steps = 100)
q1_2 = simplify(atan2(p_y, p_x) - atan2(b * s2_2, a + b * c2), steps = 100)

q1_1 = subs(q1_1, [a, b], [1, 0.6])
q1_2 = subs(q1_2, [a, b], [1, 0.6])

%domanda 3
p_x = (a * cos(q1)) + (b * cos(q1 + q2))
p_y = (a * sin(q1)) + (b * sin(q1 + q2))

J = jacobian([p_x ; p_y], [q1, q2])

p_dot = [-2* a* v* pi * cos(2* pi * v * t);
         -2* b* v* pi * sin(2* pi * v * t)]

q_dot = double(simplify(subs(inv(J) *  p_dot, [q1, q2, v, a, b, t], [0.9851, 2.5559, 0.4, 1, 0.6, 0]), steps = 100))

%domanda 4
%i can use the same code of point 2 to calculate the angles q_generic
P_d_0 = [0 ; b]

P_d_q_generic = [a * cos(q1)  + b * cos(q1 + q2);
                 a * sin(q1)  + b * sin(q1 + q2);]

P_d_q_generic = subs(P_d_q_generic, [q1 , q2], [0 , pi/2])

error = P_d_0 - P_d_q_generic

%domanda 5

