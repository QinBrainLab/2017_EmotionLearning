%-prediction analysis brain-behavioral
% using brain imaging data to predict behavioral data

clear all; close all; clc;

% y = load('ACC_T_sim.txt'); % behavioral data
% x_data = load('sim_mds.txt'); % brain imaging data
y = load('memory_performance_neu_27.txt');
x_data = load('Hip_all4-face_object_ns_R-F_neu_27.txt');

y_data_total = y;
pval = zeros(size(y_data_total, 2), size(x_data, 2));
corrval = zeros(size(y_data_total, 2), size(x_data, 2));

for iy = 1:size(y_data_total, 2)
  y_data = y_data_total(:,iy);
  y_data = (y_data - mean(y_data))./std(y_data);
  x_data = (x_data - repmat(mean(x_data), length(y_data), 1))./repmat(std(x_data), length(y_data), 1);
  
  num_boot = 1000;
  num_run = 100;
  
  nfold = 4;
  pthresh = 0.5;
  nobsv = length(y_data);
  nvar = size(x_data, 2);
  
  corr_val = cell(num_run, 1);
  parpool ('local',1);
  p=gcp;
  parfor irun = 1:num_run
    corr_val_run = zeros(nvar, 1);
    for ivar = 1:nvar
      x = x_data(:, ivar);
      y = y_data(:);
      
      fold_idx = bcv_sample(x, y, nfold, pthresh);
      
      y_pred = zeros(nobsv, 1);
      
      for ifold = 1:nfold
        te_idx = find(fold_idx == ifold);
        tr_idx = find(fold_idx ~= ifold);
        est_beta = regress(y(tr_idx), x(tr_idx));
        y_pred(te_idx) = x(te_idx)*est_beta;
      end
      
      corr_val_run(ivar) = corr(y_pred(:), y(:));
    end
    corr_val{irun} = corr_val_run;
  end
  delete(p);
  
  null_corr_val = cell(num_boot, 1);
  parpool ('local',1);
  p=gcp;
  parfor iboot = 1:num_boot
    null_corr_val_run = zeros(num_run, nvar);
    for ivar = 1:nvar
      x = x_data(:, ivar);
      y = y_data(:);
      null_y = y(randperm(length(y_data)));
      
      for irun = 1:num_run
        fold_idx = bcv_sample(x, null_y, nfold, pthresh);
        null_y_pred = zeros(nobsv, 1);
        for ifold = 1:nfold
          te_idx = find(fold_idx == ifold);
          tr_idx = find(fold_idx ~= ifold);
          est_beta = regress(null_y(tr_idx), x(tr_idx));
          null_y_pred(te_idx) = x(te_idx)*est_beta;
        end
        null_corr_val_run(irun, ivar) = corr(null_y(:), null_y_pred(:));
      end
    end
    null_corr_val{iboot} = null_corr_val_run;
  end
  delete(p);
  
  sum_corr_val = 0;
  for irun = 1:num_run
    sum_corr_val = sum_corr_val + corr_val{irun};
  end
  corr_val = sum_corr_val/num_run;
  
  mean_null_corr_val = zeros(num_boot, nvar);
  
  for iboot = 1:num_boot
    mean_null_corr_val(iboot, :) = squeeze(mean(null_corr_val{iboot}, 1));
  end
  null_corr_val = mean_null_corr_val;
  
  p_val = zeros(nvar,1);
  for i = 1:nvar
    p_val(i) = sum(null_corr_val(:,i) > corr_val(i))/num_boot;
  end
  
  pval(iy, :) = p_val(:)';
  corrval(iy, :) = corr_val(:)';
end

pval
corrval


