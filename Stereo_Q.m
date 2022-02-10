function [Score,CImg, dmap,WL_R] = Stereo_Q(S_img,max_disp,Data,L)
% =================================================================
%  University of Constantine-1
%  Automatic and Robotic Laboratory
%  Copyright(c) 2017  MESSAI Oussama
%  e-mail: mr.oussama.messai@gmail.com 
%  All Rights Reserved.

% -----------------------------------------------------------------

addpath ( genpath ( 'AdaBoost net' ) );                                         
addpath ( genpath ( 'Cyclopean Image' ) );  

% Select the Stereo image and max disp
                                                           % number of WeakLearners
    
        sizeTemp = size (S_img);
        imL = S_img(:,1:sizeTemp(2)/2,:);
        imR = S_img(:,sizeTemp(2)/2+1:end,:);  

if(size(imL,3)==3)
   
    imL = rgb2gray(imL);
    imR = rgb2gray(imR);
    
end
%% Mesure the quality of the Stereo Image

                                                                       
        [CImg, dmap] = Cyclopean(imL,imR,max_disp);
      
        %     Img = uint8(Img);                                              % DISPLAY THE CYCLOPEAN IMAGE
        %     figure, imshow(Img);
    
   %% scale 1:
        f_im(1:3)     = feature_extract(CImg);
   %% scale 2:	
        im2=imresize(CImg,0.5);
		f_im(4:6)     = feature_extract(im2);
		f_im(7:9)     = feature_extract(dmap);
		
        [Score,WL_R] = BP_Ada(Data(:, [1:9]), Data(:, 10), f_im, L);
        %Data = struct('features',f_im, 'Score', Score(i));           % STOCK THE FEATURES AND QUALITY SCORES
     
               

%% Metric Evaluation


end

