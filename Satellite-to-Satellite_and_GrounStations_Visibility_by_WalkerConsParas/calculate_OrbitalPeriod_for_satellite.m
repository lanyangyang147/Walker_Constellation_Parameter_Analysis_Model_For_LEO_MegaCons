function [output_orbital_period] = calculate_OrbitalPeriod_for_satellite(earth_radius_in_km,altitude_in_km)
%CALCULATE_ORBIT_PERIOD_FOR_SATELLITE 此处显示有关此函数的摘要
%   此处显示详细说明

sat_radius_in_km = earth_radius_in_km + altitude_in_km;

sat_radius_in_m = (sat_radius_in_km * 1000 )^3;

Gravitational_constant = 6.673 * 10^(-11);%unit:Nm^2 / kg^2;
Earth_mass = 5.98 * 10^24;% unit:kg^2

orbital_period = 2 * pi * sqrt(sat_radius_in_m / ( Gravitational_constant * Earth_mass));
%output
output_orbital_period = orbital_period;
end

