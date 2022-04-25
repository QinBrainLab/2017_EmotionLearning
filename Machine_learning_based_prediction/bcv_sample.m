%-balance CV samples

function [bcv_idx] = bcv_sample(x, y, nfold, pthresh)

nobsv = length(y);

bcv_stop = 0;
max_perm = 1000;
num_perm = 0;

while bcv_stop == 0 && num_perm < max_perm
  fold_idx = randsample([repmat(1:nfold, 1, floor(nobsv/nfold)) 1:mod(nobsv, nfold)], nobsv);
  x_pval = anova1(x, fold_idx, 'off');
  y_pval = anova1(y, fold_idx, 'off');
  num_perm = num_perm + 1;
  
  if x_pval > pthresh && y_pval > pthresh
    bcv_stop = 1;
    bcv_idx = fold_idx;
  end
end

end