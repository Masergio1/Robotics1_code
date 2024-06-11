clc
clear all

syms l1 l2 v beta T q1 q2

% Equazione della retta
syms x y
equation_line = y - 1.1 == tan(deg2rad(-20)) * (x + 0.8);

% Equazione della circonferenza
equation_circle = x^2 + y^2 == 0.9^2;

% Risolvi il sistema
intersection_points = solve([equation_line, equation_circle], [x, y])

solution_x = double(intersection_points.x)
solution_y = double(intersection_points.y)

P_1 = [solution_x(1), solution_y(1)]
P_2 = [solution_x(2), solution_y(2)]

P_rv = [-0.1930; 0.8791] + [0.6 * cos(deg2rad(-20)); 0.6 * sin(deg2rad(-20))]

p_x = P_rv(1);p_y = P_rv(2)

l1 = 0.5
l2 = 0.4

c2 = (p_x^2 + p_y^2 - (l1^2 + l2^2))/ (2*l1*l2)
s2 = -sqrt(1 - c2^2)
q_2 = double(atan2(s2, c2))
q_1 = double(atan2(p_y*(0.5+0.4*c2)-p_x*0.4*s2,p_x*(0.5+0.4*c2)+p_y*0.4*s2))
