%Function that receives two arrays of numeric data as an input
%Returns RMSE between arrays
function rmse=rmseAr(X,Y)
len=size(Y,1);
for i = 1:len
    rmse(i)=sqrt(mean((X - Y(i,:)).^2));
end
end