close all;
clear;
clc;

for i = 1:9
    str = ['modNet_avgFre_connec_conP0',num2str(i*10),'.mat'];
    temp = importdata(str);
    x(i,:) = mean(temp(50:end,:));
    y(i,:) = std(temp(50:end,:));
end

figure(1);
subplot(2,3,1);
errorbar(x(:,1),y(:,1),'-o','MarkerSize',8,...
    'MarkerFaceColor','r', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([22,26]);
grid on;
xtick = 1:2:9;
xtickname = {'0.1','0.3','0.5','0.7','0.9'};
ytick = 22:2:26;
ytickname = {'22','24','26'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density from Module 1 to 3');
ylabel({'Firing rate','of Module 1 (Hz)'});

subplot(2,3,2);
errorbar(x(:,2),y(:,2),'-o','MarkerSize',8,...
    'MarkerFaceColor','g', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0.08,0.18]);
grid on;
ytick = 0.08:0.05:0.18;
ytickname = {'0.08','0.13','0.18'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density from Module 1 to 3');
ylabel({'Firing rate','of Module 2 (Hz)'});

subplot(2,3,3);
errorbar(x(:,3),y(:,3),'-o','MarkerSize',8,...
   'MarkerFaceColor','b', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0,3]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.1','0.3','0.5','0.7','0.9'};
ytick = 0:1.5:3;
ytickname = {'0','1.5','3'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density from Module 1 to 3');
ylabel({'Firing rate','of Module 3 (Hz)'});

subplot(2,3,4);
errorbar(x(:,4),y(:,4),'-o','MarkerSize',8,...
   'MarkerFaceColor','y', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0.04,0.2]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.1','0.3','0.5','0.7','0.9'};
ytick = 0.04:0.08:0.2;
ytickname = {'0.04','0.12','0.2'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density from Module 1 to 3');
ylabel({'Firing rate','of Module 4 (Hz)'});

subplot(2,3,5);
errorbar(x(:,5),y(:,5),'-o','MarkerSize',8,...
    'MarkerFaceColor','m', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.1','0.3','0.5','0.7','0.9'};
set(gca,'xtick',xtick,'xticklabel',xtickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);

xlabel('Synaptic density from Module 1 to 3');
ylabel({'Firing rate','of Module 5 (Hz)'});

