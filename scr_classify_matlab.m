%
% This script classify the textures of the dataset (AIPI P3 Texture Classification). 
%
% The first loop is used to extract the features of:
%  - the training set (first two images of each class)
%  - the testing set (rest of images of each class: 4 per class)
%
% Note that, it loads all the images (they should be in the 'P3_class/' folder!), 
% extract the features using the function computeFeatureVector and save the
% features in matrices:
%
%    vecTrain: contains the training features for each image
%    labTrain: contains the class labels (1..20) for each training image
%    vecTest: contains the features for each of the testing images
%    labTest: contains the class labels (1..20) for each testing image
%
% With these matrices you have to train your K-NN (Nearest Neighbour) Classifier 
%
% You should compute the the confusion matrix to obtain the results and also the % of 
% correct classification (accuracy). For a perfect classifier, the numbers of the 
% confusion matrix should be only in the diagonal. From the matrix you can compute
% the % of correct classification = sum of the diagonal / sum of the confusion matrix.


close all;
clear all;
dataDir = 'P3_class/';
d = dir([dataDir 't*']);

%computing features from training and testing sets
for i=1:length(d),
	namedir = d(i).name;
	d1 = dir([dataDir namedir '/*.tif']);
	for j=1:2,
		name = [dataDir namedir '/' d1(j).name];
		A = imread(name);
		vecTrain((i-1)*2+j,:) = computeFeatureVector(A); %training vector
		labTrain((i-1)*2+j) = i; %training labels
	end
	for j=3:length(d1),
		name = [dataDir namedir '/' d1(j).name];
		A = imread(name);
		vecTest((i-1)*4+j-2,:) = computeFeatureVector(A); %testing vector
		labTest((i-1)*4+j-2) = i; %testing labels
	end
end


%%
% Implement here you K-NN-Classifier

model = fitcknn(vecTrain,labTrain,"NumNeighbors",1,"Distance","seuclidean");
result_predictions=[];
for p=1:length(vecTest)
    [label,~,~] = predict(model,vecTest(p,:));
    result_predictions(end+1)=label;
end

%%
% Compute here your confusion matrix and accuracy

mat = confusionmat(labTest,result_predictions);

accuracy = sum(diag(mat))/sum(mat,'all');

accuracy
 

