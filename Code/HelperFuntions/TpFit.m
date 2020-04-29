function [params,error,AIC] = TpFit(Data,Target)

SIM = [Data;Target];

%Set options
optionsTp = optimoptions('fmincon','Algorithm','sqp','MaxFunctionEvaluations',1e16,'OptimalityTolerance',1e-16);

%Set initials (C A E F); F must be at least 5 times lower than C;
C = rand(1);
F = 0+((C/5)-0)*rand;
x0 = [C, rand(1,2), F];

%Set linear constraints
Ac = [-1 0 0 5; eye(4); eye(4)*-1];
bc = [0; 1; 1; 1; 1; 0; 0; 0; 0];

[params, error] = fmincon(@sq_err, x0, Ac, bc, [], [], [], [], [], optionsTp, SIM);

AIC = 2*length(x0) + length(params(1,:))*log(error/length(params(1,:)));

end

function [sq_err, simulations] = sq_err(params, X)

%Cost function for fmincon 

%Simulate behavior from initial parameters
simulations = TwopSim(params, X(2,:));

%Calculate Squared Error - between data and simulation
sq_err = nansum((X(1,:) - simulations).^2); 

end