%Function that recieves the defined search space as an input and necessary
%parameters for ACO algorithm execution.
%Returns ant colony with their respective solutions for the problem.
function colony = colony_init_(G,col,antNo,tau,eta,alpha,beta) 
Nox = G.len.x;
Noy = G.len.y;
for i = 1 : antNo
    nodeInit = randi([1,Noy]);
    colony.ant(i).tour(1)=nodeInit;
    for j = 1: Nox
        Prob_node=tau(:,j).^alpha.*eta(:,j).^beta;
        P = Prob_node./sum(Prob_node);
        nextNode = rouletteWheel(P);
        colony.ant(i).tour=[colony.ant(i).tour,nextNode];
    end 
end
end