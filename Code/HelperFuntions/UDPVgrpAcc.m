function [Racc, Lacc, Tacc] = UDPVgrpAcc(T)

Conditions = unique(T.Condition);
Racc = nan(10,length(Conditions));
Lacc = nan(10,length(Conditions));
Tacc = nan(10,length(Conditions));

RaccStrides = [];
LaccStrides = [];

for c = 1:length(Conditions)
    
    currCond = Conditions{c};
    Condidx = find(ismember(T.Condition,currCond)==1);
    Subjs = unique(T.Subject_ID(Condidx));
    
    %Pick a random exemplar subject to plot
    randplot = Subjs{randi(length(Subjs))};
    
    for s = 1:length(Subjs)
        
        currSubj = Subjs{s};
        Subjidx = find(ismember(T.Subject_ID,currSubj)==1 & ...
            ismember(T.Condition,currCond)==1 & ...
            ismember(T.Trial_name,'learning')==1);
        
        %Find the targets for each leg 
        Rtrgt = T.RSLtrgt(Subjidx);
        Ltrgt = T.LSLtrgt(Subjidx);
        
        %Index actual step length
        RSL = T.Right_step_length(Subjidx);
        LSL = T.Left_step_length(Subjidx);
        
        %Save SL and target to plot individual data
        RaccStrides.(currCond).(currSubj) = [Rtrgt, RSL];
        LaccStrides.(currCond).(currSubj) = [Ltrgt, LSL];
        
        %Find accuracy (meters)
%         currRA = nanmean(sqrt((Rtrgt-RSL).^2));
%         currLA = nanmean(sqrt((Ltrgt-LSL).^2));
        currRA = nanmean(abs(Rtrgt-RSL));
        currLA = nanmean(abs(Ltrgt-LSL));
        Racc(s,c) = currRA;
        Lacc(s,c) = currLA;
        Tacc(s,c) = mean([currRA currLA]);
        
    end
    
end

% %Plot
figure; hold on
% subplot(1,3,1:2); hold on
% Rtrgtsplot = RaccStrides.Unif.(randplot)(:,1);
% RSLplot = RaccStrides.Unif.(randplot)(:,2);
% Ltrgtsplot = LaccStrides.Unif.(randplot)(:,1);
% LSLplot = LaccStrides.Unif.(randplot)(:,2);
% %Plot targets
% plot(Rtrgtsplot,'k-');
% plot(Ltrgtsplot,'k-');
% plot(RSLplot,'b.','MarkerSize',10);
% plot(LSLplot,'r.','MarkerSize',10);

% subplot(1,3,3); hold on
for i = 1:size(Racc,2)
    %Plot Total accuracy
    p1 = plot(i,nanmean(Tacc(:,i)),'ko');
    errorbar(i,nanmean(Tacc(:,i)),nanstd(Tacc(:,i)),'k');
    plot(i+0.1,Tacc(:,i),'Marker','.','MarkerSize',10,'Color','k');
    %Plot Right accuracy
    p2 = plot(i+0.2,nanmean(Racc(:,i)),'bo');
    errorbar(i+0.2,nanmean(Racc(:,i)),nanstd(Racc(:,i)),'b');
    plot(i+0.2,Racc(:,i),'Marker','.','MarkerSize',10,'Color','b');
    %Plot Left accuracy
    p3 = plot(i-0.2,nanmean(Lacc(:,i)),'ro');
    errorbar(i-0.2,nanmean(Lacc(:,i)),nanstd(Lacc(:,i)),'r');
    plot(i-0.1,Lacc(:,i),'Marker','.','MarkerSize',10,'Color','r');
end
xlim([0 size(Racc,2)+1]);
ylim([0 0.1]);
ylabel('Distance from Target (m)');
xlabel('Condition');
ax = gca;
ax.XTick = [1 size(Racc,2)];
ax.XTickLabel = Conditions;
legend([p1, p2, p3],'Total', 'Right SL', 'Left SL');
title('Target Accuracy');


end