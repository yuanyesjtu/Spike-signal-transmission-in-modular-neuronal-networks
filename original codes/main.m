close all;
clear;
%clc;

%% 模型配置
disp('===>>>参数设置');
iterNum = 60;                % 迭代次数
simTime = 4000;              % 每次迭代的时间长度（单位：步长）
simStep = 0.25;              % 每个步长表示0.25毫秒
enNum = 200;                 % 兴奋性神经元的数量
inNum = 50;                  % 抑制性神经元的数量
modNum = 5;                  % 神经元网络中的模块数量
synTrans_tau = 20;           % 突触信号的时间常数（单位：毫秒）
synTrans_gain = 5.0e-5;      % 突触信号的幅值
memInteg_tau = 100.0;        % 整合时间常数（单位：毫秒）
memInteg_res = 1.0e6;        % 膜电阻（单位：欧姆）
memInteg_vth = 85.0;         % 阈值电压（单位：毫伏）
stdp_eta = 0.01;             % stdp的学习速率
stdp_tau = 10.0;             % stdp的时间常数（单位：毫秒）

%% 构建神经元网络的信号源
disp('===>>>构建神经元网络的信号源');
[source_output,source_to_network_weight] = signal_source(enNum, inNum, iterNum, simTime);
	
%% 构建神经元网络模型
disp('===>>>构建神经元网络模型');
[network_weight, network_weight_index, network_output, network_input,...
	network_voltage, network_fireTime, network_fireIndex] = network_model(enNum, inNum, modNum);

%% 预分配记录模拟结果的空间
result_1 = zeros(1, iterNum);
result_2 = zeros(enNum+inNum, simTime*iterNum);
result_3 = [];

%% 模型运行
disp('===>>>模型运行');
for iterIndex = 1:iterNum
	for stepIndex = (iterIndex - 1) * simTime + 1 : iterIndex * simTime
		
		% ********************计算神经元网络内各神经元的输出电流********************
		network_output_temp = (stepIndex - network_fireTime) * simStep / synTrans_tau;
		network_output_temp = network_output_temp .* (network_fireTime > 0);
		network_output = synTrans_gain * network_output_temp .* exp(-network_output_temp);
		
		% **************计算神经元网络内各神经元的膜电压和脉冲发放时间**************
        %result_3 = [result_3,source_to_network_weight .* source_output(:,stepIndex)];
		network_input = source_to_network_weight(:,stepIndex) .* source_output(:,stepIndex) + network_weight' * network_output;
		network_voltage = (1.0 - simStep / memInteg_tau) * network_voltage + ...
			simStep / memInteg_tau * memInteg_res * network_input;
		network_fireIndex = network_voltage >= memInteg_vth;
		network_voltage(network_fireIndex) = 0.0;
		network_fireTime(network_fireIndex) = stepIndex;
        result_2(:,stepIndex) = network_fireIndex; % 记录各个时刻各个神经元的脉冲发放情况
        
		% *************************计算神经元网络内连接权重*************************
		% 突触前后神经元之间的脉冲发放时间差
		network_to_network_fireTime_matrix = (network_fireTime' - network_fireTime) .* ...
			(network_weight_index & (network_fireIndex' | network_fireIndex));
		
		% 计算时间差大于0的突触权重的变化
		idx = find(network_to_network_fireTime_matrix > 0);
		network_weight(idx) = network_weight(idx) + stdp_eta * (1.0 - network_weight(idx)) .* ...
			exp(-abs(network_to_network_fireTime_matrix(idx)) * simStep / stdp_tau);
		
		% 计算时间差小于0的突触权重的变化	
		idx = find(network_to_network_fireTime_matrix < 0);
		network_weight(idx) = network_weight(idx) - stdp_eta * network_weight(idx) .* ...
			exp(-abs(network_to_network_fireTime_matrix(idx)) * simStep / stdp_tau);
		
	end;
	
	% ****************************记录并输出模拟过程结果****************************
    result_1(iterIndex) = mean(network_weight(network_weight ~= 0)); % 网络模型的平均突触连接权重
	
	switchfigure(3);
    clf;
    
    subplot(2,1,1);
    plot(result_1, '-o');
    xlabel('Time(s)');
    ylabel('Average weight');
    grid on;
    
    subplot(2,1,2);
    plot(sum(result_2,2)/(stepIndex*simStep)*1000,'*');
    xlabel('Neuron index');
    ylabel('Firing frequency');
    grid on;
    
    drawnow;
	
end;

% ****************************记录并输出最终结果****************************
%figure(4);
%spy(result_2,3,'k');
%set(gca,'PlotBoxAspectRatio',[1 0.26 1]) % 调节纵横比
%xtick = 0:4000:iterNum*simTime;
%xlabelName = {'0','1','2','3'};
%ytick = 0:(enNum+inNum)/modNum:enNum+inNum;
%set(gca,'xtick',xtick,'xticklabel',xlabelName,'ytick',ytick,'ydir','normal');
%set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
%xlabel('Time (s)');
%ylabel('Neuron index');

% ****************************记录并输出各个模块的平均频率****************************
temp = sum(result_2,2);
temp = reshape(temp,(enNum+inNum)/modNum,modNum);
temp = mean(temp,1)/(stepIndex*simStep)*1000;
if exist('modNet_avgFre_source_conP087.mat','file') ~= 0 
    load('modNet_avgFre_source_conP087.mat');
else
    modNet_avgFre_source_conP087 = [];
end;
modNet_avgFre_source_conP087 = [modNet_avgFre_source_conP087;temp];
save('modNet_avgFre_source_conP087.mat','modNet_avgFre_source_conP087');
modNet_avgFre_source_conP087

% ****************************保存新的network_weight****************************
temp = network_weight;
clearvars -except temp;
load('modNet_initial_data_source_conP087.mat');
network_weight = temp;
clear temp;
save('modNet_initial_data_source_conP087.mat');

function switchfigure(n)
    if get(0,'CurrentFigure') ~= n
        try
            set(0,'CurrentFigure',n);
        catch
            figure(n);
        end;
    end;
end
