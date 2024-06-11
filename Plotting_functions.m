time = linspace(0, T, 1000); % adjust the number of points as needed

q_t_vals = double(subs(q_t, t, time));
q_vel_vals = double(subs(q_vel, t, time));
q_acc_vals = double(subs(q_acc, t, time));

% Plot the components
figure;

subplot(3, 2, 1);
plot(time, q_t_vals(1, :));
title('q_1(t)');
xlabel('Time');
ylabel('Position');

subplot(3, 2, 2);
plot(time, q_t_vals(2, :));
title('q_2(t)');
xlabel('Time');
ylabel('Position');

subplot(3, 2, 3);
plot(time, q_vel_vals(1, :));
title('qdot_1(t)');
xlabel('Time');
ylabel('Velocity');

subplot(3, 2, 4);
plot(time, q_vel_vals(2, :));
title('qdot_2(t)');
xlabel('Time');
ylabel('Velocity');

subplot(3, 2, 5);
plot(time, q_acc_vals(1, :));
title('qdoubledot_1(t)');
xlabel('Time');
ylabel('Acceleration');

subplot(3, 2, 6);
plot(time, q_acc_vals(2, :));
title('qdoubledot_2(t)');
xlabel('Time');
ylabel('Acceleration');