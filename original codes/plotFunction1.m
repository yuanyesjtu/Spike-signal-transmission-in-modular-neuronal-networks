close all;
clear;
clc;

load('modNet_avgFre_source_conP087.mat');
x = mean(modNet_avgFre_source_conP087);
y = std(modNet_avgFre_source_conP087);

figure(1);
facecolor = [1,0,0;0,1,0;0,0,1;1,1,0;1,0,1];
for i = 1:5
    b = bar(i,x(i));
    b.FaceColor = facecolor(i,:);
    hold on;
end;
ylim([0.01,100]);
hold on;
e = errorbar(x,y,'.','color','k');
e.Marker = 'none';
hold off;
xlabel('Module index');
ylabel('Firing frequency (Hz)');
ytick = [0.01,0.1,1.0,10.0,100.0];
ylabelName = {'0.01','0.1','1.0','10.0','100.0'};
set(gca,'xtick',1:1:5,'ytick',ytick,'YTickLabel',ylabelName);
set(gca,'yscale','log');
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold');
pbaspect([1,0.26,1]);