clear;clc;close all;
%% Step0 basic parameters of constellation
Total_number_of_sats = 1584;
Num_of_orbital_planes = 24;
Phase_factor = 1;
inclination = value2PIdeg(53);%unit:2*pi 
altitude_in_km = 550;%unit:km

Whether_Calculated_Facility_to_Sats_link = 1;
if Whether_Calculated_Facility_to_Sats_link
    %---------Set up Facility and start time------
    Facility_lat = 45;%unit:deg
    Facility_lon = 20;%unit:deg
    Facility_height = 0;%unit:km
    GS_Min_Elevation = value2PIdeg(25);%unit:2*pi 
    Init_UTC_Time = [2022 8 26 0 0 0];%year + month + day + hour + minutes + seconds
    Num_of_Orbital_Period = 1;
    Time_step_in_seconds = 5;%unit:sec

    Calculate_all_GSLs_flag = 0;
    if ~Calculate_all_GSLs_flag
       Calculate_Sats_Num = [16 19;16 65;17 26;18 51;21 65;22 35;23 27];%orbitNum + SatNum (orbitNum:1...24 + SatNum：1...66)
    end
end

Whether_Calculated_inter_Satellite_link = 0;
if Whether_Calculated_inter_Satellite_link
    %---------Set up the reference sat------
    ref_sat_orbitalPlane = 0;%e.g, j = 0,1,...,Num_of_orbital_planes - 1;
    ref_sat_position_in_OrbitalPlane = 0;%e.g, k = 0,1,....,Num_of_sats_per_orbitalPlane-1
    Time_step_in_secs = 5;%unit:minutes
    Num_of_Orbital_Period_for_ISL = 1;

    Protect_clearance_altitude = 80;%unit:km
    Min_ISL_elevation = 10;
    Max_ISL_elevation = 20;

    Calculate_all_ISLs_flag = 0;
    if ~Calculate_all_ISLs_flag
       Calculate_Sats_Num = [04 01;08 60;10 44;13 43;18 13;23 62;];%orbitNum + SatNum (orbitNum:1...24 + SatNum：1...66)
    end
end
%------basic para-----------
Num_of_sats_per_orbitalPlane = Total_number_of_sats / Num_of_orbital_planes;
earth_radius_in_km = 6378;%unit:km
sat_radius_in_km = earth_radius_in_km + altitude_in_km;
orbital_period = calculate_OrbitalPeriod_for_satellite(earth_radius_in_km,altitude_in_km);%unit:s
%% Step1---------The proposed anslysis model---------------------------
%---sat:orbit-id + sat_on_orbit_id
Sat_orb_AND_position = gene_sat_orbit_AND_position(Total_number_of_sats,Num_of_orbital_planes);
%Then---->>> select the reference satellite---------- j = 0;k = 0---------
%e.g, j = 0,1,...,Num_of_orbital_planes - 1;
%e.g, k = 0,1,....,Num_of_sats_per_orbitalPlane-1
%ref_sat_orbitalPlane = 0;
%ref_sat_position_in_OrbitalPlane = 0;

if Whether_Calculated_Facility_to_Sats_link
   Facility_to_Sats_link;
end
if Whether_Calculated_inter_Satellite_link
    Satellite_to_Sats_link;
end