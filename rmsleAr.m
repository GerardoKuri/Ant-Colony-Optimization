%Function that receives two numeric data arrays 
%Returns rmsle between arrays
function rmsle=rmsleAr(X,Y)
rmsle=sqrt(mean((log(X+1)- log(Y+1)).^2));
end
