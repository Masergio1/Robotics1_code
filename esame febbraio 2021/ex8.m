clc 
clear all

syms q1 q2 q3

p_x = cos(q1) + cos(q2 + q1) + cos(q1 + q2 + q3)
p_y = sin(q1) + sin(q2 + q1) + sin(q1 + q2 + q3)

q_0 = [-pi/9;
       11*pi/18;
       -pi/4]

q_fin = [q1;
         q2;
         -pi/2]

p_x_subs = double(subs(p_x, [q1 q2 q3], q_0.'))
p_y_subs = double(subs(p_y, [q1 q2 q3], q_0.'))

p_in = [1.6468;
        1.3651]

p_x_fin = simplify(subs(p_x, q3, -pi/2), steps = 100) == 1.6468
p_y_fin = simplify(subs(p_y, q3, -pi/2), steps = 100) == 1.3651

sol = solve([p_x_fin, p_y_fin], [q1, q2]);
q1_fin = double(sol.q1)
q1_fin = double(sol.q2)

J = jacobian([p_x, p_y], [q1, q2, q3])





