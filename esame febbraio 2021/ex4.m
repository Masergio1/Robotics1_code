clear all
clc

% Definizione dei limiti dei giunti prismatici
q1_min = 0;
q1_max = 1;
q2_min = 0;
q2_max = 1;

% Lunghezza del terzo link
L = 0.2;  % Assicurarsi che L < min{(q1_max - q1_min)/2, (q2_max - q2_min)/2}

% Verifica del vincolo su L
assert(L < min((q1_max - q1_min)/2, (q2_max - q2_min)/2), 'L non soddisfa i vincoli richiesti.');

% Calcolo del workspace primario (WS1)
ws1_x = [q1_min, q1_max, q1_max, q1_min, q1_min];
ws1_y = [q2_min, q2_min, q2_max, q2_max, q2_min];

% Calcolo del workspace secondario (WS2)
ws2_x = [q1_min + L, q1_max - L, q1_max - L, q1_min + L, q1_min + L];
ws2_y = [q2_min + L, q2_min + L, q2_max - L, q2_max - L, q2_min + L];

% Disegno dei workspace
figure;
hold on;
fill(ws1_x, ws1_y, 'g', 'FaceAlpha', 0.3, 'DisplayName', 'WS1 - Primary Workspace');
fill(ws2_x, ws2_y, 'b', 'FaceAlpha', 0.3, 'DisplayName', 'WS2 - Secondary Workspace');
plot(ws1_x, ws1_y, 'k', 'LineWidth', 1.5);  % Contorno del WS1
plot(ws2_x, ws2_y, 'k', 'LineWidth', 1.5);  % Contorno del WS2
xlabel('q1');
ylabel('q2');
title('Primary and Secondary Workspaces of the Planar PPR Robot');
legend;
grid on;
axis equal;
hold off;