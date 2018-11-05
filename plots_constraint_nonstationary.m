% Plot results generated by 
%   batch_constraint_nonstationary.m
%   experiment_k_buffer.m
% And plot information in nonstationaryDynamics.mat

constraintSet = [1:9];
PonSet = [320/1000 160/1000 80/1000]; % W

string_matrix = [];
for i = 1:length(PonSet)
    initArrRate = i;
    string_matrix = strvcat(string_matrix,sprintf('Pon = %d mW',PonSet(i)*1000));
end
line_type_matrix = strvcat('bh--','go--','rx--','c+-','ms-','kv-','yd-');

%%%%%%%%%%%%%%
%%%% PLOT %%%%
%%%%%%%%%%%%%%
% Load proposed results
powerProposed = zeros(length(constraintSet),length(PonSet));
delayProposed = zeros(length(constraintSet),length(PonSet));
for constraintIdx = 1:length(constraintSet)
    for PonIdx = 1:length(PonSet)
        inmat = ['results_PDSlearning_constraint' num2str(constraintSet(constraintIdx)) '_Pon' num2str(PonSet(PonIdx)*1000) '_nonstationary.mat']
        load(inmat,'sim','B');
        
        powerProposed(constraintIdx,PonIdx) = mean(sim.powerPoints);
        holdingProposed(constraintIdx,PonIdx) = mean(sim.holdingCostPoints);
    end
end

% Load k buffer (Klara's) results
load results_k_buffer_nonstationary_001 trace
figure; 
set(gca,'FontSize',12);
for PonIdx = 1:length(PonSet)
    proposedPlot(PonIdx) = plot(holdingProposed(:,PonIdx)*B,powerProposed(:,PonIdx)*1000,'bh--','LineWidth',2); hold on;
end
kbufferPlot(1) = plot(trace.holdingCostPoints(5,2:end-2)',1000*trace.powerPoints(5,2:end-2)','rv-','LineWidth',2); hold on;
kbufferPlot(2) = plot(trace.holdingCostPoints(6,2:end-2)',1000*trace.powerPoints(6,2:end-2)','rv-','LineWidth',2); hold on;
kbufferPlot(3) = plot(trace.holdingCostPoints(7,2:end-2)',1000*trace.powerPoints(7,2:end-2)','rv-','LineWidth',2); hold on;
xlabel('Holding cost (packets)'); ylabel('Power (mW)');
legend([proposedPlot(1), kbufferPlot(1)], 'Proposed','Threshold-k');
axis([1 8 45 275]);
    
%%%%%%%%%%%%%%
%%%% PLOT %%%%
%%%%%%%%%%%%%%
figure;
set(gca,'FontSize',12);
actualPlot = plot(constraintSet,holdingProposed(constraintSet,1)*B,'bo-','LineWidth',2); hold on;
idealPlot = plot(constraintSet,constraintSet,'r--','LineWidth',1.5);
xlabel('Holding cost constraint (packets)'); ylabel('Holding cost (packets)');
legend([actualPlot, idealPlot], 'Achieved','Ideal');

%%%%%%%%%%%%%%
%%%% PLOT %%%%
%%%%%%%%%%%%%%
load nonstationaryDynamics;
figure;
set(gca,'FontSize',12);
plot([1:n],meanArrivalRates(1:n)*100,'LineWidth',2);
set(gca,'PlotBoxAspectRatio', [2 1 1]);
xlabel('Time slot (n)'); ylabel('Expected arrival rate (packets/s)');
axis([0,75000,-50,450]);

%%%%%%%%%%%%%%
%%%% PLOT %%%%
%%%%%%%%%%%%%%
figure;
skip = 100;
thickness = 10;
numChannelStates = size(channelMatrices(1).T_h,1);
img = zeros(thickness*numChannelStates, n/skip);
for i = [1:skip:n]
    for j = 1:numChannelStates
        rng = [(j-1)*thickness+1:j*thickness];
        selfTransProbs = diag(channelMatrices(i).T_h);
        img(rng,floor(i/skip)+1) = selfTransProbs(j);
    end
end
imshow(img,[]);
% xlabel('Time slot (n)'); ylabel('Channel state (h)');
% title('Non-stationary self-transition probabilities');
