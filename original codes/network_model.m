function [network_weight, network_weight_index, network_output, network_input,...
	network_voltage, network_fireTime, network_fireIndex] = network_model(enNum, inNum, modNum)

%flag = input('===>>>读入既有连接模式（输入“0”），或者重新生成连接模式（输入“1”）： ');
flag = 0;
if flag == 0
    %load('modNet_initial_data.mat');
    load('modNet_initial_data_source_conP087.mat');
    
elseif flag == 1

    %% 定义神经元网络内的突触连接
    %conProb = rand(modNum)*0.5; % 模块间的连接概率
    conProb = ones(modNum)*0.5;
    %conProb(1:modNum+1:end) = rand(modNum,1)*0.5+0.5; % 模块内的连接概率
    syndens = zeros(size(conProb)); % 连接密度矩阵

    network_weight = rand(enNum+inNum); 
    for i = 1:modNum  % 按照给定的连接概率，初始化突触连接，并计算连接密度
        for j = 1:modNum
            mod_temp = network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum);
            mod_temp(mod_temp >= 1.0 - conProb(i,j)) = 1.0; % 大于等于conProb(i,j)被认为存在突触连接
            mod_temp(mod_temp < 1.0 - conProb(i,j)) = 0.0;  % 小于conProb(i,j)被认为不存在突触连接

            syndens(i,j) = sum(sum(mod_temp > 0.0))/((enNum+inNum)/modNum)^2; % 计算连接密度

            network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum) = mod_temp;
        end;
    end;
    network_weight = network_weight .* rand(enNum+inNum); % 初始化突触连接的权重

    synIdx = randperm(enNum+inNum, inNum); % 在enNum+inNum神经元中，随机选择inNum个神经元作为抑制性神经元
    network_weight(synIdx,:) = -1.0*network_weight(synIdx,:); % 从抑制性神经元到兴奋性神经元的突触权重为负值
    network_weight(synIdx,synIdx) = 0.0; % 抑制性神经元之间不存在连接，或者说连接权重为0

    %% 为突触连接建立索引
    network_weight_index = network_weight > 0.0; % 为兴奋性神经元之间的连接建立索引
    network_weight_index(:,synIdx) = 0; % 排出索引中兴奋性神经元到抑制性神经元的连接

    %% 预分配存储空间
    network_output = zeros(enNum+inNum, 1);
    network_input = zeros(enNum+inNum, 1);
    network_voltage = zeros(enNum+inNum, 1);
    network_fireTime = zeros(enNum+inNum, 1);
    network_fireIndex = false(enNum+inNum, 1);
    
    %% 保存连接矩阵和密度矩阵
    save('modNet_initial_data.mat');
    
else
    disp('输入错误！');
end;

%% 调用函数改变网络模型中指定区域内的连接密度
changeFlag = 0;
if changeFlag == 1
    i = 1;
    j = 3;
    conProb(i,j) = 0.90;
    mod_temp = rand((enNum+inNum)/modNum);
    mod_temp(mod_temp >= 1.0 - conProb(i,j)) = 1.0; % 大于等于conProb(i,j)被认为存在突触连接
    mod_temp(mod_temp < 1.0 - conProb(i,j)) = 0.0;  % 小于conProb(i,j)被认为不存在突触连接
    syndens(i,j) = sum(sum(mod_temp > 0.0))/((enNum+inNum)/modNum)^2; % 计算连接密度
    
    mod_temp = mod_temp .* rand((enNum+inNum)/modNum);
    network_weight((i-1)*(enNum+inNum)/modNum+1:i*(enNum+inNum)/modNum, (j-1)*(enNum+inNum)/modNum+1:j*(enNum+inNum)/modNum) = mod_temp;
    
    network_weight = abs(network_weight);
    network_weight(synIdx,:) = -1.0*network_weight(synIdx,:); % 从抑制性神经元到兴奋性神经元的突触权重为负值
    network_weight(synIdx,synIdx) = 0.0; % 抑制性神经元之间不存在连接，或者说连接权重为0

    %% 为突触连接建立索引
    network_weight_index = network_weight > 0.0; % 为兴奋性神经元之间的连接建立索引
    network_weight_index(:,synIdx) = 0; % 排出索引中兴奋性神经元到抑制性神经元的连接

    %% 保存连接矩阵和密度矩阵
    save('modNet_initial_data_connec_conP090.mat');
end;

%% 显示初始连接权重和突触密度
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