%% Initialisation            
Empty_Bees.Position=[];
Empty_Bees.Cost=[];
Empty_Bees.numfeval=[];

tic
Bees=repmat(Empty_Bees,nScoutBee,1);
NFE=0;     %number function of evaluation
totaltime=0;

% Generate Initial Solutions
for i=1:nScoutBee
    Bees(i).Position=randperm(Dims);
    Bees(i).Cost=ObjFunction(Bees(i).Position);
    NFE=NFE+1;
    Bees(i).numfeval= NFE;
    Bees(i).revisits = 0;
end

%% Sites Selection 
% Sort
[~, SortOrder]=sort([Bees.Cost]);
Bees=Bees(SortOrder);

% Update Best Solution Ever Found
BestSol=Bees(1);
BestSol.Cost = Bees(1).Cost;

%% Fibonacci Bees Algorithm Local and Global Search  
it = 1;     % start the iteration

while NFE < MaxEval
    
    % Local Search
    for i=1:nSelectedSite
        nBees = nrpersite(i);
        bestnewbee.Cost=inf;       

        for j=1:nBees
            newbee.Position= WaggleDance(Bees(i).Position);
            newbee.Cost=ObjFunction(newbee.Position);
            NFE=NFE+1;
            newbee.numfeval= NFE;
            newbee.revisits = Bees(i).revisits;
            if newbee.Cost<bestnewbee.Cost
                bestnewbee=newbee;
            end
        end

        if bestnewbee.Cost<Bees(i).Cost
            Bees(i)=bestnewbee;
            Bees(i).revisits = 0;
        else
            Bees(i).revisits = Bees(i).revisits + 1;
            if Bees(i).revisits >= max_rv
               Bees(i).Position= randperm(Dims);
               Bees(i).Cost=ObjFunction(Bees(i).Position);
               Bees(i).numfeval = NFE;
               Bees(i).revisits = 0;     
            end
        end

    end
    
    % Global search
    for i=nSelectedSite+1:nScoutBee
        Bees(i).Position= randperm(Dims);
        Bees(i).Cost=ObjFunction(Bees(i).Position);
        NFE=NFE+1;
        Bees(i).numfeval = NFE;
        Bees(i).revisits = 0;
    end

    % SORTING
    [~, SortOrder]=sort([Bees.Cost]);
    Bees=Bees(SortOrder);

    % Update Best Solution Ever Found
    OptSol=Bees(1);
    if OptSol.Cost < BestSol.Cost
        BestSol=OptSol;
    end
    
    % Best Result
    OptCost(it)=BestSol.Cost;
    NFEcount(it)=NFE;

    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(OptCost(it)) ' --> NFE = ' num2str(NFEcount(it))]);    

    %update the iteration count
    it = it + 1;
end
Time=toc;
totaltime = totaltime + Time;

%% Results
%figure;
semilogy(OptCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
