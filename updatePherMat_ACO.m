%Function that receives pheromone matrix and colony with their respective
%trajectories as an input.
%Returns updated pheromone matrix
function tau = updatePherMin(tau, colony)
nodeNo=length(colony.ant(1).tour);
antNo=length(colony.ant(:));
for i = 1:antNo
    for j=1:nodeNo-1
        currentNode=colony.ant(i).tour(j);
        tau(currentNode,j)=((tau(currentNode,j)+1./colony.ant(i).fitness));
    end
end
end