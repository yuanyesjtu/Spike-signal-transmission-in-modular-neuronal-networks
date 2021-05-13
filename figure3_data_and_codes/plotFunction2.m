close all;
clear;
clc;

for i = 10:18
    str = ['modNet_avgFre_source_conP0',num2str(i*5),'.mat'];
    temp = importdata(str);
    x(i-9,:) = mean(temp(50:end,:));
    y(i-9,:) = std(temp(50:end,:));
end

figure(1);
subplot(2,3,1);
errorbar(x(:,1),y(:,1),'-o','MarkerSize',8,...
    'MarkerFaceColor','r', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
grid on;
xtick = 1:2:9;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 20:2.5:25;
ytickname = {'20.0','22.5','25.0'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 1');
ylabel({'Firing rate','of Module 1 (Hz)'});
%title('Module 1','FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);

subplot(2,3,2);
errorbar(x(:,2),y(:,2),'-o','MarkerSize',8,...
    'MarkerFaceColor','g', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0.11,0.15]);
grid on;
ytick = 0.11:0.02:0.15;
ytickname = {'0.11','0.13','0.15'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 1');
ylabel({'Firing rate','of Module 2 (Hz)'});
%title('Module 2','FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);

subplot(2,3,3);
errorbar(x(:,3),y(:,3),'-o','MarkerSize',8,...
   'MarkerFaceColor','b', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([1,1.3]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 1.0:0.15:1.3;
ytickname = {'1.0','1.15','1.30'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 1');
ylabel({'Firing rate','of Module 3 (Hz)'});
%title('Module 3','FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);

subplot(2,3,4);
errorbar(x(:,4),y(:,4),'-o','MarkerSize',8,...
   'MarkerFaceColor','y', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0.09,0.13]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 0.09:0.02:0.13;
ytickname = {'0.09','0.11','0.13'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 1');
ylabel({'Firing rate','of Module 4 (Hz)'});
%title('Module 4','FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);

subplot(2,3,5);
errorbar(x(:,5),y(:,5),'-o','MarkerSize',8,...
    'MarkerFaceColor','m', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
set(gca,'xtick',xtick,'xticklabel',xtickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);

xlabel('Synaptic density of Module 1');
ylabel({'Firing rate','of Module 5 (Hz)'});
%title('Module 5','FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);

