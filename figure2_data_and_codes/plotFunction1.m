close all;
clear;
clc;

load('non_modNet_avgFre.mat');
x = mean(non_modNet_avgFre);
y = std(non_modNet_avgFre);

figure(1);
facecolor = [1,0,0;0,1,0;0,0,1;1,1,0;1,0,1];
for i = 1:5
    b = bar(i,x(i),'linewidth',1.2);
    b.FaceColor = facecolor(i,:);
    hold on;
end;
ylim([0,0.2]);
hold on;
e = errorbar(x,y,'.','color','k','linewidth',1.2);
e.Marker = 'none';
hold off;
xlabel('Module index');
ylabel('Firing rate (Hz)');
ytick = 0:0.05:0.2;
ylabelName = {'0','0.05','0.1','0.15','0.2'};
set(gca,'xtick',1:1:5,'ytick',ytick,'YTickLabel',ylabelName);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
pbaspect([1,0.26,1]);