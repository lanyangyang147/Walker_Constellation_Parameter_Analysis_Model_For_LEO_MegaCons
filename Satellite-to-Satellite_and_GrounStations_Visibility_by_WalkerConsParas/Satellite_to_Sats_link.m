%% Step1---------The proposed anslysis model---------------------------
%---- Calculate the maximum link distance -----
maximum_link_distance_in_km = Calculate_maximum_link_length(altitude_in_km,Protect_clearance_altitude,earth_radius_in_km);

ISL_Access_AND_distance_data = determine_other_need_calculated_sats(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,Sat_orb_AND_position);
%Column-Format:ref_sat_str + des_sat_str + des_sat_orbitalPlane + des_sat_position_in_OrbitalPlane
              % + distance data(mathematical model)
if ~Calculate_all_ISLs_flag
    ISL_Access_AND_distance_data = determine_calculated_ISLs(Calculate_Sats_Num,ISL_Access_AND_distance_data);
end
for k = 1:size(ISL_Access_AND_distance_data,1)
    %---- Generate link distance (Mathematics) --------
    des_sat_orbitalPlane = ISL_Access_AND_distance_data{k,3};
    des_sat_position_in_OrbitalPlane = ISL_Access_AND_distance_data{k,4};
    Model_Init_distance_AND_elevation_curve = Calculate_link_distance(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane,ref_sat_orbitalPlane, ...
        ref_sat_position_in_OrbitalPlane,maximum_link_distance_in_km,sat_radius_in_km,inclination,Num_of_orbital_planes, ...
        Num_of_sats_per_orbitalPlane,Phase_factor,Num_of_Orbital_Period_for_ISL,orbital_period,Time_step_in_secs,Min_ISL_elevation,Max_ISL_elevation);
    
    Model_distance_curve = Filter_no_Accessed_link_distance(Model_Init_distance_AND_elevation_curve);
    if size(Model_distance_curve,1) ~= 1
        Access_AND_distance = process_middle_result(Model_distance_curve);
            %Column-format:time + Access + Disyance_in_km
    else
        Access_AND_distance = Model_distance_curve;
    end
    %---- storage --------
    ISL_Access_AND_distance_data{k,5} = Access_AND_distance;
end
%% Step2--------- STK results---------------------------

load('Starlink_p1_24_66_Selected_ISLs_for_accuracy.mat', 'StarlinkP1_selected_ISL_Access');
source_data = StarlinkP1_selected_ISL_Access;

if Calculate_all_ISLs_flag
    STK_result = preprocess_ISLs_data(source_data,orbital_period,Num_of_Orbital_Period_for_ISL);
else
    selected_data = find_select_SGLs_data(Calculate_Sats_Num,source_data);
    STK_result = preprocess_ISLs_data(selected_data,orbital_period,Num_of_Orbital_Period_for_ISL);
end
%% Step3---------the model accuracy between STK and the proposed mdoel---------------------------
Proposed_Calc_Result = ISL_Access_AND_distance_data;
STK_Calc_Result = STK_result;

Model_accuracy_STK_AND_Proposed = cell(size(Proposed_Calc_Result,1),5);
%column:ISL Name + data(STK+proposed) + accuracy(access + elevation + range)
for k = 1:size(Proposed_Calc_Result,1)
    tmp_Sat_name_str = Proposed_Calc_Result{k,2};
    tmp_proposed_res = Proposed_Calc_Result{k,5};
        %Column-format: time + Access+ range_in_km + elevation_in_deg 
    corresponding_row = find_STK_calculated_res(tmp_Sat_name_str,STK_Calc_Result);
    tmp_STK_res = STK_Calc_Result{corresponding_row,2};
        %Column-format: time+ access + elevation_in_deg + range_in_km
    Row_STK_AND_Proposed_Res = Matching_calculated_result(tmp_proposed_res,tmp_STK_res);
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
    [Avg_Access_accuracy,Avg_Elevation_accuracy,Avg_Distance_accuracy,ISL_PropoedModel_AND_STK_accuracy] = Calculate_model_accuracy_for_ISL(tmp_Res);
        %unit:%
    Sum_Access_accuracy = Sum_Access_accuracy + Avg_Access_accuracy;
    Sum_elevation_accuracy = Sum_elevation_accuracy + Avg_Elevation_accuracy;
    Sum_Range_accuracy = Sum_Range_accuracy + Avg_Distance_accuracy;
    %-----storage----
    Model_accuracy_STK_AND_Proposed{k,2} = ISL_PropoedModel_AND_STK_accuracy;
    Model_accuracy_STK_AND_Proposed{k,3} = Avg_Access_accuracy;
    Model_accuracy_STK_AND_Proposed{k,4} = Avg_Elevation_accuracy;
    Model_accuracy_STK_AND_Proposed{k,5} = Avg_Distance_accuracy;
end


fprintf('Average access accuracy is: %d \n ',Sum_Access_accuracy/size(Model_accuracy_STK_AND_Proposed,1));
fprintf('Average elevation accuracy is: %d \n ',Sum_elevation_accuracy/size(Model_accuracy_STK_AND_Proposed,1));
fprintf('Average range accuracy is: %d \n ',Sum_Range_accuracy/size(Model_accuracy_STK_AND_Proposed,1));


%% Step5----Extract the data in terms of access/elevation/distance for drawing figure ----------
Proposed_Access_column = 2;
Proposed_elevation_column = 3;
Proposed_distance_column = 4;
Duration_column = 3;

for k = 1:size(Model_accuracy_STK_AND_Proposed,1)
    tmp_result = Model_accuracy_STK_AND_Proposed{k,2};
    %-----for visibility-----
    Comparison_result = modify_access_value(tmp_result,k,Proposed_Access_column,Duration_column);
    if k == 1
        %Column: time + 1st-Proposed + 1st-STK + 2nd-Proposed + 2nd-STK....
        Access_calc_result = [Comparison_result(:,1) Comparison_result(:,Proposed_Access_column) Comparison_result(:,Proposed_Access_column+Duration_column)];
        Elevation_calc_result = [Comparison_result(:,1) Comparison_result(:,Proposed_elevation_column) Comparison_result(:,Proposed_elevation_column+Duration_column)];     
        Range_calc_result = [Comparison_result(:,1) Comparison_result(:,Proposed_distance_column) Comparison_result(:,Proposed_distance_column+Duration_column)];
    else
        Access_calc_result = [Access_calc_result Comparison_result(:,Proposed_Access_column) Comparison_result(:,Proposed_Access_column+Duration_column)];
        Elevation_calc_result = [Elevation_calc_result Comparison_result(:,Proposed_elevation_column) Comparison_result(:,Proposed_elevation_column+Duration_column)];
        Range_calc_result = [Range_calc_result Comparison_result(:,Proposed_distance_column) Comparison_result(:,Proposed_distance_column+Duration_column)];
    end
end

% writematrix(Access_calc_result,'Starlink_P1_Access_accuracy_for_Proposed_and_STK.xlsx');
% writematrix(Elevation_calc_result,'Starlink_P1_elevation_accuracy_for_Proposed_and_STK.xlsx');
% writematrix(Range_calc_result,'Starlink_P1_range_accuracy_for_Proposed_and_STK.xlsx');

fprintf('Coding is done!!\n');





