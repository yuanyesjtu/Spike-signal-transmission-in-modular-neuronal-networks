function [network_weight, network_weight_index, network_output, network_input,...
	network_voltage, network_fireTime, network_fireIndex] = network_model(enNum, inNum, modNum)

%flag = input('===>>>�����������ģʽ�����롰0����������������������ģʽ�����롰1������ ');
flag = 0;
if flag == 0
    %load('modNet_initial_data.mat');
    load('modNet_initial_data_source_conP087.mat');
    
elseif flag == 1

    %% ������Ԫ�����ڵ�ͻ������
    %conProb = rand(modNum)*0.5; % ģ�������Ӹ���
    conProb = ones(modNum)*0.5;
    %conProb(1:modNum+1:end) = rand(modNum,1)*0.5+0.5; % ģ���ڵ����Ӹ���
    syndens = zeros(size(conProb)); % �����ܶȾ���

    network_weight = rand(enNum+inNum); 
    for i = 1:modNum  % ���ո��������Ӹ��ʣ���ʼ��ͻ�����ӣ������������ܶ�
        for j = 1:modNum
            mod_temp = network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum);
            mod_temp(mod_temp >= 1.0 - conProb(i,j)) = 1.0; % ���ڵ���conProb(i,j)����Ϊ����ͻ������
            mod_temp(mod_temp < 1.0 - conProb(i,j)) = 0.0;  % С��conProb(i,j)����Ϊ������ͻ������

            syndens(i,j) = sum(sum(mod_temp > 0.0))/((enNum+inNum)/modNum)^2; % ���������ܶ�

            network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum) = mod_temp;
        end;
    end;
    network_weight = network_weight .* rand(enNum+inNum); % ��ʼ��ͻ�����ӵ�Ȩ��

    synIdx = randperm(enNum+inNum, inNum); % ��enNum+inNum��Ԫ�У����ѡ��inNum����Ԫ��Ϊ��������Ԫ
    network_weight(synIdx,:) = -1.0*network_weight(synIdx,:); % ����������Ԫ���˷�����Ԫ��ͻ��Ȩ��Ϊ��ֵ
    network_weight(synIdx,synIdx) = 0.0; % ��������Ԫ֮�䲻�������ӣ�����˵����Ȩ��Ϊ0

    %% Ϊͻ�����ӽ�������
    network_weight_index = network_weight > 0.0; % Ϊ�˷�����Ԫ֮������ӽ�������
    network_weight_index(:,synIdx) = 0; % �ų��������˷�����Ԫ����������Ԫ������

    %% Ԥ����洢�ռ�
    network_output = zeros(enNum+inNum, 1);
    network_input = zeros(enNum+inNum, 1);
    network_voltage = zeros(enNum+inNum, 1);
    network_fireTime = zeros(enNum+inNum, 1);
    network_fireIndex = false(enNum+inNum, 1);
    
    %% �������Ӿ�����ܶȾ���
    save('modNet_initial_data.mat');
    
else
    disp('�������');
end;

%% ���ú����ı�����ģ����ָ�������ڵ������ܶ�
changeFlag = 0;
if changeFlag == 1
    i = 1;
    j = 3;
    conProb(i,j) = 0.90;
    mod_temp = rand((enNum+inNum)/modNum);
    mod_temp(mod_temp >= 1.0 - conProb(i,j)) = 1.0; % ���ڵ���conProb(i,j)����Ϊ����ͻ������
    mod_temp(mod_temp < 1.0 - conProb(i,j)) = 0.0;  % С��conProb(i,j)����Ϊ������ͻ������
    syndens(i,j) = sum(sum(mod_temp > 0.0))/((enNum+inNum)/modNum)^2; % ���������ܶ�
    
    mod_temp = mod_temp .* rand((enNum+inNum)/modNum);
    network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum) = mod_temp;
    
    network_weight = abs(network_weight);
    network_weight(synIdx,:) = -1.0*network_weight(synIdx,:); % ����������Ԫ���˷�����Ԫ��ͻ��Ȩ��Ϊ��ֵ
    network_weight(synIdx,synIdx) = 0.0; % ��������Ԫ֮�䲻�������ӣ�����˵����Ȩ��Ϊ0

    %% Ϊͻ�����ӽ�������
    network_weight_index = network_weight > 0.0; % Ϊ�˷�����Ԫ֮������ӽ�������
    network_weight_index(:,synIdx) = 0; % �ų��������˷�����Ԫ����������Ԫ������

    %% �������Ӿ�����ܶȾ���
    save('modNet_initial_data_connec_conP090.mat');
end;

%% ��ʾ��ʼ����Ȩ�غ�ͻ���ܶ�
figure(1);
imagesc([0,(enNum+inNum)],[0,(enNum+inNum)],network_weight);
xlabel('Neuron index');
ylabel('Neuron index');
title('Synaptic weight matrix','fontsize',16,'fontweight','bold');
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
colorbar('linewidth',1.2,'FontSize',16,...
    'Ticks',[-0.9,-0.7,-0.5,-0.3,-0.1,0.1,0.3,0.5,0.7,0.9]);
view(0,-90);

figure(2);
[m,n] = size(syndens);
syndens = round(syndens*100)/100;
imagesc([1,m],[1,n],syndens);
colorbar('linewidth',1.2,'FontSize',16,...
    'Ticks',[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]);
for i = 1:modNum
    for j = 1:modNum
        str = num2str(syndens(j,i),'%4.2f');
        text(i,j,str,'FontSize',16,...
            'fontweight','bold',...
            'HorizontalAlignment','center');
    end;
end;
xlabel('Module index');
ylabel('Module index');
title('Synaptic density','fontsize',16,'fontweight','bold');
tick = 1:m;
labelName = {'1','2','3','4','5'};
set(gca,'xtick',tick,'xticklabel',labelName,'ytick',tick,'yticklabel',labelName);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
daspect([1 1 1]);
view(0,-90);