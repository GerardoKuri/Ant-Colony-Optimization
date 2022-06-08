clear all;
close all;
clc;
%%
%Initialize graph
%Define arrays from database
%define Array of real data 
yAct=transpose(csvread('Input CSV here'));
%Define arrays that will get optimized and will define the graph 
y1=transpose(csvread('Input CSV here'));
y2=transpose(csvread('Input CSV here'));
y3=transpose(csvread('Input CSV here'));

%%
%Any preprocessing arrays may require
%Defining graph size
x = 1:1:size(y1,2);
y=[y1;y2;y3];
G = graph_init_(x,y,yAct);
%%
%%ACO algorithm
%Quantity of Max Iterations 
M=1000;
%Quantity of experiments
E=25;
%Quantity of ants
antNo=5;
%Initial value of pheromone matrix, could be a constant too, Ex: 0 or 1
tau0 = 10*1/(G.len.x * mean(G.costMat(:)));
tau = tau0*ones(G.len.y,G.len.x);
%Feasibility calculus
eta = 1./G.costMat;
%Evaporation rate, Ex: 0.1 = 10% of evaporation rate
rho=0.1;
%Pheromones weight
alpha=1;
%Feasibility weight
beta=1;
%Delta criteria
%Delta criteria will make algorithm stop after deltaIt number of iterations
%with a fitness differential of less than delta
delta=0.001;
deltaIt=80;
for i =1:E
%Pheromone matrix refresh   
tau = tau0*ones(G.len.y,G.len.x);
bestFit=inf;
bestTour=[];
cont=1;
D=0;
deltaVar=inf;
    %%
while cont<M & D<deltaIt
    colony=[];
    %Colony initialization
    colony = colony_init_(G,colony,antNo,tau,eta,alpha,beta);
    %Fitness calculus of each ant
    for j= 1:antNo
        colony.ant(j).fitness=rmsemodels(colony.ant(j).tour,G);
    end
    allAntsFitness=[colony.ant(:).fitness];
    %Best fitness of ants
    [minVal,minIndex]=min(allAntsFitness);
    %"Queen ant"'s fitnessasignation
    if minVal<bestFit
        bestFit=colony.ant(minIndex).fitness;
        bestTour=colony.ant(minIndex).tour;
    end
    colony.queen.tour=bestTour;
    colony.queen.fitness=bestFit;
    %Calculating delta using queen's fitness considering past iteration
    Delta=deltaVar-colony.queen.fitness;
    %If there is no better route add this iteration for stop criteria
    if (Delta)<delta
        D=D+1;
    else
        D=0;
    end
    deltaVar=colony.queen.fitness;
    %Updating pheromone matrix
    tau=updatePherMin(tau,colony);
    %Evaporation of pheromones 
    tau=(1-rho).*tau;
    %For evaluation purposes some evaluation metrics arrays are calculated
    %(To compare results through iterations)
    mae=MAE(yAct,convertTour(colony.queen.tour,G));
    mse=immse(yAct,convertTour(colony.queen.tour,G));
    %Display of some metrics thorugh iterations
    seg=['iter #:',num2str(cont),',  Best fitness found:',num2str(colony.queen.fitness),',  Delta criteria:',num2str(D),',  Experiment #:',num2str(i)];
    display(seg);
    cont=cont+1;
    %Save evaluation metric arrays
    MSE(cont)=mse;
    maeACO(cont)=mae;
    rmse(cont)=sqrt(mean((yAct - convertTour(colony.queen.tour,G)).^2));
    FIT(cont)=bestFit;
    Xcont(cont)=cont;
end
     %Convert ant tour to optimized model (Will need to implement own
     %function, this function considers specific optimized structure)
     A=convertTour(colony.queen.tour,G);
     fAcum(i)=rmse(cont);
     maeACOacum(i)=MAE(yAct,A);
     RACO=corrcoef(yAct,A);
     rACOacum(i)=RACO(1,2);
     r2ACOacum(i)=rACOacum(i)^2;
     tim(i)=toc
end
mean(tim)
mean(fAcum)
std(fAcum)
%%
%Calculating optimized route evaluation metrics (use in case there is some
%array reference
rmsleACO=rmsleAr(yAct,A);
RACO=corrcoef(yAct,A);
rACO=RACO(1,2);
r2ACO=rACO^2;
rmse=rmseAr(yAct,A);
maeACO=MAE(yAct,A);
