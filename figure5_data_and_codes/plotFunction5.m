close all;
clear;
clc;

load('non_task_spikeSeq.mat');   % ���ش洢�������еı���
[m,n] = size(non_task_spikeSeq); % ��ȡ�������к���

%% ����ÿ�������Ƶ��
simTime = 4000; % ��������ÿ�ε�����ʱ�䳤�ȣ���λ��������
spikeFre = zeros(m,n/simTime);
for i = 1:n/simTime
    spikeFre(:,i) = sum(non_task_spikeSeq(:,(i-1)*simTime+1:i*simTime),2);
end;

%% �������ģ���ƽ������Ƶ��
modNum = 5;
mod_spikeFre = zeros(modNum,n/simTime);
for i = 1:modNum
    mod_spikeFre(i,:) = sum(spikeFre((i-1)*m/modNum+1:i*m/modNum,:));
end;

%% �������ģ��Ķ�Ԫ���Իع�
mod_regress = zeros(modNum,modNum);
for i = 1:modNum
    y = mod_spikeFre(i,:)';
    temp = mod_spikeFre;
    temp(i,:) = [];
    x = [ones(size(y)),temp'];
    c = regress(y,x);
    c(1) = [];
    mod_regress(:,i) = [c(1:i-1);0;c(i:end)];
end;
figure(1);
imagesc([1,modNum],[1,modNum],mod_regress);
colorbar('linewidth',1.2,'FontSize',16);
for i = 1:modNum
    for j = 1:modNum
        if i == j
            str = '1.00';
        else
            str = num2str(mod_regress(j,i),'%4.2f');
        end;
        text(i,j,str,'FontSize',16,...
            'fontweight','bold',...
            'HorizontalAlignment','center');
    end;
end;
xlabel('Module index');
ylabel('Module index');
title({'Simulated resting-state FC','using multiple regression'},'fontsize',16,'fontweight','bold');
tick = 1:m;
labelName = {'1','2','3','4','5'};
set(gca,'xtick',tick,'xticklabel',labelName,'ytick',tick,'yticklabel',labelName);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
daspect([1 1 1]);
view(0,-90);
