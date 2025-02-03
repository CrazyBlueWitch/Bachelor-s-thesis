clc; clear all;
load('move_kuka_minus04_minus005.mat')

for i = 1:length(vel) - 1
    k = i * 2;
    
    if i == 1
        vel_100(1) = vel(1);
    end
    if i + 1 == length(vel)
        vel_100(length(vel)*2) = vel(length(vel));
    end
    vel_100(k) = (vel(i) + vel(i + 1))/2;
    vel_100(k+1) = vel(i + 1);
end

figure(1)
plot(vel)
grid on
title('Оригинална скорост Kuka')
xlabel('Samples')
ylabel('m/sec')

figure(2)
plot(vel_100)
grid on
title('Интерполирана скорост Kuka')
xlabel('Samples')
ylabel('m/sec')