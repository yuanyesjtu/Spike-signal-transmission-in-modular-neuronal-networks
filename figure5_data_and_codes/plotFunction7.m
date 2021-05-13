close all;
clear;
clc;

Signals = [0.651333333333333	0.197666666666667	4.32366666666667	0.578000000000000	0.189333333333333];
max_Value = max(Signals);
min_Value = min(Signals);
Signals = (Signals-min_Value)/(max_Value-min_Value);

figure(1);
facecolor = [1,0,0;0,1,0;0,0,1;1,1,0;1,0,1];
for i = 1:5
    b = bar(i,Signals(i),'linewidth',1.2);
    b.FaceColor = facecolor(i,:);
    hold on;
end;
ylim([0.001,1.5]);
xlabel('Module index');
ylabel('Activity intensity');
ytick = [0.01,0.1,1];
ylabelName = {'0.01','0.1','1'};
set(gca,'xtick',1:1:5,'ytick',ytick,'YTickLabel',ylabelName);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'yscale','log');
set(gcf,'position',[104,335,600,225]);