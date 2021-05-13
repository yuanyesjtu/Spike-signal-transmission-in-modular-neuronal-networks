function [source_output,source_to_network_weight] = signal_source(enNum, inNum, iterNum, simTime)

%source_output = repmat(normrnd(0,0.003,1,iterNum*simTime),enNum+inNum,1)*0.25; % 网络模型的输入信号源
source_output = repmat(normrnd(0,0.008,1,iterNum*simTime),enNum+inNum,1);
%source_output(1:50,:) = source_output(1:50,:)+0.0005;

%source_to_network_weight = ones(enNum+inNum, 1);%rand(enNum+inNum, 1); % 信号源与网络模型之间的连接权重
source_to_network_weight = rand(enNum+inNum,iterNum*simTime);
source_to_network_weight(source_to_network_weight>0.992) = 1.0;
source_to_network_weight(source_to_network_weight<=0.992) = 0.0;

%temp = rand(50,iterNum*simTime);
%temp(temp>0.75) = 1.0;
%temp(temp<=0.75) = 0.0;
%source_to_network_weight(1:50,:) = temp;
