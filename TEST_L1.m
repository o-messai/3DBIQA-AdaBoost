Score = zeros(365,1);
h = waitbar(0,'Please wait...');
i = 0;
max_disp = 25;
for iPoint = 1:365

   
        %READ A DISTORTED IMAGE
            i = i+1; 
            imDL = imread(['E:\Research\3D Databases\Live 3D Database Austin USA\LIVE3DIQD_phase1\Phase1\3d_IQA_database\' img_names{iPoint}(1:end-4) '_l.bmp']);
            imDR = imread(['E:\Research\3D Databases\Live 3D Database Austin USA\LIVE3DIQD_phase1\Phase1\3d_IQA_database\' img_names{iPoint}(1:end-4) '_r.bmp']);
            imDL = rgb2gray(imDL);
			imDR = rgb2gray(imDR);
            
        %f_L(i,:)     = feature_extract(imDL);
        %f_R(i,:)     = feature_extract(imDR);
        
        f_L(i,:)     = sum(imDL(:));
        f_R(i,:)     = sum(imDR(:));
        
%        Score(i) = BP_Ada(f(:, [1,2,3,4,5,6]), f(:, 7), f_im, 20);
%        Data(i) = struct('features',f_im, 'Score', Score(i));


        waitbar(iPoint/365);
end
close(h);

f = [f_L f_R];