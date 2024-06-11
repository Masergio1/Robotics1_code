clear all
clc

disp("DH per ROBOT l o ROBOT r")
input_char = input('inserire: "l" o "r": ', 's');

if strcmp(input_char, 'l')
    %% FOR ROBOT A
    syms alpha d d1  a a1 a2 a3 a4 theta q1 q2 L Ll2 Ll3 q1 q2 q3
    
    %% number of joints 
    N=3;
    
    
    %% PAY ATTENTION TO THE POSITION OF
    %% a and d: a is the second column
    %% d the third!
    
    DHTABLE = [ 0   L    0    q1;
                0   Ll2  0    q2;
                0   Ll3  0    q3];
    
    
    TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
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
        disp(i)
        disp(A{i})
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
    
    A_0_2 = simplify(A{1} * A{2}, steps=100);

    A_0_3 = simplify(A{1} * A{2} * A{3}, steps=100);
    
    p_01 = A_0_1(1:3, end);
    p_02 = A_0_2(1:3, end);
    p_03 = A_0_3(1:3, end)
    
    p_0_E = p_03
    p_1_E = p_03 - p_01;
    p_2_E = p_03 - p_02;
    
    R_0_1 = A_0_1(1:3, 1:3);
    R_0_2 = A_0_2(1:3, 1:3);
    R_0_3 = A_0_3(1:3, 1:3);
end

if strcmp(input_char, 'r')
    %% FOR ROBOT B
    syms alpha d d1  a a1 a2 a3 a4 theta q1 q2 L Lr2 Lr3 q1 q2 q3
    
    %% number of joints 
    N=3;
    
    
    %% PAY ATTENTION TO THE POSITION OF
    %% a and d: a is the second column
    %% d the third!
    
    DHTABLE = [ 0   L    0    q1;
                0   Lr2  0    q2;
                0   Lr3  0    q3];
    
    
    TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
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
        disp(i)
        disp(A{i})
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
    
    A_0_2 = simplify(A{1} * A{2}, steps=100);

    A_0_3 = simplify(A{1} * A{2} * A{3}, steps=100);
    
    p_01 = A_0_1(1:3, end);
    p_02 = A_0_2(1:3, end);
    p_03 = A_0_3(1:3, end)
    
    p_0_E = p_03
    p_1_E = p_03 - p_01;
    p_2_E = p_03 - p_02;
    
    R_0_1 = A_0_1(1:3, 1:3);
    R_0_2 = A_0_2(1:3, 1:3);
    R_0_3 = A_0_3(1:3, 1:3);
end