function []=ExplorerEval(testSite)

%% Initilze
addpath(genpath('.'));
%clear;

%% Parameters
model_type = 'logistic';
prior_variance = 5;

%% Data file names
configFile = fopen(strcat('../conf/config_', testSite, '.txt'), 'r');
configs = textscan(configFile, '%s');
dataFileName_train = configs{1}{7};
dataFileName_test = configs{1}{8};

%% Model and error file names
modelMeanFileName_train = strcat('../temp/model_mean_train_', testSite, '.txt');
modelVarianceFileName_train = strcat('../temp/model_variance_train_', testSite, '.txt');
resultFileName_train = strcat('../temp/result_train_', testSite, '.txt');
resultFileName_test = strcat('../temp/result_test_', testSite, '.txt');

%% Load data
train = loadData(strcat('../', dataFileName_train));
test = loadData(strcat('../', dataFileName_test));

%% EXPLORER   
ep_LR = loadModel(modelMeanFileName_train, modelVarianceFileName_train);
res_ep_LR = testModel(ep_LR, train, test);
saveResult(res_ep_LR, resultFileName_train, resultFileName_test);
fprintf('EXPLORER Evaluate Model:   Training AUC = %f, Test AUC = %f\n', res_ep_LR.train.AUC,res_ep_LR.test.AUC);
fprintf('\n');

fclose('all');
end

