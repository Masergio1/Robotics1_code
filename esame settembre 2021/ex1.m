clc
clear all

syms q1 q2 q3 L
assume(L, 'positive')

%first
P_x = q1 + L * cos(q2) + L * cos(q2 + q3)
P_y = L * sin(q2) + L * sin(q2 + q3)
theta = q2 + q3

p = [P_x; P_y; theta]

J = simplify(jacobian([P_x; P_y; theta], [q1 q2 q3]), steps = 100)

J_det = simplify(det(J), steps = 100)

%second
q  = pi/2

J_subs = simplify(subs(J, [q2], q), steps = 100)

rango = rank(J_subs)

%prima del secondo
null_J = simplify(null(J_subs), steps = 100)

%secondo del secondo
range_J = simplify(colspace(J_subs), steps = 100)

r_dot = [1; 0; 0]
  
q_dot = simplify(pinv(J_subs) * r_dot, steps = 100)

%terzo del secondo
Null_J_T = simplify(null(J_subs.'), steps = 100)

%quarto del secondo
Null_J_T = simplify(null(J_subs.'), steps = 100)

%%terzo punto
P_I = subs(p,L,0.5)
eq1 = P_I(1)==0.3;
eq2 = P_I(2)==0.7;
eq3 = P_I(3)==pi/3;
sol = solve([eq1,eq2,eq3],[q1,q2,q3])
disp("solutions q1:")
disp(eval(sol.q1))
disp("solutions q2:")
disp(eval(sol.q2))
disp("solutions q3:")
disp(eval(sol.q3))






