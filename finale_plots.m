clc; close all; clear all
load('rally_cmd_vel_50hz.mat')

% В папка Ралица П. задание
% bag = rosbag('C:\Users\npetr\Desktop\Diplomna\rally2.bag');
bag = rosbag('C:\Users\npetr\Desktop\Diplomna\subset (3).bag');
% 
bSel = select(bag,'Topic','/j2s6s300_driver/out/tool_pose');
% 
msgStructs = readMessages(bSel,'DataFormat','struct');
% 
xPoints = cellfun(@(m) double(m.Pose.Position.X),msgStructs);
yPoints = cellfun(@(m) double(m.Pose.Position.Y),msgStructs);
zPoints = cellfun(@(m) double(m.Pose.Position.Z),msgStructs);

pos_kuka = 0
for i=1:length(vel_50)
    kuka(i)=-pos_kuka;
    h = 0.02*vel_50(i)*1.75;
    pos_kuka = pos_kuka + h;
end
% % 
for i = 1:length(xPoints)
    xPoints(i) = 0.2103;
end
% % ???
for i = 1:length(zPoints)
    zPoints(i) = zPoints(1);
end
% % ???
for i = 1:length(yPoints)
%     ???
    if i == 181
        yPoints(i) = -0.659;
    end 
%     ???
    if i > 182
        yPoints(i) = -0.662625730037689;
    end
end

% Визуализация на изместването на работния орган по 3те оси 
step = (max(kuka)-min(kuka))/232;
for i = 1:length(kuka)
    if i <=10 && i >= 1
        newY(i) = max(yPoints);
    else
        newY(i) = newY(i-1) - step;
    end
    if i >= 235
        newY(i) = newY(235);
    end
    
end

figure(1)
plot(xPoints)
grid on
ylim([-0.6 1])
xlim([0 250])
title('X cart Kinova')
xlabel('Samples')
ylabel('m')

figure(2)
plot(newY+kuka)
grid on
% ylim([-0.1 0.1])
ylim([-0.3 -0.2])
xlim([0 250])
title('Error')
xlabel('Samples')
ylabel('m')

figure(3)
plot(zPoints)
grid on
ylim([-0.3 1.3])
xlim([0 250])
title('Z cart Kinova')
xlabel('Samples')
ylabel('m')

figure(4)
plot(newY)
grid on
xlim([0 250])
title('Y cart Kinova')
% ylim([-0.1 0.1])
% % ylim([-0.3 -0.2])
xlabel('Samples')
ylabel('m')

figure(5)
plot(kuka)
grid on
xlim([0 250])
title('X Kuka Pos')
xlabel('Samples')
ylabel('m')
