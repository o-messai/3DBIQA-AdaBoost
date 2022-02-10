function [Img, dmap] = Cyclopean(imL,imR,max_disp)




% Input

% imL - test_left view
% imR - test_right view
% max_disp  - max disparity value . This value may be tuned for different dataset.  

% Output
% Img - Cyclopean Image
% dmap - estimated disparity from test pair

if (nargin < 2)
    score = -Inf;
    disparity_map = 0;
    return;
end
if (nargin ==2 )
    max_disp = 25;  % the dault value is set based on experiments on LIVE 3D IQA database
end


if(size(imL,3)==3)
   
    imL = rgb2gray(imL);
    imR = rgb2gray(imR);
    
end


imsz = size(imL);


[fdsp, dmap, confidence, diff] = mj_stereo_SSIM(imL,imR, max_disp);
[ disp_comp_dl] = mj_computeDispCompIm( imL,imR,dmap );


[D_L_Gabor_RS,D_L_Gabor_Bound]=ExtractGaborResponse(imL);
[Syn_D_Gabor_RS,Syn_D_Gabor_Bound]=ExtractGaborResponse(imR);


SL_en=zeros(imsz(1),imsz(2),2); %4-scales
SS_en=zeros(imsz(1),imsz(2),2); %4-scales
for mm=1:4
    SL_en(:,:,mm) = D_L_Gabor_RS{2+mm,1}+D_L_Gabor_RS{2+mm,2}+D_L_Gabor_RS{2+mm,3}+D_L_Gabor_RS{2+mm,4}+D_L_Gabor_RS{2+mm,5}+D_L_Gabor_RS{2+mm,6}+D_L_Gabor_RS{2+mm,7}+D_L_Gabor_RS{2+mm,8};
    SS_en(:,:,mm) = Syn_D_Gabor_RS{2+mm,1}+Syn_D_Gabor_RS{2+mm,2}+Syn_D_Gabor_RS{2+mm,3}+Syn_D_Gabor_RS{2+mm,4}+Syn_D_Gabor_RS{2+mm,5}+Syn_D_Gabor_RS{2+mm,6}+Syn_D_Gabor_RS{2+mm,7}+Syn_D_Gabor_RS{2+mm,8};;
end
GBD_L = SL_en(:,:,1) ;
GBD_R = SS_en(:,:,1) ;


[ disp_comp_GBdl ] = mj_computeDispCompIm( GBD_L,GBD_R,dmap );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[ Img ] = mj_GenMergeWEntropy( imL,imR,GBD_L,GBD_R );
%[ Img ] = mj_GenMergeWEntropy( imL,imR,GBD_L,GBD_R );

[ Img ] = mj_GenMergeWEntropy( imL,disp_comp_dl,GBD_L,disp_comp_GBdl );
%[ Img ] = mj_GenMergeWEntropy( imL,imR,GBD_L,disp_comp_GBdl );


% [ GB_W_D, syn_GBd ] = mj_GenMergeView( GBD_L,GBD_R,Dmap_L );
 %[ Img, syn_d ] = mj_GenMergeView( imL,imR,Dmap_L );
end




