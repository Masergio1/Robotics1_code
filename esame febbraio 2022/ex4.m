clc;
clear;

syms tau t T qs Ca1 Ca2 Ca3 tau_b qg Cb1 Cb2 Cb3 qm vm S delta q_m_x  L real ;

%1
tau = (2 * t)/T;

x_t = qs + Ca1 * tau + Ca2 * tau^2 +  Ca3 * tau^3
x_t_subs = subs(x_t, t, T/2)

x_vel_t = simplify(diff(x_t, t), Steps=1000)
x_vel_t_subs = subs(x_vel_t, t, T/2)
x_vel_t_subs_0 = subs(x_vel_t, t, 0)

x_acc_t = simplify(diff(x_vel_t, t), Steps=1000)

tau_b = (2 * t/T) - 1 

y_t = qg + Cb1 * (tau_b - 1) + Cb2 * (tau_b - 1)^2 + Cb3 * (tau_b - 1)^3
y_t_subs = subs(y_t, t, T/2)

y_vel_t= simplify(diff(y_t, t), Steps=1000)
y_vel_t_subs = simplify(subs(y_vel_t, t, T/2), steps = 1000)
y_vel_t_subs_0 = simplify(subs(y_vel_t, t, T), steps = 1000)

y_acc_t = simplify(diff(y_vel_t, t), Steps=1000)

A = [1 , 1 , 1, 0 , 0 , 0;
     (2)/T,  0 , 0 , 0 , 0 , 0;
     (2/T^3) * (1 * T^2) , (2/T^3) * (2 * 1 * T^2), (2/T^3) * (3 * 1 * T^2) , 0 , 0 , 0;
     0 , 0 , 0 , -1, 1, -1;
     0 , 0 , 0 , (2/T) , -(4/T), (6/T);
     0 , 0 , 0 , (2/T), 0 , 0;
    ];

B = [qm - qs;
     0;
     vm;
     qm - qg
     vm
     0]

matrix = A\B

%calcolare vm
x_dot_dot = simplify(subs(x_acc_t, [Ca2, Ca3], [3*qm - 3*qs - (T*vm)/2, 2*qs - 2*qm + (T*vm)/2]), steps = 1000)
x_dot_dot = simplify(subs(x_dot_dot, t, 0), steps = 1000)
y_dot_dot = simplify(subs(y_acc_t, [Cb2, Cb3], [3*qm - 3*qg + (T*vm)/2, 2*qm - 2*qg + (T*vm)/2]), steps = 1000)
y_dot_dot = simplify(subs(y_dot_dot, t, T), steps = 1000)

vm_value = simplify(solve(x_dot_dot == y_dot_dot , vm), steps = 1000)
%vm_value = (3*(qg - qs))/(2*T)

%terza
x_t_Ca = simplify(subs(x_t, [Ca1, Ca2, Ca3], [0, 3*qm - 3*qs - (T*vm)/2, 2*qs - 2*qm + (T*vm)/2]), steps = 1000)

x_t_vm = simplify(subs(x_t_Ca, vm , (3*(qg - qs))/T) , steps = 1000)

q_m_x=S+delta/2-L*sqrt(15)/4

x_t_q = simplify(subs(x_t_vm, {qs, qm, qg}, {[S; pi/2], [q_m_x; atan2(1 , sqrt(15))], [S + delta; pi/2]}), steps = 1000)


y_t_Ca = simplify(subs(y_t, [Cb1, Cb2, Cb3], [0, 3*qm - 3*qg + (T*vm)/2, 2*qm - 2*qg + (T*vm)/2]), steps = 1000)

y_t_vm = simplify(subs(y_t_Ca, vm , (3*(qg - qs))/T) , steps = 1000)

q_m_x=S+delta/2-L*sqrt(15)/4

y_t_q = simplify(subs(y_t_vm, {qs, qm, qg}, {[S; pi/2], [q_m_x; atan2(1, sqrt(15))], [S + delta; pi/2]}), steps = 1000)


x_plot = simplify(subs(x_t_q, [L, S, delta], [1, 0 , 3]), steps = 1000)
y_plot = simplify(subs(y_t_q, [L, S, delta], [1, 0 , 3]), steps = 1000)

T_val = 2;
time = 0: 0.01: T_val;
T_val_2 = 4
time_2 = 2: 0.01: T_val_2; 

x_values = subs(x_plot, [{t} {T}], [{time} {T_val}]);
y_values = subs(y_plot, [{t} {T}], [{time_2} {T_val_2}]);

figure;
plot([time, time_2], [x_values, y_values])
hold on;
grid on;
xlabel("time");
ylabel("acceleration")
