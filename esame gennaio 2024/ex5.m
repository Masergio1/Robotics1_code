clc
clear all

syms x0 y0 R w t l1 l2 l3 q1 q2 q3

assume(R, 'positive')
assume(w, 'positive')
assume(l1, 'positive')
assume(l2, 'positive')
assume(l3, 'positive')
assume(t, 'positive')

alfa = w * t
p_x_t = x0 + R * cos(alfa)
p_y_t = y0 + R * sin(alfa)

p_x = l1 * cos(q1) + l2 * cos(q1 + q2) + l3 * cos(q1 + q2 + q3)
p_y = l1 * sin(q1) + l2 * sin(q1 + q2) + l3 * sin(q1 + q2 + q3)
theta = q1 + q2 + q3

p_x_alfa = l1 * cos(q1) + l2 * cos(q1 + q2) + l3 * cos(alfa)
p_y_alfa = l1 * sin(q1) + l2 * sin(q1 + q2) + l3 * sin(alfa)

%per calcolare c2 applichando sqr and sum con pxalfa e pyalfa e otteniamo:
c2 = simplify(((p_x_t - l3 * cos(alfa))^2 + (p_y_t - l3 * sin(alfa))^2 - (l1^2 + l2^2))/(2*l1*l2), steps = 100)

s2_piu = simplify(sqrt(1 - c2^2), steps = 100)
%s2_meno = simplify(-sqrt(1 - c2^2), steps = 100)

q2_piu = simplify(atan2(s2_piu, c2), steps = 100)
%q2_meno = simplify(atan2(s2_meno, c2), steps = 100)

q1_piu = simplify(atan2( p_y_t - l3 * sin(alfa),p_x_t - l3 * cos(alfa)) - atan2(l2 * s2_piu, l1 + l2 * c2), steps = 100)
%q1_meno = simplify(atan2(p_y_t - l3 * sin(alfa),p_x_t - l3 * cos(alfa)) - atan2(l2 * s2_meno, l1 + l2 * c2), steps = 100)

q3_piu = alfa - (q2_piu + q1_piu)
%q3_meno = alfa - (q2_meno + q1_meno)

q_piu = [q1_piu;
         q2_piu;
         q3_piu]

%q_meno = [q1_piu;
%          q2_meno;
%          q3_meno]

q_piu_value = double(simplify(subs(q_piu, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))
%q_meno_value = double(simplify(subs(q_meno, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))

q_piu_dot = diff(q_piu, t)

%q_meno_dot = diff(q_meno, t)

q_piu_dot_dot = diff(q_piu_dot, t)

%q_meno_dot_dot = diff(q_meno_dot, t)
%domanda 2
q_piu_dot_value = double(simplify(subs(q_piu_dot, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))
%q_meno_dot_value = double(simplify(subs(q_meno_dot, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))

q_piu_dot_dot_value = double(simplify(subs(q_piu_dot_dot, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))
%q_meno_dot_dot_value = double(simplify(subs(q_meno_dot_dot, [l1, l2, l3, R, w, t, x0, y0], [1, 1, 1, 0.5, 2*pi, 0.25, 1, 1]), steps = 100))

%domanda 3
p_x = double(subs(p_x, [q1, q2 ,q3, l1, l2, l3], [-0.5139, 1.9552, 0.1296, 1, 1, 1]))
p_y = double(subs(p_y, [q1, q2 ,q3, l1, l2, l3], [-0.5139, 1.9552, 0.1296, 1, 1, 1]))
theta = double(subs(theta, [q1, q2 ,q3, l1, l2, l3], [-0.5139, 1.9552, 0.1296, 1, 1, 1]))

alfa = double(subs(alfa, [w ,t], [2*pi, 0.25]))
p_x_t = double(subs(p_x_t, [x0, w ,t, R], [1, 2*pi, 0.25, 0.5]))
p_y_t = double(subs(p_y_t, [y0, w ,t, R], [1, 2*pi, 0.25, 0.5]))

