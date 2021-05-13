close all;
clear;
%clc;

%% ģ������
disp('===>>>��������');
iterNum = 60;                % ��������
simTime = 4000;              % ÿ�ε�����ʱ�䳤�ȣ���λ��������
simStep = 0.25;              % ÿ��������ʾ0.25����
enNum = 200;                 % �˷�����Ԫ������
inNum = 50;                  % ��������Ԫ������
modNum = 5;                  % ��Ԫ�����е�ģ������
synTrans_tau = 20;           % ͻ���źŵ�ʱ�䳣������λ�����룩
synTrans_gain = 5.0e-5;      % ͻ���źŵķ�ֵ
memInteg_tau = 100.0;        % ����ʱ�䳣������λ�����룩
memInteg_res = 1.0e6;        % Ĥ���裨��λ��ŷķ��
memInteg_vth = 85.0;         % ��ֵ��ѹ����λ��������
stdp_eta = 0.01;             % stdp��ѧϰ����
stdp_tau = 10.0;             % stdp��ʱ�䳣������λ�����룩

%% ������Ԫ������ź�Դ
disp('===>>>������Ԫ������ź�Դ');
[source_output,source_to_network_weight] = signal_source(enNum, inNum, iterNum, simTime);
	
%% ������Ԫ����ģ��
disp('===>>>������Ԫ����ģ��');
[network_weight, network_weight_index, network_output, network_input,...
	network_voltage, network_fireTime, network_fireIndex] = network_model(enNum, inNum, modNum);

%% Ԥ�����¼ģ�����Ŀռ�
result_1 = zeros(1, iterNum);
result_2 = zeros(enNum+inNum, simTime*iterNum);
result_3 = [];

%% ģ������
disp('===>>>ģ������');
for iterIndex = 1:iterNum
	for stepIndex = (iterIndex - 1) * simTime + 1 : iterIndex * simTime
		
		% ********************������Ԫ�����ڸ���Ԫ���������********************
		network_output_temp = (stepIndex - network_fireTime) * simStep / synTrans_tau;
		network_output_temp = network_output_temp .* (network_fireTime > 0);
		network_output = synTrans_gain * network_output_temp .* exp(-network_output_temp);
		
		% **************������Ԫ�����ڸ���Ԫ��Ĥ��ѹ�����巢��ʱ��**************
        %result_3 = [result_3,source_to_network_weight .* source_output(:,stepIndex)];
		network_input = source_to_network_weight(:,stepIndex) .* source_output(:,stepIndex) + network_weight' * network_output;
		network_voltage = (1.0 - simStep / memInteg_tau) * network_voltage + ...
			simStep / memInteg_tau * memInteg_res * network_input;
		network_fireIndex = network_voltage >= memInteg_vth;
		network_voltage(network_fireIndex) = 0.0;
		network_fireTime(network_fireIndex) = stepIndex;
        result_2(:,stepIndex) = network_fireIndex; % ��¼����ʱ�̸�����Ԫ�����巢�����
        
		% *************************������Ԫ����������Ȩ��*************************
		% ͻ��ǰ����Ԫ֮������巢��ʱ���
		network_to_network_fireTime_matrix = (network_fireTime' - network_fireTime) .* ...
			(network_weight_index & (network_fireIndex' | network_fireIndex));
		
		% ����ʱ������0��ͻ��Ȩ�صı仯
		idx = find(network_to_network_fireTime_matrix > 0);
		network_weight(idx) = network_weight(idx) + stdp_eta * (1.0 - network_weight(idx)) .* ...
			exp(-abs(network_to_network_fireTime_matrix(idx)) * simStep / stdp_tau);
		
		% ����ʱ���С��0��ͻ��Ȩ�صı仯	
		idx = find(network_to_network_fireTime_matrix < 0);
		network_weight(idx) = network_weight(idx) - stdp_eta * network_weight(idx) .* ...
			exp(-abs(network_to_network_fireTime_matrix(idx)) * simStep / stdp_tau);
		
	end;
	
	% ****************************��¼�����ģ����̽��****************************
    result_1(iterIndex) = mean(network_weight(network_weight ~= 0)); % ����ģ�͵�ƽ��ͻ������Ȩ��
	
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

% ****************************��¼��������ս��****************************
%figure(4);
%spy(result_2,3,'k');
%set(gca,'PlotBoxAspectRatio',[1 0.26 1]) % �����ݺ��
%xtick = 0:4000:iterNum*simTime;
%xlabelName = {'0','1','2','3'};
%ytick = 0:(enNum+inNum)/modNum:enNum+inNum;
%set(gca,'xtick',xtick,'xticklabel',xlabelName,'ytick',ytick,'ydir','normal');
%set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
%xlabel('Time (s)');
%ylabel('Neuron index');

% ****************************��¼���������ģ���ƽ��Ƶ��****************************
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

% ****************************�����µ�network_weight****************************
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
