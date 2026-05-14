function [output_Facility_ECI_x,output_Facility_ECI_y,output_Facility_ECI_z] = Convert_Facility_coordinate(UTC_Time,Facility_ECEF)
%CONVERT_FACILITY_COORDINATE 此处显示有关此函数的摘要
%   此处显示详细说明

Facility_ECI = ecef2eci(UTC_Time,Facility_ECEF);

Facility_ECI_x = Facility_ECI(1,1);
Facility_ECI_y = Facility_ECI(2,1);
Facility_ECI_z = Facility_ECI(3,1);

%output
output_Facility_ECI_x = Facility_ECI_x;
output_Facility_ECI_y = Facility_ECI_y;
output_Facility_ECI_z = Facility_ECI_z;
end

