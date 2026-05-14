% 
stkInit;
% port id 5001
remMachine = stkDefaultHost;
% conid
conid = stkOpen(remMachine);
objNames = stkObjNames; 
%% Step1. Basic parameters
start_sat_num = 3;
end_sat_num = size(objNames,1);
sum_of_sats = (end_sat_num - start_sat_num + 1);
sum_of_column = 9;
%Column-format: name+num+start+end+duration +time + azimth +elevation +range

Select_ISLs_for_Sats_row = Determine_ISLs_for_STK_Sats(STK_Sats_for_ISL_data,start_sat_num,objNames);

Select_ISLs_Res_in_STK = cell(size(Select_ISLs_for_Sats_row,1),2);
    %column-format:sat + STK_Access_Res
Select_ISLs_Res_in_STK(:,1) = Select_ISLs_for_Sats_row(:,1);

%% Step2. Perform simulations
for k = 1:size(Select_ISLs_for_Sats_row,1)
    TMP_ISLs = Select_ISLs_for_Sats_row{k,2};
    MegaCons_ISL_Access = cell(size(TMP_ISLs,1),sum_of_column);

    for m = 1:size(TMP_ISLs,1)
        source_sat = TMP_ISLs(m,1);
        des_sat = TMP_ISLs(m,2);
        flag = judge_whether_is_inter_ISL(source_sat,des_sat,objNames);
         % flag = 1 >>> inter link 
         if flag
             [secData,secNames]=stkAccReport(char(objNames(int32(source_sat))),char(objNames(int32(des_sat))),'Access');
             if size(secData{1,1},2) == 0
                % no Access
             else
                %Access 
                MegaCons_ISL_Access{m,1}=secNames{1,1};   %name     
                MegaCons_ISL_Access{m,2}=secData{1,1}(1).data;%num
                MegaCons_ISL_Access{m,3}=secData{1,1}(2).data;%start
                MegaCons_ISL_Access{m,4}=secData{1,1}(3).data;%end
                MegaCons_ISL_Access{m,5}=secData{1,1}(4).data;%duration
                %AER
                [secData1,~]=stkAccReport(char(objNames(int32(source_sat))),char(objNames(int32(des_sat))),'AER',0,86400,1);     
                MegaCons_ISL_Access{m,6}=secData1{1,1}(1).data;%time
                MegaCons_ISL_Access{m,7}=secData1{1,1}(2).data;%azimth
                MegaCons_ISL_Access{m,8}=secData1{1,1}(3).data;%elevation
                MegaCons_ISL_Access{m,9}=secData1{1,1}(4).data;%range
                fprintf('Sat_Row = %d,ISL_count = %d!\n',k,m); 
             end
         end
    end%--m--end--
    %--------------
    Select_ISLs_Res_in_STK{k,2} = MegaCons_ISL_Access;
end
save('Starlink_Phase1_Select_ISLs_STK_Res.mat','Select_ISLs_Res_in_STK','-v7.3');
%% close stk interface and conid
stkClose(conid);stkClose;
