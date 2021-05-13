close all;
clear;
clc;

for i = 10:18
    str = ['modNet_avgFre_target_conP0',num2str(i*5),'.mat'];
    temp = importdata(str);
    x(i-9,:) = mean(temp(50:end,:));
    y(i-9,:) = std(temp(50:end,:));
end

figure(1);
subplot(3,2,1);
errorbar(x(:,1),y(:,1),'-o','MarkerSize',8,...
    'MarkerFaceColor','r', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([23.5,25.5]);
grid on;
xtick = 1:2:9;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 23.5:1:25.5;
ytickname = {'23.5','24.5','25.5'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 3');
ylabel({'Firing rate','of Module 1 (Hz)'});

subplot(3,2,2);
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
xlabel('Synaptic density of Module 3');
ylabel({'Firing rate','of Module 2 (Hz)'});

subplot(3,2,3);
errorbar(x(:,3),y(:,3),'-o','MarkerSize',8,...
   'MarkerFaceColor','b', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([1.1,1.4]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 1.1:0.15:1.4;
ytickname = {'1.1','1.25','1.40'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 3');
ylabel({'Firing rate','of Module 3 (Hz)'});

subplot(3,2,4);
errorbar(x(:,4),y(:,4),'-o','MarkerSize',8,...
   'MarkerFaceColor','y', 'color','k','linewidth',1.2);
pbaspect([1 0.26 0.0783]);
ylim([0.1,0.14]);
%axis tight;
grid on;
xtick = 1:2:10;
xtickname = {'0.5','0.6','0.7','0.8','0.9'};
ytick = 0.1:0.02:0.14;
ytickname = {'0.1','0.12','0.14'};
set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',ytick,'yticklabel',ytickname);
set(gca,'FontName','Times New Roman','FontSize',16,'FontWeight','bold','linewidth',1.2);
set(gca,'GridLineStyle',':','GridColor',[0 0 0],'GridAlpha',1.0,'linewidth',1.2);
xlabel('Synaptic density of Module 3');
ylabel({'Firing rate','of Module 4 (Hz)'});

subplot(3,2,5);
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

xlabel('Synaptic density of Module 3');
ylabel({'Firing rate','of Module 5 (Hz)'});

