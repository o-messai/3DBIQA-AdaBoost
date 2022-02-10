% =================================================================
%  University of Constantine-1
%  Automatic and Robotic Laboratory
%  Copyright(c) 2017  MESSAI Oussama
%  e-mail: mr.oussama.messai@gmail.com 
%  All Rights Reserved.

% -----------------------------------------------------------------
h = waitbar(0,'Please wait...');
i = 0;
max_disp = 25;

for iPoint = 1:90
  
  

   
        %READ A DISTORTED IMAGE
              
           imDL = imread(['E:\Research\3D Databases\IRCCyN France\IRCCyN_IVC_Quality_Assessment_Of_Stereoscopic_Images\images\' ImageName{iPoint}]);
           imDR = imread(['E:\Research\3D Databases\IRCCyN France\IRCCyN_IVC_Quality_Assessment_Of_Stereoscopic_Images\images\' ImageName{iPoint}(1:4) 'right' ImageName{iPoint}(9:end)]);
           imDL = rgb2gray(imDL);
	       imDR = rgb2gray(imDR);
            
        i = i+1;

        %f_L(i,:) = feature_extract(imDL);
        %f_R(i,:) = feature_extract(imDR);
        f_L(i,:)     = sum(imDL(:));
        f_R(i,:)     = sum(imDR(:));
        %Score(i) = BP_Ada(f(:, [1,2,3,4,5,6]), f(:, 7), f_im, 20);
        %Data(i) = struct('features',f_im, 'Score', Score(i)); 

        
       waitbar(iPoint/90);
end

f_IVC = [f_L f_R];
close(h);


