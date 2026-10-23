%this script is to plot speed-torque charactersitic of an induction motor model
%place this script in the same folder as the model to be simulated
clear
clc

mdl = "inductionmotor";  %name of model to be simulated
start = 0; %starting torque
final = 210; %final torque
points = 150; %number of points inbetween, increase for better resolution
    
ex = 10; %number of extra points held at the final torque
range = [linspace(start,final,points), repelem(final,ex)]; %creates intermediate points
result = zeros(length(range),2);   %create a matrix for storing results          

tor = 0; %no load torque
set_param(mdl,SimulationCommand="start") %starts simulation

pause(2); %pause script excution to allow motor to start
set_param(mdl,SimulationCommand="pause") %pause simulation to allow matlab record data
result(1,1) = speed.Data(end); %record speed
result(1,2) = torque.Data(end); %record torque
set_param(mdl,SimulationCommand="continue") %continue simulation

for i = 2:length(range) %loop to increase torque and record resulting changes
    tor = range(i); %increase torque
    set_param(mdl,SimulationCommand="update") %update value in simulation
    pause(0.15);
    set_param(mdl,SimulationCommand="pause") %pause to record data
    result(i,1) = speed.Data(end); %record speed
    result(i,2) = torque.Data(end); %record torque
    set_param(mdl,SimulationCommand="continue") %resume simulation  
end
set_param(mdl,SimulationCommand="stop") %stop simulation when all recordings are taken
speed = result(:,1); 
torque = result(:,2);

plot(speed,torque) %plot speed vs torque
xlim([0 1550])