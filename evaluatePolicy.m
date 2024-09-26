function action1 = evaluatePolicy(observation1)
%#codegen

% Reinforcement Learning Toolbox
% Generated on: 2024-09-24 20:42:34

persistent policy;
if isempty(policy)
	policy = coder.loadRLPolicy("agentData5.mat");
end
% evaluate the policy
action1 = getAction(policy,observation1);