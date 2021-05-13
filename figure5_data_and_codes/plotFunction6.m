clear;
clc;
close all;
Signals = zeros(1,5);
Signals(1,5) = 1;

imagesc(Signals);
colorbar('linewidth',1.2,'FontSize',16,'ticks',[0,0.5,1.0]);
for i = 1:5
    str = num2str(Signals(1,i),'%4.2f');
    text(i,1,str,'FontSize',16,...
        'fontweight','bold',...
        'HorizontalAlignment','center');
end;
xlabel('Module index');
tick = 1:5;
labelName = {'1','2','3','4','5'};
set(gca,'xtick',tick,'xticklabel',labelName,'yticklabel',[]);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
daspect([1 1 1]);
set(gcf,'position',[104,335,600,225]);