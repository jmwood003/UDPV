function [Varcomp, Unifcomp] = SimPlot(TMAP,X,numstr,N)

%Indexing variables
Ridx = 1:N;
Fidx = N+1:N*2;
Uidx = N*2+1:N*3;
%Washout index
wshidx = 752:1500;
wshidxB = 752:1500;
AEidx = 752:761;
AEidxB = 752:762;

%Plot 
figure; hold on
%Plot the stable condition
subplot(3,3,1:2); hold on
shadedErrorBar(1:size(TMAP,2),nanmean(TMAP(Ridx,:),1),nanstd(TMAP(Ridx,:),0,1),'lineProps','-b');
shadedErrorBar(1:size(X,2),nanmean(X(Ridx,:),1),nanstd(X(Ridx,:),0,1),'lineProps','-r');
ylim([0 40]);
ylabel('Step Asymmetry (%)');
title('Repeated Condition');
legend('Adaptive Bayes prediction','Strategy + UDP prediction','Location','northwest');
legend('boxoff');
%Create Inset of washout
axes('Position',[.42 .75 .2 .15])
box on
hold on
shadedErrorBar(1:size(TMAP(wshidxB),2),nanmean(TMAP(Ridx,wshidxB),1),nanstd(TMAP(Ridx,wshidxB),0,1),'lineProps','-b');
shadedErrorBar(1:size(X(wshidx),2),nanmean(X(Ridx,wshidx),1),nanstd(X(Ridx,wshidx),0,1),'lineProps','-r');
plot(1:size(X(wshidx),2),zeros(1,size(X(1,wshidx),2)),'k-');
ylim([-2 10]);
xlim([0 50]);
% set(gca,'YTickLabel',[]);
% set(gca,'XTickLabel',[]);

%Plot the uniform condition
subplot(3,3,4:5); hold on
shadedErrorBar(1:size(TMAP,2),nanmean(TMAP(Fidx,:),1),nanstd(TMAP(Fidx,:),0,1),'lineProps','-b');
shadedErrorBar(1:size(X,2),nanmean(X(Fidx,:),1),nanstd(X(Fidx,:),0,1),'lineProps','-r');
ylim([0 40]);
ylabel('Step Asymmetry (%)');
title('5\sigma Condition');
% legend('Bayes Prediction','Two process prediction');
% legend('boxoff');
%Create Inset of washout
axes('Position',[.42 .45 .2 .15])
box on
hold on
shadedErrorBar(1:size(TMAP(wshidxB),2),nanmean(TMAP(Fidx,wshidxB),1),nanstd(TMAP(Fidx,wshidxB),0,1),'lineProps','-b');
shadedErrorBar(1:size(X(wshidx),2),nanmean(X(Fidx,wshidx),1),nanstd(X(Fidx,wshidx),0,1),'lineProps','-r');
plot(1:size(X(wshidx),2),zeros(1,size(X(1,wshidx),2)),'k-');
ylim([-2 10]);
xlim([0 50]);
% set(gca,'YTickLabel',[]);
% set(gca,'XTickLabel',[]);

%Plot the uniform condition
subplot(3,3,7:8); hold on
shadedErrorBar(1:size(TMAP,2),nanmean(TMAP(Uidx,:),1),nanstd(TMAP(Uidx,:),0,1),'lineProps','-b');
shadedErrorBar(1:size(X,2),nanmean(X(Uidx,:),1),nanstd(X(Uidx,:),0,1),'lineProps','-r');
ylim([0 40]);
xlabel('Washout Strides')
ylabel('Step Asymmetry (%)');
title('Uniform Condition');
% legend('Bayes Prediction','Two process prediction');
% legend('boxoff');
%Create Inset of washout
axes('Position',[.42 .15 .2 .15])
box on
hold on
shadedErrorBar(1:size(TMAP(wshidxB),2),nanmean(TMAP(Uidx,wshidxB),1),nanstd(TMAP(Uidx,wshidxB),0,1),'lineProps','-b');
shadedErrorBar(1:size(X(wshidx),2),nanmean(X(Uidx,wshidx),1),nanstd(X(Uidx,wshidx),0,1),'lineProps','-r');
plot(1:size(X(wshidx),2),zeros(1,size(X(1,wshidx),2)),'k-');
ylim([-2 10]);
xlim([0 50]);
% set(gca,'YTickLabel',[]);
% set(gca,'XTickLabel',[]);

%Plot washout rates 
%Bayes model
subplot(3,3,3); hold on
bar(1,nanmean(RateRegress(TMAP(Ridx,wshidxB),numstr)),'EdgeColor','b','FaceColor','w','LineWidth',2);
errorbar(1,nanmean(RateRegress(TMAP(Ridx,wshidxB),numstr)),nanstd(RateRegress(TMAP(Ridx,wshidxB),numstr)),'b');
bar(2,nanmean(RateRegress(TMAP(Fidx,wshidxB),numstr)),'EdgeColor','b','FaceColor','w','LineWidth',2);
errorbar(2,nanmean(RateRegress(TMAP(Fidx,wshidxB),numstr)),nanstd(RateRegress(TMAP(Fidx,wshidxB),numstr)),'b');
bar(3,nanmean(RateRegress(TMAP(Uidx,wshidxB),numstr)),'EdgeColor','b','FaceColor','w','LineWidth',2);
errorbar(3,nanmean(RateRegress(TMAP(Uidx,wshidxB),numstr)),nanstd(RateRegress(TMAP(Uidx,wshidxB),numstr)),'b');
plot(1:3,[nanmean(RateRegress(TMAP(Ridx,wshidxB),numstr)),nanmean(RateRegress(TMAP(Fidx,wshidxB),numstr)),nanmean(RateRegress(TMAP(Uidx,wshidxB),numstr))],'k-');
ylim([0 1]);
title('Adaptive Bys');
ylabel('Retention Factor');
% xlabel('Conditions');
ax = gca;
ax.XTick = [1:3];
ax.XTickLabel = {'R','5\sigma','U'};

%Two process model
subplot(3,3,6); hold on
bar(1,nanmean(RateRegress(X(Ridx,wshidx),numstr)),'EdgeColor','r','FaceColor','w','LineWidth',2);
errorbar(1,nanmean(RateRegress(X(Ridx,wshidx),numstr)),nanstd(RateRegress(X(Ridx,wshidx),numstr)),'r');
bar(2,nanmean(RateRegress(X(Fidx,wshidx),numstr)),'EdgeColor','r','FaceColor','w','LineWidth',2);
errorbar(2,nanmean(RateRegress(X(Fidx,wshidx),numstr)),nanstd(RateRegress(X(Fidx,wshidx),numstr)),'r');
bar(3,nanmean(RateRegress(X(Uidx,wshidx),numstr)),'EdgeColor','r','FaceColor','w','LineWidth',2);
errorbar(3,nanmean(RateRegress(X(Uidx,wshidx),numstr)),nanstd(RateRegress(X(Uidx,wshidx),numstr)),'r');
plot(1:3,[nanmean(RateRegress(X(Ridx,wshidx),numstr)),nanmean(RateRegress(X(Fidx,wshidx),numstr)),nanmean(RateRegress(X(Uidx,wshidx),numstr))],'k-');
ylim([0 1]);
title('Strategy + UDP');
ylabel('Retention Factor');
% xlabel('Conditions');
ax = gca;
ax.XTick = [1:3];
ax.XTickLabel = {'R','5\sigma','U'};

% %plot aftereffects
% subplot(3,3,9); hold on
% plot(1,nanmean(nanmean(TMAP(Sidx,AEidx),1)),'bo');
% errorbar(1,nanmean(nanmean(TMAP(Sidx,AEidx),1)),nanstd(nanmean(TMAP(Sidx,AEidx),1)),'b');
% plot(1.1,nanmean(nanmean(X(Sidx,AEidx),1)),'ro');
% errorbar(1.1,nanmean(nanmean(X(Sidx,AEidx),1)),nanstd(nanmean(X(Sidx,AEidx),1)),'r');
% plot(2,nanmean(nanmean(TMAP(Vidx,AEidx),1)),'bo');
% errorbar(2,nanmean(nanmean(TMAP(Vidx,AEidx),1)),nanstd(nanmean(TMAP(Vidx,AEidx),1)),'b');
% plot(2.1,nanmean(nanmean(X(Vidx,AEidx),1)),'ro');
% errorbar(2.1,nanmean(nanmean(X(Vidx,AEidx),1)),nanstd(nanmean(X(Vidx,AEidx),1)),'r');
% plot(3,nanmean(nanmean(TMAP(Uidx,AEidx),1)),'bo');
% errorbar(3,nanmean(nanmean(TMAP(Uidx,AEidx))),nanstd(nanmean(TMAP(Uidx,AEidx))),'b');
% plot(3.1,nanmean(nanmean(X(Uidx,AEidx),1)),'ro');
% errorbar(3.1,nanmean(nanmean(X(Uidx,AEidx))),nanstd(nanmean(X(Uidx,AEidx))),'r');
% xlim([0.5 3.5]);
% ylim([0 15]);
% ax = gca;
% ax.XTick = [1:3];
% ax.XTickLabel = {'S','V','U'};
% title('AEs');
% ylabel('Aftereffect');
% xlabel('Conditions');

%Plot aftereffects different from stable
AEreferenceABs = nanmean(TMAP(Ridx,AEidxB),2);
AEB5 = AEreferenceABs - nanmean(TMAP(Fidx,AEidxB),2);
AEBu = AEreferenceABs - nanmean(TMAP(Uidx,AEidxB),2);
AEreferenceSUs = nanmean(X(Ridx,AEidx),2);
AET5 = AEreferenceSUs - nanmean(X(Fidx,AEidx),2);
AETu = AEreferenceSUs - nanmean(X(Uidx,AEidx),2);

subplot(3,3,9); hold on
%Plot Bayes AEs difference from reference
p1 = plot(1,nanmean(AEB5),'bo');
errorbar(1,nanmean(AEB5),nanstd(AEB5),'b');
plot(2,nanmean(AEBu),'bo');
errorbar(2,nanmean(AEBu),nanstd(AEBu),'b');

%Plot two P AEs difference from reference
p2 = plot(1.1,nanmean(AET5),'ro');
errorbar(1.1,nanmean(AET5),nanstd(AET5),'r');
plot(2.1,nanmean(AETu),'ro');
errorbar(2.1,nanmean(AETu),nanstd(AETu),'r');

plot(0.5:2.5,zeros(1,3),'k');
xlim([0.5 2.5]);
ylim([-5 5]);
ax = gca;
ax.XTick = [1:2];
ax.XTickLabel = {'R-5\sigma','R-U'};
% legend([p1 p2],'Bayes Model', 'TwoP Model');
% legend('boxoff');
title('Aftereffects');
ylabel('Delta SAI');
xlabel('Conditions');

%Is the change greater in the Bayesian model each time simulation?
Varcomp = AEB5>AET5;
Unifcomp = AEBu>AETu;

end