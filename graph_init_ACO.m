%Function that receives as an input the length of arrays and arrays that
%will compose the graph of the determined search space.
%Returns the search of the ACO algorithm
function G = graph_init_(x,y)    
G.len.x=length(x);
G.len.y=size(y,1);
for i = 1:G.len.x
    for j =1:G.len.y
        G.nodo(i).x=x(i);
        G.nodo(i).y(j)=y(j,i);
    end
end
%%
G.costMat = zeros(G.len.y,G.len.x);
fitnessFunction=('INSERT FITNESS FUNCTION');
for i = 1:G.len.x
    m=mean(y(:,i));
    for k = 1:G.len.y
            G.costMat(k,i)=fitnessFunction;
    end
end
end
