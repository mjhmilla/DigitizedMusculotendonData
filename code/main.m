clc;
close all;
clear all;

%%
%Test to see if the Matlab terminal is in the correct directory
%%
currDirContents = dir;
[pathToParent,parentFolderName,ext] = fileparts(currDirContents(1).folder);
matlabScriptPath = '';
rootFolderName = 'code';
if(strcmp(currDirContents(1).name,'.') ...
        && contains(parentFolderName,rootFolderName))
    matlabScriptPath = pwd;
else
    if(contains(currDirContents(1).folder,rootFolderName))
        idx0 = strfind(currDirContents(1).folder,...
                        rootFolderName);
        idx1 = idx0 + length(rootFolderName);
        pathToRootFolder = currDirContents(1).folder(1,1:idx1);
        cd(pathToRootFolder);
        matlabScriptPath = pwd;
    else
        assert(0, ['Error: script is not starting in the',...
                   ' code directory']);
    end
end

codeFolder = pwd;
cd(['..',filesep,'data']);
dataFolder = pwd;
cd(codeFolder);


fileHL1997Length = fullfile(dataFolder,'cat','forceVelocity',...
                   'fig_HerzogLeonard1997Fig1A_length.csv');

fileHL1997Force = fullfile(dataFolder,'cat','forceVelocity',...
                   'fig_HerzogLeonard1997Fig1A_forces.csv');

dataHL1997Length = loadDigitizedData(fileHL1997Length,...
                'Time ($$s$$)','Length ($$mm$$)',...
                {'c01','c02','c03','c04','c05',...
                 'c06','c07','c08','c09','c10','c11'},...
                {'Herzog and Leonard 1997'}); 

dataHL1997Force = loadDigitizedData(fileHL1997Force,...
                'Time ($$s$$)','Force ($$N$$)',...
                {'c01','c02','c03','c04','c05',...
                 'c06','c07','c08','c09','c10','c11'},...
                {'Herzog and Leonard 1997'}); 

figH=figure;
figure(figH);
subplot(2,1,1);
    for i=1:1:length(dataHL1997Length)
        n = (i-1)/(length(dataHL1997Length)-1);
        colorA = [0,0,1];
        colorB = [0.75,0.75,1];
        colorSeries = colorA.*(n) + colorB.*(1-n);

        plot(dataHL1997Length(i).x,dataHL1997Length(i).y,...
             '-','Color',colorSeries,...
             'DisplayName',dataHL1997Length(i).seriesName);
        hold on;
    end
    box off;
    axis tight;
    xlabel('Time (s)');
    ylabel('Length (mm)');
    title('Herzog and Leonard 1997 Fig 1A lengths');

subplot(2,1,2);
    for i=1:1:length(dataHL1997Force)
        n = (i-1)/(length(dataHL1997Force)-1);
        colorA = [1,0,0];
        colorB = [1,0.75,0.75];
        colorSeries = colorA.*(n) + colorB.*(1-n);

        plot(dataHL1997Force(i).x,dataHL1997Force(i).y,...
             '-','Color',colorSeries,...
             'DisplayName',dataHL1997Force(i).seriesName);
        hold on;
    end
    box off;
    axis tight;
    xlabel('Time (s)');
    ylabel('Force (N)');
    title('Herzog and Leonard 1997 Fig 1A forces');    

