clear all
clc
syms alpha d  a  theta q1 q2 q3 r h0 h v t

%% number of joints
N=3;

DHTABLE = [pi/2,   0,    0.7,  q1;
           0,      0.5,  0,    q2;
           0       0.5,  0     q3];
       
TDH = [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
       sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
         0             sin(alpha)             cos(alpha)            d;
         0               0                      0                   1];

A = cell(1,N);
for i = 1:N
   alpha = DHTABLE(i,1);
   a = DHTABLE(i,2);
   d = DHTABLE(i,3);
   theta = DHTABLE(i,4);
   A{i} = subs(TDH);
end

T = eye(4);
for i=1:N
   T = T*A{i};
   T = simplify(T);
end

T0N = T;
p = T(1:3,4);
n = T(1:3,1);
s = T(1:3,2);
a = T(1:3,3);

A_0_1 = A{1};
A_0_2 = A{1} * A{2};
A_0_3 = A{1} * A{2} * A{3};

p_01 = A_0_1(1:3, end);
p_02 = A_0_2(1:3, end);
p_03 = A_0_3(1:3, end);

A = DHMatrix([pi/2 0 0.7 q1])*DHMatrix([0 0.5 0 q2])*DHMatrix([0 0.5 0 q3])

%from A i f this f
f = [(cos(q1)*cos(q2))/2 + (cos(q1)*cos(q2)*cos(q3))/2 - (cos(q1)*sin(q2)*sin(q3))/2;(cos(q2)*sin(q1))/2 - (sin(q1)*sin(q2)*sin(q3))/2 + (cos(q2)*cos(q3)*sin(q1))/2;sin(q2)/2 + (cos(q2)*sin(q3))/2 + (cos(q3)*sin(q2))/2 + 7/10]

J = jacobian(f,[q1,q2,q3])

%this is the J
%J = [(sin(q1)*sin(q2)*sin(q3))/2 - (cos(q2)*sin(q1))/2 - (cos(q2)*cos(q3)*sin(q1))/2, - (cos(q1)*sin(q2))/2 - (cos(q1)*cos(q2)*sin(q3))/2 - (cos(q1)*cos(q3)*sin(q2))/2, - (cos(q1)*cos(q2)*sin(q3))/2 - (cos(q1)*cos(q3)*sin(q2))/2]
%    [(cos(q1)*cos(q2))/2 + (cos(q1)*cos(q2)*cos(q3))/2 - (cos(q1)*sin(q2)*sin(q3))/2, - (sin(q1)*sin(q2))/2 - (cos(q2)*sin(q1)*sin(q3))/2 - (cos(q3)*sin(q1)*sin(q2))/2, - (cos(q2)*sin(q1)*sin(q3))/2 - (cos(q3)*sin(q1)*sin(q2))/2]
%    [                                                                              0,                             cos(q2)/2 + (cos(q2)*cos(q3))/2 - (sin(q2)*sin(q3))/2,                   (cos(q2)*cos(q3))/2 - (sin(q2)*sin(q3))/2]
 
J_det = simplify(det(J), steps = 100)

%from this i find that 


%question 2
%i can check this with a subs of q(0) in p and t = 0 in p_d, and i obtain:
s = v * t %i have that s_dot = v so i can integrate and i obtain that s = v*t

p_x = r * cos(2*pi*s)
p_y = r * sin(2*pi*s)
p_z = h0 + h * v * t

p = [p_x;
     p_y;
     p_z];

p_subs = double(subs(p, [r, h0, h, v, t], [0.5, 0.2, 0.4, 1, 0]))
p_0_3_subs = double(subs(p_03,[q1 q2 q3],[0, pi/6, -pi/2]))
%so i can see that the end effector isn't on the trajectory

%question 3
%in this case this is the Cartisian control
%p_dot=J*((J^-1) * p'(s) * v + Ke)


%question 4
%after i find the kinematic control low in the previous execise

function [T, A] = DHMatrix(arrays)
    T = eye(4);
    nums = size(arrays);
    
    A = cell(1,nums(1));
    
    for i = 1:nums(1)
        line = arrays(i, :);
        R = [cos(line(4)) -cos(line(1))*sin(line(4)) sin(line(1))*sin(line(4)) line(2)*cos(line(4));
             sin(line(4)) cos(line(1))*cos(line(4)) -sin(line(1))*cos(line(4)) line(2)*sin(line(4));
             0 sin(line(1)) cos(line(1)) line(3);
             0 0 0 1;];
        A{i} = R;
        T = T * R;   
    end

    if isa(T, 'sym')
        T = simplify(T);
    end
end