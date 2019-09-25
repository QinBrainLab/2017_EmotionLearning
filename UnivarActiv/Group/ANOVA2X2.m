% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/lustre/iCAN/home/zhuyannan/MGZ_new/univariate_activation/EL2svoice_PL0s/EL_2svoice/group_emotionXmemory_po2_2s/EL/group/ANOVA2X2_2/ANOVA2X2_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
