clc
clear all

syms epsilon q1 q2 a

p_x = q2 * cos(q1);
p_y = q2 * sin(q1);

q0 = [pi/4 ; epsilon];

J = jacobian([p_x, p_y], [q1 q2]);

J_subs = subs(J, [q1 , q2], [pi/4 , epsilon]);
p_d1 = [-1 ; 1];
p_d2 = [1 ; 1];

p = [p_x ; p_y];

k = 1;

%Newton method
J_inv = inv(J_subs);
qk = q0;
for i= 1:k
    J_inv_num = subs(J_inv, [q1 q2], [qk(1) qk(2)] );
    p_qk = subs(p, [q1 q2], [qk(1) qk(2)]);
    qk = qk + J_inv_num*(p_d1 - p_qk);
end
solution_N_1 = simplify(qk, steps = 100)

%Newton method
J_inv = inv(J_subs);
qk = q0;
for i= 1:k
    J_inv_num = subs(J_inv, [q1 q2], [qk(1) qk(2)]);
    p_qk = subs(p, [q1 q2], [qk(1) qk(2)]);
    qk = qk + J_inv_num*(p_d2 - p_qk);
end
solution_N_2 = simplify(qk, steps = 100)

%Gradient Method
%controllare se la soluzione fa parte del null space della J in tal caso va
%stoppato
J_t= transpose(J);
qk = q0;
for i= 1:k
    J_t_num = subs(J_t, [q1 q2], [qk(1) qk(2)] );
    p_qk = subs(p, [q1 q2], [qk(1) qk(2)]);
    qk = qk + a*J_t_num*(p_d1 - p_qk);
end
solution_G_1 = simplify(qk, steps  = 100)
 
J_t= transpose(J);
qk = q0;
for i= 1:k
    J_t_num = subs(J_t, [q1 q2], [qk(1) qk(2)] );
    p_qk = subs(p, [q1 q2], [qk(1) qk(2)]);
    qk = qk + a*J_t_num*(p_d2 - p_qk);
end
solution_G_2 = simplify(qk, steps  = 100)

%dovremmo fare altro ma non mi va, per N method la epsilon = 0 fa si che q1
%sol diverga, per G method invece dovrei calcolare il rank e il null space
%in modo da risolvere il problema e bla bla bla
