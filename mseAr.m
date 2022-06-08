%Function that receives two numeric data arrays as an input
%Returns mse between arrays
function mse=mseAr(X,Y)
len=size(Y,1);
for i = 1:len
    mse(i)=immse(X,Y(i,:));
end
end