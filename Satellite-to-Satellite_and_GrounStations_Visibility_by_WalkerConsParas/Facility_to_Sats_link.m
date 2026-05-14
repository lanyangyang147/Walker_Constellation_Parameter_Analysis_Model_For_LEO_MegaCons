%% Step1---------The proposed anslysis model-------------
[ECEF_Facility_x,ECEF_Facility_y,ECEF_Facility_z] = LL2WGS84(Facility_lat,Facility_lon,Facility_height);%unit:km
Facility_ECEF = [ECEF_Facility_x ECEF_Facility_y ECEF_Facility_z];

Time_start = 0;%unit:sec
Time_end = Num_of_Orbital_Period * ceil(orbital_period);%unit:sec

if Calculate_all_GSLs_flag
    Facility_To_Sats_Link_Access = Calculate_SGLs_Access(Sat_orb_AND_position,Time_step_in_seconds,Time_start,Time_end,orbital_period,Init_UTC_Time,Facility_ECEF, ...
        sat_radius_in_km,earth_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor,GS_Min_Elevation);
else
    %Calculate_Sats_Num + Sat_orb_AND_position
    Calculate_Sat_position = determine_calculated_sat_position(Calculate_Sats_Num,Sat_orb_AND_position);
    Facility_To_Sats_Link_Access = Calculate_SGLs_Access(Calculate_Sat_position,Time_step_in_seconds,Time_start,Time_end,orbital_period,Init_UTC_Time,Facility_ECEF, ...
        sat_radius_in_km,earth_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor,GS_Min_Elevation);
end
%% Step2--------- STK results---------------------------
load('Facilities_lat45_lon20_SGLs_in_Starlink_Phase1_1584_24_1_20221122.mat');
source_data = Facility_to_sat_link_Access;
if Calculate_all_GSLs_flag
    STK_result = preprocess_SGLs(source_data,orbital_period,Num_of_Orbital_Period);
else
    selected_data = find_select_SGLs_data(Calculate_Sats_Num,source_data);
    STK_result = preprocess_SGLs(selected_data,orbital_period,Num_of_Orbital_Period);
end
%% Step3---------the model accuracy between STK and the proposed mdoel---------------------------
Proposed_Calc_Result = Facility_To_Sats_Link_Access;
STK_Calc_Result = STK_result;

Model_accuracy_STK_AND_Proposed = cell(size(Proposed_Calc_Result,1),5);
%column:SGL Name + data(STK+proposed) + accuracy(access + elevation+ range)
for k = 1:size(Proposed_Calc_Result,1)
    tmp_Sat_name_str = Proposed_Calc_Result{k,1};
    tmp_proposed_res = Proposed_Calc_Result{k,5};
        %Column-format: time + Access + elevation_in_deg + range_in_km
    corresponding_row = find_STK_calculated_res(tmp_Sat_name_str,STK_Calc_Result);
    tmp_STK_res = STK_Calc_Result{corresponding_row,2};
        %Column-format: time+ access + elevation_in_deg + range_in_km
    Row_STK_AND_Proposed_Res = Matching_calculated_result_for_SGL(tmp_proposed_res,tmp_STK_res);
    %------storage-----
    Model_accuracy_STK_AND_Proposed{k,1} = STK_Calc_Result{corresponding_row,1};
    Model_accuracy_STK_AND_Proposed{k,2} = Row_STK_AND_Proposed_Res;
end
%% Step4---------calaulate the model accuarcy-------------------
Sum_Access_accuracy = 0;
Sum_elevation_accuracy = 0;
Sum_Range_accuracy = 0;
for k = 1:size(Model_accuracy_STK_AND_Proposed,1)
    tmp_Res = Model_accuracy_STK_AND_Proposed{k,2};
    [Avg_Access_accuracy,Avg_Elevation_accuracy,Avg_Distance_accuracy,SGL_PropoedModel_AND_STK_accuracy] = Calculate_model_accuracy_for_ISL(tmp_Res);
        %unit:%
    Sum_Access_accuracy = Sum_Access_accuracy + Avg_Access_accuracy;
    Sum_elevation_accuracy = Sum_elevation_accuracy + Avg_Elevation_accuracy;
    Sum_Range_accuracy = Sum_Range_accuracy + Avg_Distance_accuracy;
    %-----storage----
    Model_accuracy_STK_AND_Proposed{k,2} = SGL_PropoedModel_AND_STK_accuracy;
    Model_accuracy_STK_AND_Proposed{k,3} = Avg_Access_accuracy;
    Model_accuracy_STK_AND_Proposed{k,4} = Avg_Elevation_accuracy;
    Model_accuracy_STK_AND_Proposed{k,5} = Avg_Distance_accuracy;
end
fprintf('Average access accuracy is: %d \n ',Sum_Access_accuracy/size(Model_accuracy_STK_AND_Proposed,1));
fprintf('Average elevation accuracy is: %d \n ',Sum_elevation_accuracy/size(Model_accuracy_STK_AND_Proposed,1));
fprintf('Average range accuracy is: %d \n ',Sum_Range_accuracy/size(Model_accuracy_STK_AND_Proposed,1));

%% Step5----Extract the data in terms of access/elevation/distance for drawing figure ----------
Access_column = 2;
Elevation_column = 3;
Range_column = 4;

for k = 1:size(Model_accuracy_STK_AND_Proposed,1)
    Comparison_result = Model_accuracy_STK_AND_Proposed{k,2};
    if k == 1
        %Column: time + 1st-Proposed + 1st-STK + 2nd-Proposed + 2nd-STK....
        Access_calc_result = [Comparison_result(:,1) Comparison_result(:,Access_column) Comparison_result(:,Access_column+3)];
        Elevation_calc_result = [Comparison_result(:,1) Comparison_result(:,Elevation_column) Comparison_result(:,Elevation_column+3)];
        Range_calc_result = [Comparison_result(:,1) Comparison_result(:,Range_column) Comparison_result(:,Range_column+3)];
    else
        Access_calc_result = [Access_calc_result Comparison_result(:,Access_column) Comparison_result(:,Access_column+3)];
        Elevation_calc_result = [Elevation_calc_result Comparison_result(:,Elevation_column) Comparison_result(:,Elevation_column+3)];
        Range_calc_result = [Range_calc_result Comparison_result(:,Range_column) Comparison_result(:,Range_column+3)];
    end
end

% writematrix(Access_calc_result,'MyTest_Access_calc_result.xlsx');
% writematrix(Elevation_calc_result,'MyTest_Elevation_calc_result.xlsx');
% writematrix(Range_calc_result,'MyTest_Range_calc_result.xlsx');

%fprintf('Coding is done!!\n');
