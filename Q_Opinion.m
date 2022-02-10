function [S] = Q_Opinion(Score)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
char = ["Excellent","Good","Fair","Poor","Unacceptable"];

if Score <= 0.2
    ind = 1;
end
if Score > 0.2 && Score <= 0.4
    ind = 2;
end 
if Score > 0.4 && Score <= 0.6
    ind = 3;
end
if Score > 0.6 && Score <= 0.8
    ind = 4;
end
if Score > 0.8
    ind = 5;
end

S = ['The Quality is :',char(ind)];
end

