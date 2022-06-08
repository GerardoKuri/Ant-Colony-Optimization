%Function that receives ant colony and graph describing search space
%Returns figure with visually described queen ant's tour
function [p1]=drawBestTour(colony,graph)
queenTour=colony.queen.tour;
for i = 1:length(queenTour)-2
    currentNode=queenTour(i);
    nextNode=queenTour(i+1);
    x1=graph.node(i).x;
    y1=graph.node(i).y(currentNode);
    x2=graph.node(i+1).x;
    y2=graph.node(i+1).y(nextNode);
    X=[x1,x2];
    Y=[y1,y2];
    p1=plot(X,Y,'-b','LineWidth',1);
    ylim([0 120])
    hold on
end
for i = 1:graph.len.x
    X=[graph.node(i).x];
    Y=[graph.node(i).y(queenTour(i))];
    plot(X,Y,'*r','markerSize',10);
end
end