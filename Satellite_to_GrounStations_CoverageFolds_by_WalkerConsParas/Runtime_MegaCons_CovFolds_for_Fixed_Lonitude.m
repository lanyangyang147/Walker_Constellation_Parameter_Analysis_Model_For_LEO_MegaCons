%---【Remove the Part of STK】----------------
tic
clear;clc;close all;
%% Step0 basic parameters of constellation

Num_of_sats = 10000;% sum satellites

Planes_num = 100;% sum number of orbital planes
F_factor = 1;% phase parameters for walker cons
orbit_inclination = degToPiDeg(53);%orbital inclination,unit:deg
orbit_altitude_in_km = 1500;%orital altitude,unit:km


Min_elevation = degToPiDeg(25);%the minimum elevation for ground station,unit:deg

latitude_start = 0;
latitude_end = 60;
%start time:2022/08/26---00:00:00---
%end time:2022/08/27---00:00:00---
Num_of_orbitPeriod = 5;
Earth_radius_in_km = 6378;% the radius of earth,unit:km
Orbital_period = calculate_orbit_period_for_satellite(Earth_radius_in_km,orbit_altitude_in_km);%unit:s
%% Step1-- STK Numerical Result--- Basic parameters--Facility-Latitude/Longitude---
longitude_fixed = 40;
latitude_step = 1;
STK_Facility_Access_data = cell(10,9);
%column-format: Facility_name + lat + lon +  
            %  (STK) Access_data+ Min fold + Max Fold + Avg Fold
            %  Num of 'disconnected' facilities + disconnected time (if Min fold = 0)
Facility_count = 0;
% new Facility
for latitude = latitude_start:latitude_step:latitude_end 
    Facility_count = Facility_count +1;
    Facility_name = ['Facility' num2str(Facility_count)];
  
    STK_Facility_Access_data{Facility_count,1} = Facility_name;
    STK_Facility_Access_data{Facility_count,2} = latitude;
    STK_Facility_Access_data{Facility_count,3} = longitude_fixed;   
end
STK_Facility_Access_data = STK_Facility_Access_data(1:Facility_count,:);
%% Step3-- 2DMap Sim Result---Esatblishing the phase mapping on 2D Map and select the unit grid---
%---sat:orbit-id + sat_on_orbit_id
Sat_orb_AND_position = gene_sat_orbit_AND_position(Num_of_sats,Planes_num);
%sat_str = find_sat_string(sat_index,Sat_orb_AND_position);
Sats_Raan_Phase = sat_converts_raan_AND_phase(Num_of_sats,Planes_num,F_factor);
%convert range:[0,2*pi]--->[-pi,pi]
Sats_Raan_Phase = convert_range(Sats_Raan_Phase);
%% Step 4- 2DMap Sim Result-Select the target latitude(arbitrary longitude) and calculate phase/access area
%(1)calulate the half angle of coverage region ------Eqn.(4)
coverage_half_angle = calcluate_half_angle_of_coverage_region(Earth_radius_in_km,orbit_altitude_in_km,Min_elevation);
Alpha_D = coverage_half_angle;
%(2)calulate the location in 2D map------Eqn.(12) 
%[Raan_T_positive,Phase_T_positive]= lat_lon_convert_to_phase_2DMap(orbit_inclination,Target_latitude,Target_longitude);
%(3)calulate the Access area -----------Eqn.(8)
%[coverage_flag,Condition1,Condition2] = calcluate_Access_area(Raan,Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D);

Raan_change_rate = degToPiDeg(15)/3600;%unit:-w_earth:15deg/h---->> deg/sec
Phase_change_rate = 2 * pi / Orbital_period;
Start_time = 0;
Time_Step = 60;
Map2D_Facility_Sim_coverage_folds = cell(size(STK_Facility_Access_data,1),7);
%column-format: Facility_name + lat + lon +  
            %  (2D Map) Access_data + Min fold + Max Fold + Avg Fold
Map2D_Facility_Sim_coverage_folds(:,1:3) = STK_Facility_Access_data(:,1:3);
%Target_longitude = degToPiDeg(20);%longitude----【arbitrary】----
for k = 1:size(Map2D_Facility_Sim_coverage_folds,1)
    Target_latitude = degToPiDeg(Map2D_Facility_Sim_coverage_folds{k,2});
    Target_longitude = degToPiDeg(Map2D_Facility_Sim_coverage_folds{k,3});
    
    Tmp_Facility_coverage_folds = cell(10,3);
    %Access_data-column-format: Time + coverage_folds + Accessed_sats
    count = 0;
    for time = Start_time:Time_Step:Orbital_period * Num_of_orbitPeriod
        % update all the sats phase in the 2D Map 
        Now_Sats_Raan_Phase= update_Raan_AND_Phase_for_all_sats(time,Raan_change_rate,Phase_change_rate,Sats_Raan_Phase);
        Accessed_sats = Judge_whether_is_Acccessed_sats(Now_Sats_Raan_Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D);
        %storage
        count = count + 1;
        Tmp_Facility_coverage_folds{count,1} = time;
        Tmp_Facility_coverage_folds{count,2} = size(Accessed_sats,1);
%        Tmp_Facility_coverage_folds{count,3} = Accessed_sats;
        column = 2;
        for m = 1:size(Accessed_sats,1)
            column = column + 1;
            Tmp_Facility_coverage_folds{count,column} = find_Accessed_Satellite_Name(Accessed_sats(m,1),Sat_orb_AND_position);
        end
    end
    Tmp_Facility_coverage_folds = Tmp_Facility_coverage_folds(1:count,:);
    [MIN_fold,MAX_fold,AVG_fold] = gene_coverage_fold_result(Tmp_Facility_coverage_folds);
    %--------storage-------------
    Map2D_Facility_Sim_coverage_folds{k,4} = Tmp_Facility_coverage_folds;
    Map2D_Facility_Sim_coverage_folds{k,5} = MIN_fold;
    Map2D_Facility_Sim_coverage_folds{k,6} = MAX_fold;
    Map2D_Facility_Sim_coverage_folds{k,7} = AVG_fold;
end

Coverage_Folds_fixedLon_with_diff_Lat = gene_CoverageFold_data_for_Origin(Map2D_Facility_Sim_coverage_folds);

Res_file_name = ['MegaCons_' num2str(Num_of_sats) '_Sats_FixedLon_' num2str(longitude_fixed) 'deg_with_diff_lat.xlsx'];


%writematrix(Coverage_Folds_fixedLon_with_diff_Lat,Res_file_name);
toc



