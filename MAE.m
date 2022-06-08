%Function that receives two numeric data arrays 
%Returns mae between arrays
function mae=MAE(X,Y)
mae=mean(abs(X-Y));
end