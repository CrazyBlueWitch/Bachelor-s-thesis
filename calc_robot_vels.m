clc; clear all; close all;

load('new_finale_vals.mat')
load('jacobian.mat')

d1 = 0.2755;
d2 = 0.41;
d3 = 0.2073;
d4 = 0.1038;
d5 = 0.1038;
d6 = 0.16;
e2 = 0.0098;

% Дефиниране на брой итерации на цикъла = на брой елементи във в.
% finale_joint1
for i = 1:length(final_joint1)
%     Настройка на текущите позиции на ставите с данни от достъпното в
%     мрежата ръководство за Kinova
    t1 = final_joint1(i) - 180;
    t2 = final_joint2(i) + 90;
    t3 = final_joint3(i) + 90;
    t4 = final_joint4(i);
    t5 = final_joint5(i);
    t6 = final_joint6(i) - 90;
%     Дефиниране на хом преобразувания описващи ротациите и отместванията 
%     на ставните координатни системи спрямо базовата координатна система
    Tb0 = [1   0   0   0; 
           0  -1   0   0; 
           0   0  -1   0; 
           0   0   0   1];

    T01 = [cosd(t1)    0           sind(t1)    0;
           sind(t1)    0          -cosd(t1)    0; 
           0           1           0          -d1; 
           0           0           0           1];

    T12 = [cosd(t2)    sind(t2)    0           d2*cosd(t2);
           sind(t2)   -cosd(t2)    0           d2*sind(t2);
           0           0          -1           0;
           0           0           0           1];

    T23 = [cosd(t3)    0           sind(t3)    0;
           sind(t3)    0          -cosd(t3)    0;
           0           1           0          -e2;
           0           0           0           1];

    T34 = [cosd(t4)    0           sind(t4)    0;
           sind(t4)    0          -cosd(t4)    0;
           0           1           0         -(d3+d4);
           0           0           0           1];

    T45 = [cosd(t5)    0           sind(t5)    0;
           sind(t5)    0          -cosd(t5)    0;
           0           1           0           0;
           0           0           0           1];

    T56 = [cosd(t6)    sind(t6)    0           0;
           sind(t6)   -cosd(t6)    0           0;
           0           0          -1         -(d5+d6);
           0           0           0           1];
%     Изразяване на ориентация и позиция на коорд с-ми спрямо базова
    Tb1 = Tb0*T01; 
    Tb2 = Tb1*T12;
    Tb3 = Tb2*T23;
    Tb4 = Tb3*T34;
    Tb5 = Tb4*T45;
    Tb6 = Tb5*T56;
%     Отделяне на ротационните матрици от изразяванията на коорд с-ми спрямо
%     базовата
    R00 = diag([1 1 1]);
    R01 = Tb1(1:3,1:3);
    R02 = Tb2(1:3,1:3);
    R03 = Tb3(1:3,1:3);
    R04 = Tb4(1:3,1:3);
    R05 = Tb5(1:3,1:3);
%     Разст м/у центровете на вс коорд с-ми спрямо базовата
    d06 = Tb6(1:3,4);
    d05 = Tb5(1:3,4);
    d04 = Tb4(1:3,4);
    d03 = Tb3(1:3,4);
    d02 = Tb2(1:3,4);
    d01 = Tb1(1:3,4);
    d00 = [0;0;0];
%     Изчисляване на вс елементи от Якобиана от 1ви до 3ти ред и от 1ва до 6та
% колона
    Jrow13col1 = cross(R00*[0;0;1],d06 - d00);
    Jrow13col2 = cross(R01*[0;0;1],d06 - d01);
    Jrow13col3 = cross(R02*[0;0;1],d06 - d02);
    Jrow13col4 = cross(R03*[0;0;1],d06 - d03);
    Jrow13col5 = cross(R04*[0;0;1],d06 - d04);
    Jrow13col6 = cross(R05*[0;0;1],d06 - d05);
%     Изчисл на вс елементи на Як от 4ти до 6ти ред и от 1ва до 6та колона
    Jrow46col1 = R00*[0;0;1];
    Jrow46col2 = R01*[0;0;1];
    Jrow46col3 = R02*[0;0;1];
    Jrow46col4 = R03*[0;0;1];
    Jrow46col5 = R04*[0;0;1];
    Jrow46col6 = R05*[0;0;1];
%     Формиране на оконателния Якобиан
    J = [Jrow13col1 Jrow13col2 Jrow13col3 Jrow13col4 Jrow13col5 Jrow13col6;
         Jrow46col1 Jrow46col2 Jrow46col3 Jrow46col4 Jrow46col5 Jrow46col6];
%     Инвърсване на Якобиана
    invJ = inv(J);
%   invJ1 = cell2mat(invJ(1,1));
%     Дефиниране на вектор, който на втора позиция съдържа скоростите по
%     оста х на мобилната платформа, но х оста на мобилната платформа
%     съвпада с у оста на манипулатора затова втори елемент на вектор
%     колона е ненулев.
    vel_kuka = [0; vel_100(i); 0; 0; 0; 0];
%     Умножение на инвърснатата матрица на Якоби с вектора на скоростта за 
%     работния орган на маниплатора и полуаваме скоростите на 6те стави, 
%     като тези скорости трябва да поддържат зададената скорост на 
%     ендефектора по оста на манипулатора
    kinova_vel(:,i) = invJ*vel_kuka;
end
i
save('new_final_vals.mat')