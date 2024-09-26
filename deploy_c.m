load('yaw_DDPG.mat','saved_agent')
generatePolicyFunction(saved_agent)
%设置代码生成条件
cfg = coder.config('mex');
cfg.TargetLang = 'C';
cfg.DeepLearningConfig = coder.DeepLearningConfig('none'); 

argstr = '{ones(3,1)}';

codegen('-config','cfg','evaluatePolicy','-args',argstr,'-report');