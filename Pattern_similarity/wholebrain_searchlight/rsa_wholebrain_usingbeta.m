%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Main function: trial_by_trial_rsa_wholebrain.m
%-Created bt Jared and Shaozheng on 08-08-2013
%-Modified and unified by Shaozheng Qin on December 2, 2013
%-Added parellell processing by Shaozheng Qin on December 4, 2013
%-Revised by Yunzhe Liu for Memory Suppression Task on September 8, 2014 (win 8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rsa_wholebrain_correct_par (ConfigFile)

CurrentDir = pwd;
ConfigFile = strtrim(ConfigFile);
if ~exist(ConfigFile,'file')
  fprintf('Error: cnnot find the configuration file ... \n');
  return;
end
 ConfigFile = ConfigFile(1:end-2);
 eval(ConfigFile);

ServerPath   = strtrim(paralist.ServerPath);
StatsPath = strtrim(paralist.StatsPath) ;
SubjectList  = strtrim(paralist.SubjectList);
MapType      = strtrim(paralist.MapType);
%SessCon      = paralist.SessCon;
MaskFile     = strtrim(paralist.MaskFile);
OutputDir    = strtrim(paralist.OutputDir);
SearchShape  = strtrim(paralist.SearchShape);
SearchRadius = paralist.SearchRadius;

disp('-------------- Contents of the Parameter List --------------------');
disp(paralist);
disp('------------------------------------------------------------------');
clear paralist;
disp('==================================================================');
disp('rsa_trialwise_wholebrain.m is running');
fprintf('Current directory is: %s\n', pwd);
%fprintf('Config file is: %s\n', ConfigFile);
disp('------------------------------------------------------------------');
disp('==================================================================');
fprintf('\n');

Subjects = SubjectList;
NumSubj = length(Subjects);
%nSS = SessCon(1);
%nCon = SessCon(2);

for iSubj = 1:NumSubj
  display(strcat('Processing subject: ', Subjects{iSubj}, '; ', int2str(iSubj), '/', int2str(length(Subjects))));
  DataDir = fullfile(ServerPath, Subjects{iSubj},StatsPath); 
  
  spm_mat = load(fullfile(DataDir, 'SPM.mat'));
  SPM = spm_mat.SPM;
  design_mtx = SPM.xX.name;
  %nReg = nSS*7; %Number of regressors of each session
  
  nt_neg = 1;     t_neg=65;
  nt_neu = 129; t_neu=193;
  CorrIndex=[];
  
  for i = 1:size(design_mtx,2)
          if length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con11') ...
                  |length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con21')...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con11') ...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con21')
                CorrIndex(nt_neg,1) = i;   
                nt_neg=nt_neg+1;
          end
  end
     
   for i = 1:size(design_mtx,2)
          if length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con12') ...
                  |length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con22')...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con12') ...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con22')
                CorrIndex(t_neg,1) = i;   
                t_neg=t_neg+1;
          end
   end
 
    for i = 1:size(design_mtx,2)
          if length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con13') ...
                  |length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con23')...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con13') ...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con23')
                CorrIndex(nt_neu,1) = i;   
                nt_neu=nt_neu+1;
          end
    end
  
     for i = 1:size(design_mtx,2)
          if length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con14') ...
                  |length(design_mtx{1,i})==29 & strcmpi(design_mtx{1,i}(19:23),'con24')...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con14') ...
                  |length(design_mtx{1,i})==30 &strcmpi(design_mtx{1,i}(20:24),'con24')
                CorrIndex(t_neu,1) = i;   
                t_neu=t_neu+1;
          end
   end
   
   
  NumMap = size(CorrIndex,1);
  VY = cell(NumMap, 1);
  MapName = cell(NumMap, 1);
  
  switch lower(MapType)
    case 'tmap'
      for i = 1:NumMap
        %VY{i} = fullfile(DataDir, SPM.xCon(MapIndex(i)).Vspm.fname);
        %MapName{i} = SPM.xCon(MapIndex(i)).name;
        VY{i} = fullfile(DataDir, SPM.xCon(CorrIndex(i)).Vspm.fname);
        MapName{i} = SPM.xCon(CorrIndex(i)).name;      
      end
    case 'conmap'
      for i = 1:NumMap
%         VY{i} = fullfile(DataDir, SPM.xCon(MapIndex(i)).Vcon.fname);
%         MapName{i} = SPM.xCon(MapIndex(i)).name;
         VY{i} = fullfile(DataDir, SPM.xCon(CorrIndex(i)).Vcon.fname);
         MapName{i} = SPM.xCon(CorrIndex(i)).name;
      end
    case 'betamap'
      for i = 1:NumMap
%         VY{i} = fullfile(DataDir, SPM.xCon(MapIndex(i)).Vcon.fname);
%         MapName{i} = SPM.xCon(MapIndex(i)).name;
         VY{i} = fullfile(DataDir, SPM.Vbeta(CorrIndex(i)).fname);
         MapName{i} = SPM.Vbeta(CorrIndex(i)).descrip(22:end);
      end
      
  end
  
  if isempty(MaskFile)
    VM = fullfile(DataDir, SPM.VM.fname);
  else
    VM = MaskFile;
  end
  
  OutputFolder = fullfile(OutputDir, Subjects{iSubj});
  if ~exist(OutputFolder, 'dir')
    mkdir(OutputFolder);
  end
  %k = 1;
  numPairs = NumMap * (NumMap - 1)/2;
   for i = 1:NumMap
      display(strcat('...Computing map: ', int2str(i), '..writing out ...'));
      for j = i+1:NumMap
        %display(strcat(int2str(k), ' ', 'of', ' ', int2str(numPairs)));
        %k = k+1;
        FileEnd = strcat('rsa', int2str(i),'_', int2str(j));
        OutputFile = fullfile(OutputFolder, FileEnd);
        SearchOpt = struct('def', 'sphere', 'spec', 6);
        SearchOpt.def = SearchShape;
        SearchOpt.spec = SearchRadius;
        
        CurrentMaps = cell(2,1);
        CurrentMaps{1} = VY{i};
        CurrentMaps{2} = VY{j};
        
        scsnl_searchlight_qin(CurrentMaps, VM, SearchOpt, 'pearson_correlation', OutputFile);
      end 
  end
  display(strcat('Averaging maps subject: ', Subjects{iSubj}, '; ', int2str(iSubj), '/', int2str(length(Subjects))));
  %fprintf('Averaging Subject %s', int2str(iSubj), ' of %s', int2str(NumSubj), ' : %s', Subjects{iSubj});
 % average_nonconsec_correlation_maps(numPairs, OutputFolder);
end

disp('-----------------------------------------------------------------');
fprintf('Changing back to the directory: %s \n', CurrentDir);
cd(CurrentDir);
disp('Wholebrain RSA is done.');
clear all;
close all;

matlabpool('close');

end

