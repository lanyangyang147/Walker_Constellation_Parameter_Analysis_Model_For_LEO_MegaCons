
clear;clc;close all;
File_Name = 'Proposed_runtime_for_three_constellation.xlsx';
Range_Name = 'A2:E7';

Sheet_Name1 = 'StarLink_Phase1';
Sum_Sats_in_Starlink = 1584;
Starlink_Source_data = readcell(File_Name,'Sheet',Sheet_Name1,'Range',Range_Name);
Sheet_Name2 = 'Kuiper_Phase1';
Sum_Sats_in_Kuiper = 1156;
Kuiper_Source_data = readcell(File_Name,'Sheet',Sheet_Name2,'Range',Range_Name);
Sheet_Name3 = 'Telesat_Phase2';
Sum_Sats_in_Telesat = 1320;
Telesat_Source_data = readcell(File_Name,'Sheet',Sheet_Name3,'Range',Range_Name);

Starlink_data = preprocess_data(Starlink_Source_data);
Kuiper_data = preprocess_data(Kuiper_Source_data);
Telesat_data = preprocess_data(Telesat_Source_data);


INput_data = Telesat_data;
INput_Sum_sats = Sum_Sats_in_Telesat;

for k = 1:size(INput_data,1)
    if k == 1
        x = INput_data(k,2:end);
    else
        y = runtime_convert_to_hour(INput_data(k,2:end));
        %----curve fit-----
        [fit_value,fit_gof] = curve_fitted(x,y);
        
        predictable_runtime = calc_predicatable_runtime(INput_Sum_sats,fit_value);

        %-----print the result-----
        fprintf('----Calc_intervai = %ds----\n',INput_data(k,1));
        fprintf('CurveFitted Res:\n');
        fprintf('  gof.sse = %d----\n',fit_gof.sse);
        fprintf('  gof.rsquare = %d----\n',fit_gof.rsquare);
        fprintf('  gof.adjrsquare = %d----\n',fit_gof.adjrsquare);
        fprintf('  gof.rmse = %d----\n',fit_gof.rmse);
        fprintf('----Predictable Result: ----\n');
        fprintf('Sum_of_Sat:%d,Predictable_Runtime_in_hour:%dh\n',INput_Sum_sats,predictable_runtime);
    end
end


%[fit_value,fit_gof] = curve_fitted(X_data,Y_data);







