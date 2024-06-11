clc
clear all

syms l1 l2 q1 q2 t T qi Ca0 Ca1 Ca2 Ca3 qa qb delta

p_x = l1 * cos(q1) + l2 * cos(q1 + q2)
p_y = l1 * sin(q1) + l2 * sin(q1 + q2)

%I can find the angles in A and B with px and py. I will do it now
%q(A)
equation_1 = 0 == 2 * cos(q1) + 1 * cos(q1 + q2);
equation_2 = 1 == 2 * sin(q1) + 1 * sin(q1 + q2);
% Risolvi il sistema
results_1 = solve([equation_1, equation_2], [q1, q2])
q_a = [results_1.q1;
       results_1.q2]

%q(B)
equation_1 = 3 == 2 * cos(q1) + 1 * cos(q1 + q2);
equation_2 = 0 == 2 * sin(q1) + 1 * sin(q1 + q2);
% Risolvi il sistema
results_2 = solve([equation_1, equation_2], [q1, q2])
q_b = [results_2.q1;
       results_2.q2]

%I can use a cubic function in this case
tau = t/T

%I know that if I have a rest to rest the value are:
% a = -2
% b = 3
% c = 0
% d = 0
%So I obtain that:
delta = q_b - q_a
qi = q_a

q = simplify(qi + delta * (-2 * tau^3 + 3 * tau^2), steps = 100)
q_subs = simplify(subs(q, t, T/2), steps = 100)
q_subs_subs = double(simplify(subs(q_subs, T, 2), steps = 100))

time = 0:0.01:2;
plotting = subs(q_subs_subs, t, time);
figure;
plot(time, plotting);
hold on;

%question 2
q_dot = simplify(diff(q, t), steps = 100)

%I know that the absolut value of q1_dot <= V1 = 2, and in the same times
%that the absolut value of q2_dot <= V2 = 3, i know that I have the max
%value in t = T/2 (because is a rest to rest), so i can subs it and with T = 2 i can see if the value
%are correct:

q_dot = simplify(subs(q_dot, t, T/2), steps = 100)
q_dot_subs = double(simplify(subs(q_dot, T, 2), steps = 100))

%in this case i find that all the value are feasible.  


