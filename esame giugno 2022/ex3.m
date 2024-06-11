clc
clear all

syms q1 q2 x y tau1 tau2

J = [-q2*sin(q1), cos(q1);
     q2*cos(q1), sin(q1)]

F = [x;
     y];

tau = [tau1;
       tau2]

q = [pi/3 , 1.5]

F = -inv(J.') * tau

tau_1 = 10
tau_2 = 5
tau_3 = -10
tau_4 = -5

F_subs_PP = double(simplify(subs(F, [q1, q2, tau1, tau2], [q, tau_1, tau_2]), steps = 100))
F_subs_NN = double(simplify(subs(F, [q1, q2, tau1, tau2], [q, tau_3, tau_4]), steps = 100))
F_subs_PN = double(simplify(subs(F, [q1, q2, tau1, tau2], [q, tau_1, tau_4]), steps = 100))
F_subs_NP = double(simplify(subs(F, [q1, q2, tau1, tau2], [q, tau_3, tau_2]), steps = 100))

