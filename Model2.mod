set INTERSECCIONS;
set PATHS;
set FIXED;

param max_sensors;
param path_flow{PATHS} >= 0;
param path_intersections{PATHS, INTERSECCIONS} binary;
param inter_veines{INTERSECCIONS, INTERSECCIONS} binary;

var sensor_path{PATHS} binary;

var intersection_wth_sensor {INTERSECCIONS} binary; 

# funcion objetivo
maximize total:
    sum {i in PATHS} sensor_path[i] * path_flow[i];

# Restricciones
subject to path_sensorized {i in PATHS}:
    sum{j in INTERSECCIONS} path_intersections[i, j] * intersection_wth_sensor[j] 
    		>= 2 * sensor_path[i];

subject to sensors:
    sum {j in INTERSECCIONS} intersection_wth_sensor[j] <= max_sensors;

subject to inters_fixed {j in FIXED}:
    intersection_wth_sensor[j] = 1;

subject to interseccions_veines {i in INTERSECCIONS}:
    intersection_wth_sensor[i] + 
    	sum{j in INTERSECCIONS: inter_veines[i,j]} intersection_wth_sensor[j] <= 1;
