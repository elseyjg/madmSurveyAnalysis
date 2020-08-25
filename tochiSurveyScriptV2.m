%%2Opt 2Attr Analysis script
clc
clear
taskType = '2Opt2Att'; 

%Redo Analyses?
redoFlag = 0;

% Hello world!

%Which computer in use?
computerName = getComputerName;
if strcmp(computerName, 'desktop-ne5dnh1')|strcmp(computerName, 'newComputerName')== 1;
    paths.basePath = 'C:\Users\tochi\OneDrive\Documents\MATLAB\data\madm_2Opt2Att';
    paths.statsPath = fullfile(paths.basePath, 'stats\');
else
    disp('no declared path for this computer')
    return
end
for curSubj = 1:50;
    if curSubj < 10 
        subjID = ['0',num2str(curSubj)];
    else
        subjID = num2str(curSubj);
    end
end
%%
%%Retrieving file info and getting rid of NaN

%Ams
amsSurvey2_2 = readtable(fullfile(paths.statsPath, 'amsSurvey2_2.xlsx'));
feelForWork = table2array(amsSurvey2_2(:,27));
amsLabels = amsSurvey2_2.Properties.VariableNames;

%Bas
basSurvey2_2 = readtable(fullfile(paths.statsPath, 'basSurvey2_2.xlsx'));
basRating = table2array(basSurvey2_2(:, 18));
basLabels = basSurvey2_2.Properties.VariableNames;

%Motivation
motivationSurvey2_2 = readtable(fullfile(paths.statsPath, 'motivationSurvey2_2.xlsx'));
motivationRating = table2array(motivationSurvey2_2(:,18));
motivationLabels = motivationSurvey2_2.Properties.VariableNames;

%Engagement
engagementSurvey2_2 = readtable(fullfile(paths.statsPath, 'engagementSurvey2_2.xlsx'));
engagementRating = table2array(engagementSurvey2_2(:, 18));
engagementLabels = engagementSurvey2_2.Properties.VariableNames;

%%
%Testing
popStats = readtable(fullfile(paths.statsPath, 'statsTochi2Opt2Att.xlsx'));
popStatsLabels = popStats.Properties.VariableNames; %extracting labels
popStats = table2array(popStats);
popStats(isnan(popStats))=0;
popStats = popStats(any(popStats,2),:);
meanRTs = popStats(:,2);
meanNonDomRTs = popStats(:,3);
meanDomRTs = popStats(:,4);
%add other variables here
%mean distribution and significance

%%
%%Master Loops
for i = 2:size(popStats,2); %ams Survey
    %current population statistic
    currStat = popStats(:,i);
       for ii = 19:size(amsSurvey2_2,2) %current survey statistic
        iQ = table2array(amsSurvey2_2(:,ii));
        iOptCorr1 = fitlm(iQ, currStat);
        iOptCorrP1 = iOptCorr1.Coefficients.pValue(2);
        iOptCorr1R2(ii-18,1) = iOptCorr1.Rsquared.Adjusted;
        iOptCorr1R2(ii-18,2) = iOptCorrP1;
        if iOptCorrP1 <= 0.05; %FOR SIGNIFICANCE
            plot(iOptCorr1);
            iOptCorr1
            figureHandle = gcf; %get current figures
            figure(figureHandle);
            % annotation('textbox','string',['All Subjects Option Types Chosen: ', taskType] ...
            %     ,'position',[0.1,0.9,1,0.1],'fontsize',18 ...
            %     ,'fontweight','bold','linestyle','none')
            orient landscape
            set(gcf,'units','pixels' ...
                ,'units','inches'...
                ,'PaperType','usletter' ...
                ,'paperposition',[.25   .25   10.5  8])

                print(fullfile(figurePath,['amsLabels', popStatsLabels{i},'.pdf']),'-dpdf','-r300')
        end
       end
        writetable(array2table(iOptCorr1R2), fullfile([paths.statsPath, 'amsR2Values_',popStatsLabels{i},'.xlsx']));
end


optCorr = fitlm(meanNonDomRTs,feelForWork);
plot(optCorr)
close all

for i = 2:size(popStats,2); %bas Survey
    currStat = popStats(:,i);
       for ii = 19:size(basSurvey2_2,2)
        iQ = table2array(basSurvey2_2(:,ii));
        iOptCorr2 = fitlm(iQ, currStat);
        iOptCorrP2 = iOptCorr2.Coefficients.pValue(2);
        iOptCorr2R2(ii-18,1) = iOptCorr2.Rsquared.Adjusted;
        iOptCorr2R2(ii-18,2) = iOptCorrP2;
        if iOptCorrP2 <= 0.05;
            plot(iOptCorr2);
            iOptCorr2
            figureHandle = gcf; %get current figures
            figure(figureHandle);
            % annotation('textbox','string',['All Subjects Option Types Chosen: ', taskType] ...
            %     ,'position',[0.1,0.9,1,0.1],'fontsize',18 ...
            %     ,'fontweight','bold','linestyle','none')
            orient landscape
            set(gcf,'units','pixels' ...
                ,'units','inches'...
                ,'PaperType','usletter' ...
                ,'paperposition',[.25   .25   10.5  8])

                print(fullfile(figurePath,['basLabels', popStatsLabels{i},'.pdf']),'-dpdf','-r300')
        end
       end
        writetable(array2table(iOptCorr1R2), fullfile([paths.statsPath, 'basR2Values_',popStatsLabels{i},'.xlsx']));
end

for i = 2:size(popStats,2); %motivation Survey
    currStat = popStats(:,i);
       for ii = 19:size(motivationSurvey2_2,2)
        iQ = table2array(motivationSurvey2_2(:,ii));
        iOptCorr3 = fitlm(iQ, currStat);
        iOptCorrP3 = iOptCorr3.Coefficients.pValue(2);
        iOptCorr3R2(ii-18,1) = iOptCorr3.Rsquared.Adjusted;
        iOptCorr3R2(ii-18,2) = iOptCorrP3;
        if iOptCorrP3 <= 0.05;
            plot(iOptCorr3);
            iOptCorr3
            figureHandle = gcf; %get current figures
            figure(figureHandle);
            % annotation('textbox','string',['All Subjects Option Types Chosen: ', taskType] ...
            %     ,'position',[0.1,0.9,1,0.1],'fontsize',18 ...
            %     ,'fontweight','bold','linestyle','none')
            orient landscape
            set(gcf,'units','pixels' ...
                ,'units','inches'...
                ,'PaperType','usletter' ...
                ,'paperposition',[.25   .25   10.5  8])

                print(fullfile(figurePath,['motivationLabels', popStatsLabels{i},'.pdf']),'-dpdf','-r300')
        end
       end
        writetable(array2table(iOptCorr1R2), fullfile([paths.statsPath, 'motivationR2Values_',popStatsLabels{i},'.xlsx']));
end

for i = 2:size(popStats,2); %engagement Survey
    currStat = popStats(:,i); 
       for ii = 19:size(engagementSurvey2_2,2)
        iQ = table2array(engagementSurvey2_2(:,ii));
        iOptCorr4 = fitlm(iQ, currStat);
        iOptCorrP4 = iOptCorr4.Coefficients.pValue(2);
        iOptCorr4R2(ii-18,1) = iOptCorr4.Rsquared.Adjusted;
        iOptCorr4R2(ii-18,2) = iOptCorrP4;
        if iOptCorrP4 <= 0.05;
            plot(iOptCorr4);
            iOptCorr4
            figureHandle = gcf; %get current figures
            figure(figureHandle);
            % annotation('textbox','string',['All Subjects Option Types Chosen: ', taskType] ...
            %     ,'position',[0.1,0.9,1,0.1],'fontsize',18 ...
            %     ,'fontweight','bold','linestyle','none')
            orient landscape
            set(gcf,'units','pixels' ...
                ,'units','inches'...
                ,'PaperType','usletter' ...
                ,'paperposition',[.25   .25   10.5  8])

                print(fullfile(figurePath,['engagementLabels', popStatsLabels{i},'.pdf']),'-dpdf','-r300')
        end
       end
        writetable(array2table(iOptCorr1R2), fullfile([paths.statsPath, 'engagementR2Values_',popStatsLabels{i},'.xlsx']));
end

%%
%%Loops 
for i = 1:size(amsSurvey2_2,2)
    iQ = table2array(amsSurvey2_2(:,i));
    iOptCorr1 = fitlm(iQ, meanDomRTs);
    iOptCorrP1 = iOptCorr1.Coefficients.pValue(2);
    iOptCorr1R2(i,1) = iOptCorr1.Rsquared.Adjusted;
    iOptCorr1R2(i,2) = iOptCorrP1;
    if iOptCorrP1 <= 0.05;
        plot(iOptCorr1);
        iOptCorr1
        i
    end
end
writetable(array2table(iOptCorr1R2), fullfile([paths.statsPath, 'amsR2Values.xlsx']));

for i = 18:size(basSurvey2_2,2)
    iQ = table2array(basSurvey2_2(:,i));
    iOptCorr2 = fitlm(iQ, meanDomRTs);
    iOptCorrP2 = iOptCorr2.Coefficients.pValue(2);
    iOptCorr2R2(i,1) = iOptCorr2.Rsquared.Adjusted;
    iOptCorr2R2(i,2) = iOptCorrP2;
    if iOptCorrP2 <= 0.05;
        plot(iOptCorr2);
        iOptCorr2
        i
    end
end
writetable(array2table(iOptCorr2R2), fullfile([paths.statsPath, 'basR2Values.xlsx']));

for i = 18:size(motivationSurvey2_2,2)
    iQ = table2array(motivationSurvey2_2(:,i));
    iOptCorr3 = fitlm(iQ, meanDomRTs);
    iOptCorrP3 = iOptCorr3.Coefficients.pValue(2);
    iOptCorr3R2(i,1) = iOptCorr3.Rsquared.Adjusted;
    iOptCorr3R2(i,2) = iOptCorrP3;
    if iOptCorrP3 <= 0.05;
        plot(iOptCorr3);
        iOptCorr3
        i
    end
end
writetable(array2table(iOptCorr3R2), fullfile([paths.statsPath, 'motivationR2Values.xlsx']));

for i = 18:size(engagementSurvey2_2,2)
    iQ = table2array(motivationSurvey2_2(:,i));
    iOptCorr4 = fitlm(iQ, meanDomRTs);
    iOptCorrP4 = iOptCorr4.Coefficients.pValue(2);
    iOptCorr4R2(i,1) = iOptCorr4.Rsquared.Adjusted;
    iOptCorr4R2(i,2) = iOptCorrP4;
    if iOptCorrP4 <= 0.05;
        plot(iOptCorr3);
        iOptCorr3
        i
    end
end
writetable(array2table(iOptCorr4R2), fullfile([paths.statsPath, 'engagementR2Values.xlsx']));