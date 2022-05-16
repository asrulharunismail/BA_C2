clc;
clear;
close all;
tic
%% Problem Definition
[typeOfFunction] = 'Eil51'; %{'A280','Att532','Berlin52','Eil51','Eil76','Fl1577','KroA100','KroA150','KroA200','KroB100','KroB150','KroB200','KroC100','KroD100','KroE100','Lin318','Pcb442','Pr76','Rat99','Rat783','St70'}
Instance=Tsplib(typeOfFunction);
Dims=Instance.dim;
ObjFunction=@(x) Instance.evaluation( x );             % Objective Function
VarSize=[1 Dims];                                      % Decision Variables Matrix Size

%% Bees Algorithm Parameters
MaxEval = 1000000;
n=10;                               % Number of Scout Bees
nep=10;                             % Number of Max Recruited foragers for the best site
recruitment = round(linspace(nep,1,n));
assigntment = linspace(0,1,n);
ColonySize=sum(recruitment);        % total number of foragers
MaxIt=round(MaxEval/ColonySize);    % Maximum Number of Iterations
%% Initialization
Empty_Bees.Position=[];
Empty_Bees.Cost=[];
Empty_Bees.counter=[];
Bees=repmat(Empty_Bees,n,1);
counter=0;
% Generate Initial Solutions
for i=1:n
    Bees(i).Position=randperm(Dims);
    Bees(i).Cost=ObjFunction(Bees(i).Position);
    counter=counter+1;
    Bees(i).counter= counter;
end

size = linspace(1,1,n);

%% Sites Selection 
[~, RankOrder]=sort([Bees.Cost]);
Bees=Bees(RankOrder);

%P=1;
%% Bees Algorithm Local and Global Search
for it=1:MaxIt
    
    if counter >= MaxEval
        break;
    end

    % All Sites (Exploitation and Exploration)
    for i=1:n

        bestnewbee.Cost=inf;

        assigntment=D_Tri_real_array(0,size(i),1,1,recruitment(i));
        

        for j=1:recruitment(i)
            newbee.Position= Foraging_Combi(Bees(i).Position,assigntment(j)* Dims);
            newbee.Cost=ObjFunction(newbee.Position);
            counter=counter+1;
            newbee.counter= counter;
            if newbee.Cost<bestnewbee.Cost
                bestnewbee=newbee;
            end
        end

        if bestnewbee.Cost<Bees(i).Cost
            Bees(i)=bestnewbee;
        end

    end

    % SORTING
    [~, RankOrder]=sort([Bees.Cost]);
    Bees=Bees(RankOrder);

    % Update Best Solution Ever Found
    OptSol=Bees(1);

    % taking of result
    OptCost(it)=OptSol.Cost;
    Counter(it)=counter;
    Time(it)=toc;
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(OptCost(it)) ' --> Time = ' num2str(Time(it)) ' seconds' '; Fittness Evaluations = ' num2str(Counter(it))]);
    
    figure(1);
    PlotSolution(OptSol.Position,Instance);
end

%% Results
figure;
semilogy(OptCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');

