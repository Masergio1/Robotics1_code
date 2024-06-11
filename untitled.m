clc;
clear;

syms tau t T qs Ca1 Ca2 Ca3 tau_b qg Cb1 Cb2 Cb3 qm vm real ;

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
     0
    ]

matrix = A\B

