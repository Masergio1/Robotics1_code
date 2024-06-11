clc 
clear all

syms L M N q1 q2 q3 qs qg t T Ca1 Ca2 Ca3 Ca4 Ca5 tau_1 qdots real;

L = 0.5;
M = 0.5;
N = 0.5;

tau = t/T 

p = [L*cos(q1)+N*cos(q1+q2)*cos(q3);
     L*sin(q1)+N*sin(q1+q2)*cos(q3);
     M + N*sin(q3)];

J = jacobian(p, [q1 q2 q3])
J_inv = inv(J);

q_s = [-pi/4; pi/4; pi/4];
 
q_g = [0; 0; pi/4];

p_dot = [1, -1, 0]
p_dot_f = [0, 0, 0]

q_dot_s = double(subs(J_inv * p_dot.',[q1 q2 q3], q_s.'))
q_dot_g = double(subs(J_inv * p_dot_f.',[q1 q2 q3], q_g.'))

q_tau = qs + Ca1 * tau + Ca2 * tau^2 + Ca3 * tau^3 + Ca4 * tau^4 + Ca5 * tau^5

q_tau_dot = simplify(diff(q_tau, t), steps = 100)
q_tau_dot_dot = simplify(diff(q_tau_dot, t), steps = 100)

q_tau_0 = simplify(subs(q_tau, t, 0),steps = 100)
q_tau_T = simplify(subs(q_tau, t, T),steps = 100)

q_tau_dot_0 = simplify(subs(q_tau_dot, t, 0),steps = 100)
q_tau_dot_T = simplify(subs(q_tau_dot, t, T),steps = 100)

q_tau_dot_dot_0 = simplify(subs(q_tau_dot_dot, t, 0),steps = 100)
q_tau_dot_dot_T = simplify(subs(q_tau_dot_dot, t, T),steps = 100)

A = [1, 1, 1, 1, 1;
     1/T, 0, 0, 0, 0;
     1/T, 2/T, 3/T, 4/T, 5/T;
     0, 2/T^2, 0, 0, 0;
     0, 2/T^2, 6/T^2, 12/T^2, 20/T^2;
    ];

b = [qg - qs;
     qdots;
     0;
     0;
     0;]

A_b = A\b

% q_tau_1 = qs + Ca1 * tau_1 + Ca2 * tau_1^2 + Ca3 * tau_1^3 + Ca4 * tau_1^4 + Ca5 * tau_1^5 
% q_tau_subs_1 = simplify(subs(q_tau_1,[Ca1 Ca2 Ca3 Ca4 Ca5] , [A_b(1) A_b(2) A_b(3) A_b(4) A_b(5)]), steps = 100)
% q_tau_subs_subs_1 = simplify(subs(q_tau_subs_1, {qdots, qg, qs}, {q_dot_s, q_g, q_s}), steps = 100)

q_tau = qs + Ca1 * tau + Ca2 * tau^2 + Ca3 * tau^3 + Ca4 * tau^4 + Ca5 * tau^5
q_tau_subs = simplify(subs(q_tau,[Ca1 Ca2 Ca3 Ca4 Ca5] , [A_b(1) A_b(2) A_b(3) A_b(4) A_b(5)]), steps = 100)
q_tau_subs_subs = simplify(subs(q_tau_subs, {qdots, qg, qs}, {q_dot_s, q_g, q_s}), steps = 100)
q_fin = double(subs(q_tau_subs_subs, t , T)) 

T_val = 2;
time = 0: 0.01: T_val;

x_values = subs(q_tau_subs_subs, [{t} {T}], [{time} {T_val}]);

figure;
plot([time], [x_values])
hold on;
grid on;
xlabel("time");
ylabel("acceleration")

T_val = 2;
time = 0: 0.01: T_val;

x_values = subs(diff(q_tau_subs_subs, t), [{t} {T}], [{time} {T_val}]);

figure;
plot([time], [x_values])
hold on;
grid on;
xlabel("time");
ylabel("acceleration")

T_val = 2;
time = 0: 0.01: T_val;

x_values = subs(diff(diff(q_tau_subs_subs, t), t), [{t} {T}], [{time} {T_val}])

figure;
plot([time], [x_values])
hold on;
grid on;
xlabel("time");
ylabel("acceleration")

