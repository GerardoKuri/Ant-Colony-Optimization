%Function that receives routes and search space
%Returns model that correpsponds to route
function A=convertTour(tour,G)
    len=G.len.x;
    A=[];
    for i=1:len
        A(i)=G.nodo(1,i).y(tour(i));
    end
end

