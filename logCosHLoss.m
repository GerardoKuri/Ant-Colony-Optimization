%Function that receives two numeric data arrays as an input
%Returns logarithmic hyperbolic cosine error between arrays
function lcoshL=logCosHLoss(X,Y)
dif=X-Y;
lcoshL=log(cosh(dif));
end
