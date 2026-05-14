%--------Runtime for ISL visibility + distance----------------------------------
clear;clc;close all;
MegaCons_Type = 1;
%Mega-constellation Type:
% 1--StarLink_Phase1_1584_24_1; 
% 2--Kuiper_Phase1_1156_34_1;
% 3--Telesat_Phase2_1320_40_1;
%% Step0 basic parameters of constellation
if MegaCons_Type == 1
    Total_number_of_sats = 1584;
    Num_of_orbital_planes = 24;
    Phase_factor = 1;
    inclination = value2PIdeg(53);%unit:2*pi 
    altitude_in_km = 550;%unit:km
elseif MegaCons_Type == 2
    Total_number_of_sats = 1156;
    Num_of_orbital_planes = 34;
    Phase_factor = 1;
    inclination = value2PIdeg(51.9);%unit:2*pi 
    altitude_in_km = 630;%unit:km
elseif MegaCons_Type == 3
    Total_number_of_sats = 1320;
    Num_of_orbital_planes = 40;
    Phase_factor = 1;
    inclination = value2PIdeg(50.88);%unit:2*pi 
    altitude_in_km = 1325;%unit:km
end

Select_Satnum = [5;10;20;40;];
Time_Calc_interval = [5;10;20;30;60];% unit:secs

Proposed_model_Calc_Result = cell(size(Select_Satnum,1),3);
    %column-format:calculate interval + Sats_and_Calc_res1 + runtime1 +
    %Sats_and_Calc_res2 + runtime2

%---------Set up the reference sat------
%ref_sat_orbitalPlane = 0;%e.g, j = 0,1,...,Num_of_orbital_planes - 1;
%ref_sat_position_in_OrbitalPlane = 0;%e.g, k = 0,1,....,Num_of_sats_per_orbitalPlane-1

%----Calculate time ---greater than STK 24h-
Sum_of_Calculate_Time = 1 * 24 * 3600;%unit:s
Protect_clearance_altitude = 0;%unit:km -----------the same with STK-------------
Num_of_sats_per_orbitalPlane = Total_number_of_sats / Num_of_orbital_planes;
earth_radius_in_km = 6378;%unit:km
sat_radius_in_km = earth_radius_in_km + altitude_in_km;
orbital_period = calculate_OrbitalPeriod_for_satellite(earth_radius_in_km,altitude_in_km);%unit:s
%---- Calculate the maximum link distance -----
maximum_link_distance_in_km = Calculate_maximum_link_length(altitude_in_km,Protect_clearance_altitude,earth_radius_in_km);
%% Step1---------RunTime for the proposed anslysis model---------------------------
%---sat:orbit-id + sat_on_orbit_id
Sat_orb_AND_position = gene_sat_orbit_AND_position(Total_number_of_sats,Num_of_orbital_planes);
%Then---->>> select the reference satellite---------- j = 0;k = 0---------
%e.g, j = 0,1,...,Num_of_orbital_planes - 1;
%e.g, k = 0,1,....,Num_of_sats_per_orbitalPlane-1
%ref_sat_orbitalPlane = 0;
%ref_sat_position_in_OrbitalPlane = 0;

%---randon generate sat-----
Random_generated_Sats = randperm(Total_number_of_sats)';
%Time_step_in_secs = 5;

for row = 1:size(Time_Calc_interval,1)
    Time_step_in_secs = Time_Calc_interval(row,1);

    for m = 1:size(Select_Satnum,1)
        Sum_of_satNum = Select_Satnum(m,1);
        Sum_of_satName_AND_calcRes = cell(Sum_of_satNum,2);
            %column-format: name + calcRes
        Res_column = m * 2;    
        %-------select the sat------
        tic;%-----Piar1:tic----------
        for n = 1:Sum_of_satNum %Random_generated_Sats
            rand_sat_num = Random_generated_Sats(n,1);
            [ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,SatName] = determine_the_random_select_sat(rand_sat_num,Sat_orb_AND_position);
            
            Calc_Sat_to_other_sats_for_ISL;
    
            Sum_of_satName_AND_calcRes{n,1} = SatName;
            Sum_of_satName_AND_calcRes{n,2} = ISL_Access_AND_distance_data;
        end
        %---storage-----
        Proposed_model_Calc_Result{row,Res_column} = Sum_of_satName_AND_calcRes;
        Proposed_model_Calc_Result{row,Res_column + 1} = toc; %-----Piar1:toc----------
    end
    %---storage-----
    Proposed_model_Calc_Result{row,1} = Time_step_in_secs;
end

%% Step2---Find the random Sats and generate the corresponding STK data for the Sats---
%---------Extract the random Sat to generate ISL data------------- 
%-----Option 1: calculate directly --------
Select_SatNum_for_Calc_Accuracy = 100;
STK_Sats_for_ISL_data = Find_STK_Sats_for_ISL_data(Select_SatNum_for_Calc_Accuracy,Proposed_model_Calc_Result);

%STK_Sats_for_ISL_data = determine_STK_Sats_for_ISL_data(Proposed_model_Calc_Result);

Gene_Sats_STK_data_by_MATLAB_Interface;
    %RES:Select_ISLs_Res_in_STK
%-----Option 2: calculate firstly and then load the data --------
%load("Starlink_Phase1_Select_ISLs_STK_Res.mat");
%load("Kuiper_Phase1_Select_ISLs_STK_Res.mat");
load("Telesat_Phase2_Select_ISLs_STK_Res.mat");


%load('Runtime_for_Proposed_Model_in_StarLink_Phase1_1584_24_1.mat');
%load('Runtime_for_Proposed_Model_in_Kuiper_Phase1_1156_34_1.mat');
load('Runtime_for_Proposed_Model_in_Telesat_Phase2_1320_40_1.mat');

Select_SatNum_for_Calc_Accuracy = 100;

source_data = Select_ISLs_Res_in_STK;
%STK_Result = preprocess_STK_ISLs_data(source_data);
STK_Result = preprocess_ISLs_data_output_from_STK(source_data);

Column_start = 2;
Column_step = 2;
for row = 1:size(Proposed_model_Calc_Result,1)
    for column = Column_start:Column_step:size(Proposed_model_Calc_Result,2)
        TMP_Res = Proposed_model_Calc_Result{row,column};
        for m = 1:size(TMP_Res,1)
            Select_Sat_name = TMP_Res{m,1};
            Select_Sat_Res = TMP_Res{m,2};

            [Sats_for_accuracy,STK_Sats_for_accuracy] = determine_STK_AND_Proposed_res_for_accuracy(Select_Sat_name,Select_Sat_Res,STK_Result);
            %Sats_for_accuracy = determine_Sats_for_accuarcy(Sat_Calc_Res,Select_SatNum_for_Calc_Accuracy);
            %STK_Sats_for_accuracy = find_corresponding_STK_Sats_data(Sats_for_accuracy,STK_Result);
            
            Model_accuracy_STK_AND_Proposed = Merge_Proposed_AND_STK_Calc_Result(Sats_for_accuracy,STK_Sats_for_accuracy);
            [Model_accuracy_STK_AND_Proposed,Avg_Visibility_accuracy,Avg_Distance_accuracy] = Calc_accuracy_for_ISL(Model_accuracy_STK_AND_Proposed);
            %------storage----
            TMP_Res{m,3} =  Model_accuracy_STK_AND_Proposed;
            TMP_Res{m,4} =  Avg_Visibility_accuracy;
            TMP_Res{m,5} =  Avg_Distance_accuracy;
            fprintf('row = %d/%d, column = %d/%d,m = %d/%d is done!\n',row,size(Proposed_model_Calc_Result,1), ...
                column,size(Proposed_model_Calc_Result,2),m,size(TMP_Res,1));
        end%--m--
        Proposed_model_Calc_Result{row,column} = TMP_Res;
        %fprintf('row = %d, column = %d is done!\n',row,column);
    end%--column--
end%--row--

if 1
    %----------accuracy-----------
    Column = 8;
    
    for k = 1:size(Proposed_model_Calc_Result,1)
        TMP_Res = Proposed_model_Calc_Result{k,Column};
        Sum_visibility_accuracy = 0;
        Sum_distance_accuracy = 0;
        for m = 1:size(TMP_Res,1)
            Sum_visibility_accuracy = Sum_visibility_accuracy + TMP_Res{m,4};
            Sum_distance_accuracy = Sum_distance_accuracy + TMP_Res{m,5};
        end
        fprintf('row = %d, avg_v_accuracy = %d, avg_d_accuracy = %d\n',k,Sum_visibility_accuracy/size(TMP_Res,1),Sum_distance_accuracy/size(TMP_Res,1));
    
    end
end

%save('Starlink_Phase1_Select_ISLs_Accuracy_Res_20221129.mat','Proposed_model_Calc_Result','-v7.3');
%save('Kuiper_Phase1_Select_ISLs_Accuracy_Res_20221129.mat','Proposed_model_Calc_Result','-v7.3');
%save('Telesat_Phase2_Select_ISLs_Accuracy_Res_20221129.mat','Proposed_model_Calc_Result','-v7.3');
fprintf('Coding is done!!\n');

