function f= feature_extract(im)
    [RO, GM, RM]=FGr(im);% compute the RO RM and GM map
   % figure, imshow(GM);figure, imshow(RM);figure, imshow(RO);
    f1=VarInformation(GM, 2);% compute the statistics variance of GM

    f2=VarInformation(RO, 1);% compute the statistics variance of RO
    
    f3=VarInformation(RM, 2);% compute the statistics variance of RM

%% feature
    f=[f1, f2, f3];
end