% Titles for the figures plotted in RE101results.m
% Case numeration follows the same sequence as the files in 'data' at CE102main.m
function RE101titleNames(numberOfFiles)
switch (numberOfFiles)
 case 1
   title('RE101 - Magnetic Field Density of NPT30 Thruster: Ambient');% 
 case 2
   title('RE101 - Magnetic Field Density of NPT30 Thruster: +Y (Balcony)');% 
 case 3
   title('RE101 - Magnetic Field Density of NPT30 Thruster: -Y (Front)');% 
 case 4
   title('RE101 - Magnetic Field Density of NPT30 Thruster: +X (Roof)'); %
 case 5
   title('RE101 - Magnetic Field Density of NPT30 Thruster: -Z'); %
 case 6
   title('RE101 - Magnetic Field Density of NPT30 Thruster: +Z Thruster');
 case 7
   title('RE101 - Magnetic Field Density of NPT30 Thruster: -X Floor');
endswitch
endfunction