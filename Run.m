% =========================================================================
%  University of Constantine-1
%  Automatic and Robotic Laboratory
%  Copyright(c) 2017  MESSAI Oussama
%  e-mail: mr.oussama.messai@gmail.com 
%  All Rights Reserved.
%
% -------------------------------------------------------------------------
%% 
clc;
clear;
close all; warning off;
addpath ( genpath ( '.mat files' ) ); 
addpath ( genpath ( 'Test_Stereo-Images' ) );
addpath ( genpath ( 'AdaBoost net' ) );                                         
addpath ( genpath ( 'Cyclopean Image' ) );  
load('features.mat');  


Data = [features];
% Select the Stereo image and max disp
        L = 20;                                                        % number of WeakLearners
        max_disp = 25;
        Id = imread('0.bmp');
        sizeTemp = size (Id);
        Id1 = rgb2gray(Id); 
        imL = Id1(:,1:sizeTemp(2)/2,:);
        imR = Id1(:,sizeTemp(2)/2+1:end,:);  
		
%% Mesure the quality of the Stereo Image

tic                                                                     
        [Img, dmap] = Cyclopean(imL,imR,max_disp);
      
%              Img = uint8(Img);                                              % DISPLAY THE CYCLOPEAN IMAGE
%               figure, imshow(Img, []);
%               figure, imshow(dmap, []);
   %% scale 1:
        f_im(1:3)     = feature_extract(Img);
   %% scale 2:	
        im2=imresize(Img,0.5);
		f_im(4:6)     = feature_extract(im2);
		f_im(7:9)     = feature_extract(dmap);
   %% Assess the Quality
   toc
        [Score,WL_R] = BP_Ada(Data(:, [1:9]), Data(:, 10), f_im, L);
        
toc        
RunTime = datestr(seconds(toc),'HH:MM:SS');   
disp(['RunTime : ' num2str(RunTime)]);
        %Data = struct('features',f_im, 'Score', Score(i));           % STOCK THE FEATURES AND QUALITY SCORES
        disp(Score);
        [S] = Q_Opinion(Score)      

%% Metric Evaluation

% qualityFactor = 1:5:50;
% for i = 1:5
%          
%         %Deg = imnoise(Id,'gaussian',qualityFactor(i)/100);
%         %imwrite(Deg,'NoiseImage.bmp','bmp');
%         imwrite(Id,'compressedImage.jpg','jpg','quality',qualityFactor(i));
%         Id2 = imread('compressedImage.jpg'); %figure, imshow(Id2);
%         %Id = imread('NoiseImage.bmp');
%         [Score(i),CImg, dmap, WL_R] = Stereo_Q(Id2,25,Data,20);
%         [S] = Q_Opinion(Score(i))    
%         CImg = uint8(CImg);                                              % DISPLAY THE CYCLOPEAN IMAGE
%         figure, imshow(CImg);
%         figure, imshow(dmap,[]);
%       
%         
% end
% %%
% %Plot the results. Note how the image quality score improves as you increase the quality value specified with imwrite.
% figure,
% plot(qualityFactor(1:5),Score(1:5),'b-o');
% 
% xlabel('Distortion Factor');
% ylabel('Metric Value');
% grid on