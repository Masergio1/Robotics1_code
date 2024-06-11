clc
clear all

syms a b s v t

assume(a, 'positive')
assume(b, 'positive')
assume(t, 'positive')

p_s = [-a * sin(2*pi*s);
        b * cos(2*pi*s)]

p_s_prime = diff(p_s, s)
p_s_prime_prime = diff(p_s_prime, s)

s_dot = v
s_dot_dot = 0

%integrale di s_dot nel tempo
% s(t) = v * t 
% 
% s(0) = 0
% s(1/v) = 1

T = 1/v

%terza domanda
p_dot = simplify(subs(p_s_prime * s_dot, s, v * t), steps = 100) 
p_dot_dot = simplify(subs(p_s_prime * s_dot_dot + p_s_prime_prime * s_dot^2, s, v * t), steps = 100)

p_dot_norm = simplify(sqrt(p_dot.' * p_dot), steps = 100)
p_dot_dot_norm = simplify(sqrt(p_dot_dot.' * p_dot_dot), steps = 100)

p_dot_norm_diff = simplify(diff(p_dot_norm, t), steps = 100)
p_dot_dot_norm_diff = simplify(diff(p_dot_dot_norm, t), steps = 100)

p_dot_norm_diff = simplify(solve(p_dot_norm_diff == 0, t), steps = 100)
p_dot_dot_norm_diff = simplify(solve(p_dot_dot_norm_diff == 0, t), steps = 100)

p_dot_norm_max = simplify(subs(p_dot_norm, t , 1/(4 * v)), steps = 100)
p_dot_dot_norm_max = simplify(subs(p_dot_dot_norm, t , 1/(4 * v)), steps = 100)


