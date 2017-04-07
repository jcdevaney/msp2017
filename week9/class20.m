
% load data
% avmVals.mat and avmLoudness.mat are too big to upload to github, so you'll need to download them at
% https://www.dropbox.com/s/n2ku0xbgz77hs10/avmVals.mat?dl=0
% https://www.dropbox.com/s/1x0jouszjhabtf1/avmLoudness.mat?dl=0
versions=[1:6];
pSingers=[1 2 3 5 6 9];
npSingers=[1 2 5 6 7 8];
[avmP,avmNP]=loadAVMdata('avmVals.mat','avmLoudness.mat',pSingers,npSingers,versions);


% configuration data for SVM and run SVM using the svm library liblinear 
% (version 1.96) http://www.csie.ntu.edu.tw/~cjlin/liblinear/

% settings for liblinear
% L1-regularized L2-loss support vector classification
regularization='-s 5';

% define the musical notes in the piece to be used
notes{1}=(1:6);
notes{2}=(71:76);

% set up feature groups to be tested
% all pitch, timing, and loudness features
fieldnames{1}={'AVints' 'AVfirstNote' 'AVdcts' 'AVcurve' 'AVdepth' 'AVrate' 'AVtimes' 'AVioi' 'AVLTLmax'};
% pitch (interval size from previous note, interval size from opening note, 
%        slope of F0 trajectory, curvature of F0 trajectory, vibrato depth,
%        and vibrato rate)
fieldnames{2}={'AVints' 'AVfirstNote' 'AVdcts' 'AVcurve' 'AVdepth' 'AVrate'};
% timing (duration and inter-onset interval)
fieldnames{3}={'AVtimes' 'AVioi'};
% loudness (long-term loudness per note)
fieldnames{4}={'AVLTLmax'};

% configuration for training on opening/testing on closing and vice versa
trainNotes{1}=(1:6);
trainNotes{2}=(71:76);
testNotes{1}=(1:6);
testNotes{2}=(71:76);


for f = 1 : length(fieldnames) % for each configuration of features
    % configure data and run SVM 
    [openCloseAcapTrainDataP{f},openCloseAcapTrainLabelP{f}]=AVsvm(avmP,fieldnames{f},1:3,notes{1});
    [openCloseAcapTestDataP{f},openCloseAcapTestLabelP{f}]=AVsvm(avmP,fieldnames{f},1:3,notes{2});
    openCloseAcapP{f}=svmFunc(openCloseAcapTrainDataP{f},openCloseAcapTestDataP{f},openCloseAcapTrainLabelP{f},openCloseAcapTestLabelP{f},regularization);
    
    [openCloseAcapTrainDataNP{f},openCloseAcapTrainLabelNP{f}]=AVsvm(avmNP,fieldnames{f},1:3,notes{1});
    [openCloseAcapTestDataNP{f},openCloseAcapTestLabelNP{f}]=AVsvm(avmNP,fieldnames{f},1:3,notes{2});
    openCloseAcapNP{f}=svmFunc(openCloseAcapTrainDataNP{f},openCloseAcapTestDataNP{f},openCloseAcapTrainLabelNP{f},openCloseAcapTestLabelNP{f},regularization);

    [openCloseAccomTrainDataP{f},openCloseAccomTrainLabelP{f}]=AVsvm(avmP,fieldnames{f},4:6,notes{1});
    [openCloseAccomTestDataP{f},openCloseAccomTestLabelP{f}]=AVsvm(avmP,fieldnames{f},4:6,notes{2});
    openCloseAccomP{f}=svmFunc(openCloseAccomTrainDataP{f},openCloseAccomTestDataP{f},openCloseAccomTrainLabelP{f},openCloseAccomTestLabelP{f},regularization);
    
    [openCloseAccomTrainDataNP{f},openCloseAccomTrainLabelNP{f}]=AVsvm(avmNP,fieldnames{f},4:6,notes{1});
    [openCloseAccomTestDataNP{f},openCloseAccomTestLabelNP{f}]=AVsvm(avmNP,fieldnames{f},4:6,notes{2});
    openCloseAccomNP{f}=svmFunc(openCloseAccomTrainDataNP{f},openCloseAccomTestDataNP{f},openCloseAccomTrainLabelNP{f},openCloseAccomTestLabelNP{f},regularization);    
    
    [openCloseTrainDataP{f},openCloseTrainLabelP{f}]=AVsvm(avmP,fieldnames{f},1:6,notes{1});
    [openCloseTestDataP{f},openCloseTestLabelP{f}]=AVsvm(avmP,fieldnames{f},1:6,notes{2});
    openCloseP{f}=svmFunc(openCloseTrainDataP{f},openCloseTestDataP{f},openCloseTrainLabelP{f},openCloseTestLabelP{f},regularization);
    
    [openCloseTrainDataNP{f},openCloseTrainLabelNP{f}]=AVsvm(avmNP,fieldnames{f},1:6,notes{1});
    [openCloseTestDataNP{f},openCloseTestLabelNP{f}]=AVsvm(avmNP,fieldnames{f},1:6,notes{2});
    openCloseNP{f}=svmFunc(openCloseTrainDataNP{f},openCloseTestDataNP{f},openCloseTrainLabelNP{f},openCloseTestLabelNP{f},regularization);

end


% summarize accuracy
for f = 1 : length(fieldnames)
    openCloseAcapPvals(f)=openCloseAcapP{f}.accuracy(1);
    openCloseAcapNPvals(f)=openCloseAcapNP{f}.accuracy(1);
    openCloseAccomPvals(f)=openCloseAccomP{f}.accuracy(1);
    openCloseAccomNPvals(f)=openCloseAccomNP{f}.accuracy(1);
    openClosePvals(f)=openCloseP{f}.accuracy(1);
    openCloseNPvals(f)=openCloseNP{f}.accuracy(1);    
end

% generate and plot confusion matrices

% ground truth
openCloseGT=[1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6]';

openCloseAcapPpredicted_label=[];
openCloseAcapNPpredicted_label=[];
openCloseAccomPpredicted_label=[];
openCloseAccomNPpredicted_label=[];

openCloseAcapPground_truth=[];
openCloseAcapNPground_truth=[];
openCloseAccomPground_truth=[];
openCloseAccomNPground_truth=[];

f = 1; % all features
openCloseAcapPpredicted_label=[openCloseAcapPpredicted_label; openCloseAcapP{f}.predicted_label];
openCloseAcapNPpredicted_label=[openCloseAcapNPpredicted_label; openCloseAcapNP{f}.predicted_label];
openCloseAccomPpredicted_label=[openCloseAccomPpredicted_label; openCloseAccomP{f}.predicted_label];
openCloseAccomNPpredicted_label=[openCloseAccomNPpredicted_label; openCloseAccomNP{f}.predicted_label];

openCloseAcapPground_truth=[openCloseAcapPground_truth; openCloseGT];
openCloseAcapNPground_truth=[openCloseAcapNPground_truth; openCloseGT];
openCloseAccomPground_truth=[openCloseAccomPground_truth; openCloseGT];
openCloseAccomNPground_truth=[openCloseAccomNPground_truth; openCloseGT];

figure(1)
subplot(221)
plotConfMat(openCloseAcapPground_truth, openCloseAcapPpredicted_label, 'Professionals (a cappella)', 'openCloseAcapP_CM')
subplot(222)
plotConfMat(openCloseAcapNPground_truth, openCloseAcapNPpredicted_label, 'Undergraduates (a cappella)', 'openCloseAcapNP_CM')
subplot(223)
plotConfMat(openCloseAccomPground_truth, openCloseAccomPpredicted_label, 'Professionals (accompanied)', 'openCloseAccomP_CM')
subplot(224)
plotConfMat(openCloseAccomNPground_truth, openCloseAccomNPpredicted_label, 'Undergraduates (accompanied)', 'openCloseAccomNP_CM')
 
% write confusion matrix to CSV file
% csvwrite('openCloseAcapP_CM.csv', openCloseAcapP_CM);
% csvwrite('openCloseAcapNP_CM.csv', openCloseAcapNP_CM);
% csvwrite('openCloseAccomP_CM.csv', openCloseAccomP_CM);
% csvwrite('openCloseAccomNP_CM.csv', openCloseAccomNP_CM);


% look at specific features used
% (ultimatley all were used)
for f = 1 : 4
    openCloseAcapPfeatures{f}=lookAtFeatures(openCloseAcapP{f}.model.w,size(fieldnames{f},2));
    openCloseAcapNPfeatures{f}=lookAtFeatures(openCloseAcapNP{f}.model.w,size(fieldnames{f},2));
    openCloseAccomPfeatures{f}=lookAtFeatures(openCloseAccomP{f}.model.w,size(fieldnames{f},2));
    openCloseAccomNPfeatures{f}=lookAtFeatures(openCloseAccomNP{f}.model.w,size(fieldnames{f},2));
end


%%%% 3-fold cross-valdiation to mimic perceptual experiment

trainVals{1}=[2 3];
trainVals{2}=[1 3];
trainVals{3}=[1 2];

predictedLabels=[];
gtLabels=[];
listeningAccuracy=[];

for cv = 1 : length(trainVals)
    [listeningTrainDataP,listeningTrainLabelP]=AVsvm(avmP,fieldnames{1},trainVals{cv},notes{1});
    [listeningTestDataP,listeningTestLabelP]=AVsvm(avmP,fieldnames{1},cv,notes{1});
    listeningSVM{cv}=svmFunc(listeningTrainDataP,listeningTestDataP,listeningTrainLabelP,listeningTestLabelP, regularization);
    listeningAccuracy=[listeningAccuracy listeningSVM{cv}.accuracy(1)];
    predictedLabels=[predictedLabels; listeningSVM{cv}.predicted_label];
    gtLabels=[gtLabels listeningTestLabelP];   
    features{cv}=lookAtFeatures(listeningSVM{cv}.model.w,size(fieldnames{1},2));
end

% plot confusion matrix
figure(2)
plotConfMat(gtLabels, predictedLabels, 'Professionals (a cappella) - Opening (2/3 cross validation) 1', 'accomP_CM_listening1')

% look at features used
features{1}
features{2}
features{3}



% perceptual experiment data

% first column ground truth
% second column key press
subject{1}=[1	1
5	5
3	4
2	2
2	5
3	4
6	3
5	2
1	1
4	4
4	4
6	5]';

subject{2}=[3	4
4	3
5	2
3	4
1	5
5	2
2	5
1	1
2	5
6	4
4	4
6	6]';

subject{3}=[3	3
1	1
5	5
5	5
3	4
4	4
2	2
1	1
4	4
6	6
2	2
6	6]';

subject{4}=[6	6
6	6
1	2
3	3
5	5
1	2
4	4
3	3
5	2
2	1
2	1
4	4]';

subject{5}=[5	5
4	4
6	6
4	4
1	1
6	6
2	2
2	5
1	1
5	1
3	3
3	4]';

subject{6}=[4	4
3	3
2	5
2	5
6	6
1	1
6	3
1	1
5	5
5	2
3	4
4	4]';

subject{7}=[6	6
1	1
4	4
2	1
3	4
2	2
6	4
5	1
1	1
5	2
3	6
4	4]';

subject{8}=[3	4
4	4
6	6
5	5
4	3
6	6
2	2
5	5
1	1
2	5
3	3
1	1]';

subject{9}=[5	4
1	2
1	5
2	1
6	6
4	2
2	1
4	4
6	4
5	2
3	5
3	4]';

subject{10}=[5	4
1	4
6	6
1	5
3	3
6	6
3	2
4	5
5	1
4	5
2	3
2	1]';

subject{11}=[6	4
3	4
2	6
6	5
5	3
1	6
4	2
3	5
1	1
5	5
2	3
4	1]';

subject{12}=[1	4
3	4
4	6
5	5
3	3
1	6
2	2
5	5
6	1
4	5
6	3
2	1]';

subject{13}=[5	4
4	4
5	6
1	5
2	3
3	6
4	2
2	5
6	1
1	5
3	3
6	1]';

subject{14}=[1	4
6	4
6	6
3	5
2	3
2	6
4	2
5	5
1	1
3	5
5	3
4	1]';

subject{15}=[1	4
4	4
6	6
5	5
1	3
2	6
5	2
4	5
2	1
3	5
6	3
3	1]';

subject{16}=[4	4
6	4
6	6
5	5
3	3
1	6
5	2
4	5
2	1
2	5
3	3
1	1]';

allSubjects=[subject{:}];

% human accuracy
humanAccuracy=nnz(find(abs(diff(allSubjects))))/length(allSubjects)*100;

figure(3)
plotConfMat(allSubjects(1,:),allSubjects(2,:), 'Professional (a capella) - 6 alternative forced choice listening test on opening', 'openAcapPlisten_CM')

% print summary statistics
sprintf('Combined results of training on opening and testing on closing and vice versa')
sprintf('The accuracy for the non-professionals a cappella performances was %0.1f for all features, %0.1f for pitch features, %0.1f for timing features, and %0.1f for loudness features.',openCloseAcapNPvals(1),openCloseAcapNPvals(2),openCloseAcapNPvals(3),openCloseAcapNPvals(4)) 
sprintf('The accuracy for the professionals a cappella performances was %0.1f for all features, %0.1f for pitch features, %0.1f for timing features, and %0.1f for loudness features.',openCloseAcapPvals(1),openCloseAcapPvals(2),openCloseAcapPvals(3),openCloseAcapPvals(4)) 
sprintf('The accuracy for the non-professionals accompanied performances was %0.1f for all features, %0.1f for pitch features, %0.1f for timing features, and %0.1f for loudness feature.s',openCloseAccomNPvals(1),openCloseAccomNPvals(2),openCloseAccomNPvals(3),openCloseAccomNPvals(4)) 
sprintf('The accuracy for the professionals accompanied performances was %0.1f for all features, %0.1f for pitch features, %0.1f for timing features, and %0.1f for loudness features.',openCloseAccomPvals(1),openCloseAccomPvals(2),openCloseAccomPvals(3),openCloseAccomPvals(4)) 


sprintf('The accuracy for the human listeners on the professionals a cappella performances was %0.1f and the leave-one out compuational model on the same recordings was %0.1f.',humanAccuracy,mean(listeningAccuracy)) 
