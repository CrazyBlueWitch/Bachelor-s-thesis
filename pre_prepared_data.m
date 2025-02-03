% чисти workspace; затваря фигурите
clear all; close all; clc;
% зарежда предварително запомнените данни
load('new_preprepared_data');
% стартова стойност на индексите за новогенерираните вектори: new_joint
h_i=1;

% създаване на празни вектори
new_joint1 = [];
new_joint2 = [];
new_joint3 = [];
new_joint4 = [];
new_joint5 = [];
new_joint6 = [];
% добавяне на фиктивна стойност в оригиналните вектори за изменение позиция
% на ставите за да има съвпадение с дължините на new_joint и vel_100 
joint1(length(joint1) + 1) = joint1(length(joint1));
joint2(length(joint2) + 1) = joint2(length(joint2));
joint3(length(joint3) + 1) = joint3(length(joint3));
joint4(length(joint4) + 1) = joint4(length(joint4));
joint5(length(joint5) + 1) = joint5(length(joint5));
joint6(length(joint6) + 1) = joint6(length(joint6));
% обхождане на елементите на векторите joint по индексно, последният индекс
% който се обработва е предпоследния
for i = 1:length(joint1) - 1
%     стъпка на нарастване между текущ индекс i и последващ. Това
%     принуждава цикълът for да се инкрементира до предпоследния елемент
    step1 = (joint1(i+1) - joint1(i))/1633;
    step2 = (joint2(i+1) - joint2(i))/1633;
    step3 = (joint3(i+1) - joint3(i))/1633;
    step4 = (joint4(i+1) - joint4(i))/1633;
    step5 = (joint5(i+1) - joint5(i))/1633;
    step6 = (joint6(i+1) - joint6(i))/1633;
%     запазване на стойността от текущ индекс i в помощна променлива h_var 
    h_var1 = joint1(i);
    h_var2 = joint2(i);
    h_var3 = joint3(i);
    h_var4 = joint4(i);
    h_var5 = joint5(i);
    h_var6 = joint6(i);
%     присвояваме помощната променлива h_var на индекс h_i за резултатните
%     вектори new_joint 
    new_joint1(h_i) = h_var1;
    new_joint2(h_i) = h_var2;
    new_joint3(h_i) = h_var3;
    new_joint4(h_i) = h_var4;
    new_joint5(h_i) = h_var5;
    new_joint6(h_i) = h_var6;
%     16 пъти увеличаваме стойността на векторите joint с индекс i 
    for j = 1:1633
%         инкрементираме индекса на резултатните вектори new_joint на които
%         индексни позиции ще запазваме новополучените стойности 
        h_i = h_i + 1;
%         новополучени стойности за new_joint като всяка новополучена
%         стойност нараства спрямо предходната с пресметнатата стъпка 
        h_var1 = h_var1 + step1;
        h_var2 = h_var2 + step2;
        h_var3 = h_var3 + step3;
        h_var4 = h_var4 + step4;
        h_var5 = h_var5 + step5;
        h_var6 = h_var6 + step6;
%         записване на новополучената стойност на позиция с индекс h_i 
        new_joint1(h_i) = h_var1;
        new_joint2(h_i) = h_var2;
        new_joint3(h_i) = h_var3;
        new_joint4(h_i) = h_var4;
        new_joint5(h_i) = h_var5;
        new_joint6(h_i) = h_var6;
    end
end

% създаване на помощен индекс за финалните вектори
help = 1;
% създаване на празни вектори за финалите стойности на изменението на ставите
final_joint1 = [];
final_joint2 = [];
final_joint3 = [];
final_joint4 = [];
final_joint5 = [];
final_joint6 = [];

% обхожда елементите от new_joint със стъпка 100
for j = 1:100:length(new_joint1)
%    всеки стотен елемент от new_joint го присвояваме на всеки следващ в
%    finale_joint
   final_joint1(help) = new_joint1(j);
   final_joint2(help) = new_joint2(j);
   final_joint3(help) = new_joint3(j);
   final_joint4(help) = new_joint4(j);
   final_joint5(help) = new_joint5(j);
   final_joint6(help) = new_joint6(j);
%    инкрементираме помощния индекс
   help = help + 1;
end

% визуализация на графиките на стартовия вектор и финалния вектор за да
% проверим дали съвпадат
figure(1)
plot(joint1)
grid on
title('Оригинални позиции на Kinova {\Theta_1}')
xlabel('Samples')
ylabel('Degs')

figure(2)
plot(final_joint1)
grid on
title('Интерполирани позиции на Kinova {\Theta_1}')
xlabel('Samples')
ylabel('Degs')

figure(3)
plot(joint2)
grid on
title('Оригинални позиции на Kinova {\Theta_2}')
xlabel('Samples')
ylabel('Degs')

figure(4)
plot(final_joint2)
grid on
title('Интерполирани позиции на Kinova {\Theta_2}')
xlabel('Samples')
ylabel('Degs')

figure(5)
plot(joint3)
grid on
title('Оригинални позиции на Kinova {\Theta_3}')
xlabel('Samples')
ylabel('Degs')

figure(6)
plot(final_joint3)
grid on
title('Интерполирани позиции на Kinova {\Theta_3}')
xlabel('Samples')
ylabel('Degs')

figure(7)
plot(joint4)
grid on
title('Оригинални позиции на Kinova {\Theta_4}')
xlabel('Samples')
ylabel('Degs')

figure(8)
plot(final_joint4)
grid on
title('Интерполирани позиции на Kinova {\Theta_4}')
xlabel('Samples')
ylabel('Degs')

figure(9)
plot(joint5)
grid on
title('Оригинални позиции на Kinova {\Theta_5}')
xlabel('Samples')
ylabel('Degs')

figure(10)
plot(final_joint5)
grid on
title('Интерполирани позиции на Kinova {\Theta_5}')
xlabel('Samples')
ylabel('Degs')

figure(11)
plot(joint6)
grid on
title('Оригинални позиции на Kinova {\Theta_6}')
xlabel('Samples')
ylabel('Degs')

figure(12)
plot(final_joint6)
grid on
title('Интерполирани позиции на Kinova {\Theta_6}')
xlabel('Samples')
ylabel('Degs')