function [output_PI_deg] = value2PIdeg(Value)
%VALUE2PIDEG 此处显示有关此函数的摘要
%   此处显示详细说明

PI_deg = Value/360 * 2 * pi;%unit:2*pi 

%output
output_PI_deg = PI_deg;
end

