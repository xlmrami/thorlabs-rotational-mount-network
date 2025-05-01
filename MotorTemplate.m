function handle=Create_HeadHWP()
%methods and functions
%% Create Matlab Figure Container
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 600;% figure window size;Width
fpos(4) = 400; % Height
fpos(1) = 1000; % Left
fpos(2) = 40; % bottom 
f = figure('Position', fpos,...
           'Menu','None',...
           'Name','Optical Head HWP');
%% Create ActiveX Controller
handle = actxcontrol('MGMOTOR.MGMotorCtrl.1',[0 0 600 400 ], f);
%% Initialize
% Start Control
handle.StartCtrl;
 
% Set the Serial Number
SN = 28252199; % put in the serial number of the hardware
set(handle,'HWSerialNum', SN);

% Indentify the device
handle.Identify;

pause(5); % waiting for the GUI to load up;
end
