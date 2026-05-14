 %---Calcluate Coverage folds for Constellation 2022/08/26 ---------------
clear;clc;
MegaCons_Type = 3;
%Mega-Constellation Type:
% 1--StarLink_Phase1_1584_24_1; 
% 2--Kuiper_Phase1_1156_34_1;
% 3--Telesat_Phase2_1320_40_1
%% Step0 basic parameters of constellation
if MegaCons_Type == 1
    Num_of_sats = 1584;% sum satellites
    Planes_num = 24;% sum number of orbital planes
    F_factor = 1;% phase parameters for walker cons

    orbit_inclination = degToPiDeg(53);%orbital inclination,unit:deg
    orbit_altitude_in_km = 550;%orital altitude,unit:km
    Min_elevation = degToPiDeg(25);%the minimum elevation for ground station,unit:deg

    latitude_start = 0;
    latitude_end = 60;

    MegaCons_String = 'Starlink_Phase1_';
    %Num_of_orbitPeriod = 4;
elseif MegaCons_Type == 2
    Num_of_sats = 1156;% sum satellites
    Planes_num = 34;% sum number of orbital planes
    F_factor = 1;% phase parameters for walker cons
    
    orbit_inclination = degToPiDeg(51.9);%orbital inclination,unit:deg
    orbit_altitude_in_km = 630;%orital altitude,unit:km
    Min_elevation = degToPiDeg(35);%the minimum elevation for ground station,unit:deg

    latitude_start = 0;
    latitude_end = 58;

    MegaCons_String = 'Kuiper_Phase1_';
elseif MegaCons_Type == 3
    Num_of_sats = 1320;% sum satellites
    Planes_num = 40;% sum number of orbital planes
    F_factor = 1;% phase parameters for walker cons
    
    orbit_inclination = degToPiDeg(50.88);%orbital inclination,unit:deg
    orbit_altitude_in_km = 1325;%orital altitude,unit:km
    Min_elevation = degToPiDeg(10);%the minimum elevation for ground station,unit:deg
 
    latitude_start = 0;
    latitude_end = 60;

    MegaCons_String = 'Telesat_Phase2_';
end

%start time:2022/08/26---00:00:00---
%end time:2022/08/27---00:00:00---
Num_of_orbitPeriod = 4;
Earth_radius_in_km = 6378;% the radius of earth,unit:km
Orbital_period = calculate_orbit_period_for_satellite(Earth_radius_in_km,orbit_altitude_in_km);%unit:s
Cons_Walker_Paras_Str = [num2str(Num_of_sats) '_' num2str(Planes_num) '_' num2str(F_factor)];
%% Step1-- STK Numerical Result--- Basic parameters--Facility-Latitude/Longitude---
longitude_fixed = 20;
latitude_step = 1;
STK_Coverage_Folds_data = cell(10,6);
%column-format: Facility_name + lat + lon +  
            %  (STK) Min fold + Max Fold + Avg Fold
Facility_count = 0;
% new Facility
for latitude = latitude_start:latitude_step:latitude_end 
    Facility_count = Facility_count +1;
    Facility_name = ['Facility' num2str(Facility_count)];
  
    STK_Coverage_Folds_data{Facility_count,1} = Facility_name;
    STK_Coverage_Folds_data{Facility_count,2} = latitude;
    STK_Coverage_Folds_data{Facility_count,3} = longitude_fixed;   
end
STK_Coverage_Folds_data = STK_Coverage_Folds_data(1:Facility_count,:);
%% Step2--STK Numerical Result--Start Calcualte coverage fold for the specified facility
%--------Read Coverage Result of STK--------
fileFolder = fullfile('D:\MATLAB2022a\workspace\MYTEST');%-----FileFolder----
dirOutput = dir(fullfile(fileFolder,'*.txt'));
fileNames={dirOutput.name}';
for num = 1:size(fileNames,1)
    file_name = fileNames{num,1};
    if contains(file_name,Cons_Walker_Paras_Str)
        if contains(file_name,'AvgCoverageFold')
            AvgCoverageFold = read_coverageFold_res_file(file_name);
        elseif contains(file_name,'MinCoverageFold')
            MinCoverageFold = read_coverageFold_res_file(file_name);
        elseif contains(file_name,'MaxCoverageFold')
            MaxCoverageFold = read_coverageFold_res_file(file_name);
        end
    end
end
STK_CoverageFolds_Res = [MinCoverageFold MaxCoverageFold(:,2) AvgCoverageFold(:,2)];
    %column-format:latitude + MinCoverageFold +  MaxCoverageFold +AvgCoverageFold

for k = 1:size(STK_Coverage_Folds_data,1)
    tmp_Latitude = STK_Coverage_Folds_data{k,2};

    [MIN_fold,MAX_fold,AVG_fold] = find_coverage_fold_based_on_latitude(tmp_Latitude,STK_CoverageFolds_Res);

    STK_Coverage_Folds_data{k,4} = MIN_fold;
    STK_Coverage_Folds_data{k,5} = MAX_fold;
    STK_Coverage_Folds_data{k,6} = AVG_fold; 
end
%% Step3-- Proposed Model Sim Result---Esatblishing the phase mapping and select the grid---
%---sat:orbit-id + sat_on_orbit_id
Sat_orb_AND_position = gene_sat_orbit_AND_position(Num_of_sats,Planes_num);
%sat_str = find_sat_string(sat_index,Sat_orb_AND_position);
Sats_Raan_Phase = sat_converts_raan_AND_phase(Num_of_sats,Planes_num,F_factor);
%convert range:[0,2*pi]--->[-pi,pi]
Sats_Raan_Phase = convert_range(Sats_Raan_Phase);
%% Step 4- Proposed Model Sim Result-Select the target latitude(arbitrary longitude) and calculate phase/access area
coverage_half_angle = calcluate_half_angle_of_coverage_region(Earth_radius_in_km,orbit_altitude_in_km,Min_elevation);
Alpha_D = coverage_half_angle;

Raan_change_rate = degToPiDeg(15)/3600;%unit:-w_earth:15deg/h---->> deg/sec
Phase_change_rate = 2 * pi / Orbital_period;
Start_time = 0;
Time_Step = 60;
ProposedModel_Facility_Sim_coverage_folds = cell(size(STK_Coverage_Folds_data,1),7);
%column-format: Facility_name + lat + lon +  
            %  (2D Map) Access_data + Min fold + Max Fold + Avg Fold
ProposedModel_Facility_Sim_coverage_folds(:,1:3) = STK_Coverage_Folds_data(:,1:3);
%Target_longitude = degToPiDeg(20);%longitude----arbitrary----
for k = 1:size(ProposedModel_Facility_Sim_coverage_folds,1)
    Target_latitude = degToPiDeg(ProposedModel_Facility_Sim_coverage_folds{k,2});
    Target_longitude = degToPiDeg(ProposedModel_Facility_Sim_coverage_folds{k,3});
    
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
    ProposedModel_Facility_Sim_coverage_folds{k,4} = Tmp_Facility_coverage_folds;
    ProposedModel_Facility_Sim_coverage_folds{k,5} = MIN_fold;
    ProposedModel_Facility_Sim_coverage_folds{k,6} = MAX_fold;
    ProposedModel_Facility_Sim_coverage_folds{k,7} = AVG_fold;
end
%% Step6 - Compare the Result -----STK Numerical AND Proposed Model
STK_CoverageFolds_Res = STK_Coverage_Folds_data;
Proposed_CoverageFolds_Res = ProposedModel_Facility_Sim_coverage_folds;
Min_Fold_column = 4;
Max_Fold_column = 5;
Avg_Fold_column = 6;

Min_Fold_Compared_Res = cell(size(STK_CoverageFolds_Res,1),6);
Max_Fold_Compared_Res = cell(size(STK_CoverageFolds_Res,1),6);
Avg_Fold_Compared_Res = cell(size(STK_CoverageFolds_Res,1),6);
%Column-format:FacilityNum + lat + lon + STK_Res + 2DMap_Res+ErrorRange(%)
Min_Fold_Compared_Res(:,1:3) = STK_CoverageFolds_Res(:,1:3);
Max_Fold_Compared_Res(:,1:3) = STK_CoverageFolds_Res(:,1:3);
Avg_Fold_Compared_Res(:,1:3) = STK_CoverageFolds_Res(:,1:3);

Min_Fold_Accuraacy = 0;
Max_Fold_Accuraacy = 0;
Avg_Fold_Accuraacy = 0;

for k = 1:size(STK_CoverageFolds_Res,1)
    %--Min Fold-----------
    Min_Fold_Compared_Res{k,4} = STK_CoverageFolds_Res{k,Min_Fold_column};
    Min_Fold_Compared_Res{k,5} = Proposed_CoverageFolds_Res{k,Min_Fold_column + 1};
    Min_Fold_Compared_Res{k,6} = Calaulate_Prediction_accuracy(Min_Fold_Compared_Res{k,4},Min_Fold_Compared_Res{k,5});
    Min_Fold_Accuraacy = Min_Fold_Accuraacy + Min_Fold_Compared_Res{k,6};
    %--Max Fold-----------
    Max_Fold_Compared_Res{k,4} = STK_CoverageFolds_Res{k,Max_Fold_column};
    Max_Fold_Compared_Res{k,5} = Proposed_CoverageFolds_Res{k,Max_Fold_column + 1};
    Max_Fold_Compared_Res{k,6} = Calaulate_Prediction_accuracy(Max_Fold_Compared_Res{k,4},Max_Fold_Compared_Res{k,5});  
    Max_Fold_Accuraacy = Max_Fold_Accuraacy + Max_Fold_Compared_Res{k,6};
    %-- Avg Fold-----------
    Avg_Fold_Compared_Res{k,4} = STK_CoverageFolds_Res{k,Avg_Fold_column};
    Avg_Fold_Compared_Res{k,5} = Proposed_CoverageFolds_Res{k,Avg_Fold_column + 1};
    Avg_Fold_Compared_Res{k,6} = Calaulate_Prediction_accuracy(Avg_Fold_Compared_Res{k,4},Avg_Fold_Compared_Res{k,5});  
    Avg_Fold_Accuraacy = Avg_Fold_Accuraacy + Avg_Fold_Compared_Res{k,6};
end
Res_File_Str = [MegaCons_String Cons_Walker_Paras_Str];

Compared_Res_STK_and_Proposed_for_figure = [Min_Fold_Compared_Res(:,2) Min_Fold_Compared_Res(:,4:5) Max_Fold_Compared_Res(:,4:5) Avg_Fold_Compared_Res(:,4:5)];
    %column-format:Latitude + 
    %Min_CoverageFold(STK + Proposed)+Max_CoverageFold(STK+Proposed)+Avg_CoverageFold(STK+Proposed )

%writecell(Compared_Res_STK_and_Proposed_for_figure,[Res_File_Str '_Min_Max_Avg_Folds' '.xlsx']);

fprintf('Proposed Model Prediction_Accuracy:\n');
fprintf('-----Min Fold: %d\n',Min_Fold_Accuraacy/k);
fprintf('-----Max Fold: %d\n',Max_Fold_Accuraacy/k);
fprintf('-----Avg Fold: %d\n',Avg_Fold_Accuraacy/k);




