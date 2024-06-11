clc
clear all

syms l1 l2 q1 q2

p = [l1 * cos(q1) + l2 * cos(q1 + q2);
     l1 * sin(q1) + l2 * sin(q1 + q2)]

J = simplify(jacobian(p, [q1 q2]), steps = 100)


