%Function that receives real data, predicted data and calssification value
%as an input.
%Returns confussion matrix for binary classifications
function [confMat]=confMat(real, test, ExVal)
lenReal=length(real);
lenTest=length(test);
excReal=zeros(lenReal,1);
excTest=zeros(lenReal,1);
confMat=zeros(2,2);
if lenReal ~= lenTest
    print("Data lengths are not the same");
else
    for i =1:lenReal
        if real(i)>ExVal
            excReal(i)=1;
        end
        if test(i)>ExVal
            excTest(i)=1;
        end
        if and(excReal(i)== 1,excTest(i)==1)
            confMat(1,1)=confMat(1,1)+1;
        elseif and(excReal(i)== 0,excTest(i)==1)
            confMat(1,2)=confMat(1,2)+1;
        elseif and(excReal(i)== 1,excTest(i)==0)
            confMat(2,1)=confMat(2,1)+1;
        else 
            confMat(2,2)=confMat(2,2)+1;
        end
    end
end
end