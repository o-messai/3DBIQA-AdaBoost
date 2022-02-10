function [Quality,WL_R] = BP_Ada(train_data, train_value, test_data, L)

data = [train_data train_value];
% Cross varidation (train: 80%, test: 20%)
cv = cvpartition(size(data,1),'HoldOut',0.2);
idx = cv.test;
% Separate to training and test data
dataTrain = data(~idx,:);
dataTest  = data(idx,:);
% AdaBoosting BP neural network
Test_data = dataTest(:, [1:9])';
Test_value = dataTest(:, 10)';
%confirm the quantity L of the WeakLearns and reform data
train_data_n = dataTrain(:, [1:9])';
train_value_n = dataTrain(:, 10)';

test_data=test_data';


K=size(dataTest, 1);% K in paper
%K=10;
%initialize the distribution D1 of the training set
%D(1,:)=ones(1,K)/K;
D(1,:)=ones(1,K);

for i=1:L %for each WeakLearn
    
   % train ith WeakLearn
    net=newff(train_data_n, train_value_n, [9,9], {'tansig','poslin'}); % poslin purelin
   % net=newff(train_data, train_value, [24,13,22],{'radbas','radbas','tansig'} );
    
    net.trainParam.epochs=100;
    net.trainParam.showWindow=0;
    net.trainParam.lr=0.01;
	net.trainParam.goal=1e-25;
    net.trainParam.max_fail = 15;
    
    %net.dividefcn='dividerand';
    %net.dividefcn='divideblock';
    net.divideParam.trainRatio = 0.85;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0;
    net=train(net,train_data_n,train_value_n);
    % estimate the predicted output of the training set
    BPoutput=sim(net,Test_data);
    
    %compute the difference between the predicted output of the training
    %set and original ones
    train_error(i,:)=Test_value-BPoutput;
	%SIZE = size(train_error)
    
    % estimate the predicted output of the test set
    test_output(i,:)=sim(net,test_data);
	%disp(test_output);
    
    %updata the distribution Di+1 for next WeakLearn and compute the evaluation error of the ith WeakLearn
    all_Error(i)=0;m=0;
    for j=1:K
        if abs(train_error(i,j))>0.2 % threshold=0.1 %j+900
            all_Error(i)=all_Error(i)+D(i,j); 
            %m=m+1;
            D(i+1,j)=D(i,j)*1.2;% sigma=0.1 changed to 0.2
        else
            D(i+1,j)=D(i,j);
        end
    end
    
    %compute the ith WeakLearn weight
%   a(i)=0.5*log((1+all_Error(i))/(1-all_Error(i)));
%   a(i)=sigmf(abs(1-all_Error(i)),[1 0.5]);
    
    a(i)=1/exp(abs(all_Error(i)));
    %a(i) = round(a(i),1);
    %disp(m)
%      disp(all_Error(i));
%      disp(a(i));
%      disp('++++++');

end
%disp(test_output);
a=a/sum(a);
%Sd= size(D)
%the final output

dec=a*test_output;
Quality=dec';

WL_R = [test_output';all_Error;a]; % Weaklearners results

end

