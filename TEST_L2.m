Score = zeros(360,1);
h = waitbar(0,'Please wait...');
i = 1;
max_disp = 25;

%% Mesure the quality of the Stereo Image
for iPoint = 1:360
                                                                           % READ A DISTORTED IMAGE
              
        Id = imread(['E:\Research\3D Databases\Live 3D Database Austin USA\Phase2\Stimuli\' StiFilename{iPoint}]);
        sizeTemp = size (Id);
        Id = rgb2gray(Id); 
        imDL = Id(:,1:sizeTemp(2)/2,:);
        imDR = Id(:,sizeTemp(2)/2+1:end,:);       
                                                                           % OBJECTIVE METRIC FUNCTION
        
       % f_L(i,:)     = feature_extract(imDL);
        %f_R(i,:)     = feature_extract(imDR);
        f_L(i,:)     = sum(imDL(:));
        f_R(i,:)     = sum(imDR(:));
        %Score(i) = BP_Ada(Fe(:, [1:9]), Fe(:, 10), f_im, 20);
        %Data_M(i) = struct('features',f_im, 'Score', Score(i));           % STOCK THE FEATURES AND QUALITY SCORES
        waitbar(iPoint/360);
        i = i+1;
end
close(h);

f = [f_L f_R];