http://www.eng.buffalo.edu/~nmastron/sourcecode.html

Source Code
Joint physical-layer and system-level power management for delay-sensitive wireless communication

Abstract

We consider the problem of energy-efficient point-to-point transmission of delay-sensitive data (e.g. multimedia data) over a fading channel. Existing research on this topic utilizes either physical-layer centric solutions, namely power-control and adaptive modulation and coding (AMC), or system-level solutions based on dynamic power management (DPM); however, there is currently no rigorous and unified framework for simultaneously utilizing both physical-layer centric and system-level techniques to achieve the minimum possible energy consumption, under delay constraints, in the presence of stochastic and a priori unknown traffic and channel conditions. In this paper, we propose such a framework. We formulate the stochastic optimization problem as a Markov decision process (MDP) and solve it online using reinforcement learning. The advantages of the proposed online method are that (i) it does not require a priori knowledge of the traffic arrival and channel statistics to determine the jointly optimal power-control, AMC, and DPM policies; (ii) it exploits partial information about the system so that less information needs to be learned than when using conventional reinforcement learning algorithms; and (iii) it obviates the need for action exploration, which severely limits the adaptation speed and run-time performance of conventional reinforcement learning algorithms.

Supporting Material

Download the technical report here.

Download the MATLAB source code here.

Source Code Description

There are many source code files contained in the above zip file. Most are just supporting functions. The main files that you can execute to generate many of the results in the above technical report are:

    experiment_k_buffer.m: This file implements the state-of-the-art solution from prior research that is described in the report.
    experiment_PDSlearning.m: This file implements the proposed solution described in the report.
    experiment_Qlearning.m: This file implements an existing reinforcement learning solution, called Q-learning, which is also described in the report.

The top of each of these three files contains many adjustable parameters. When you run the code, these parameters will be saved to a file called parameters.mat that is loaded by various functions to access the current parameter configuration. Ensure that you have sufficient privileges to write over the parameters.mat file.

After running experiment_PDSlearning.m or experiment_Qlearning.m, detailed traces of the results will be in the sim structure. After running experiment_k_buffer.m, detailed trace results will be in the sim structure and some additional average statistics will be in the trace structure. All of these experiment files generate some plots after they run, but more plots can be added depending on what one wants to observe. The entire simulation trace is also saved to a .mat file so you can reload the simulation inputs and outputs without having to run the simulation again (NOTE: The transition probability function is excluded from these files because it wastes harddrive space.)
