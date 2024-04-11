set INTERSECCIONS;
set PATHS;
set FIXED;
set PROHIBITED;

# Define subconjuntos de intersecciones para cada camino
set path_intersections{i in PATHS} within {INTERSECCIONS};
set inter_veines{j in INTERSECCIONS} within {INTERSECCIONS};

param max_sensors;
param path_flow{PATHS}>=0;

var sensor_path{PATHS} binary;
var intersection_wth_sensor {INTERSECCIONS} binary; 

# función objetivo
maximize total:
    sum {i in PATHS} sensor_path[i]*path_flow[i];

# Restricciones
subject to path_sensorized_condition {i in PATHS}:
    sum{j in path_intersections[i]} intersection_wth_sensor[j] >= 2 * sensor_path[i];
    
subject to sensors:
    sum {j in INTERSECCIONS} intersection_wth_sensor[j] <= max_sensors; 

subject to no_sensor_neighbor {i in INTERSECCIONS}:
    intersection_wth_sensor[i] <= 1 - sum{j in inter_veines[i]} intersection_wth_sensor[j];

subject to inters_fixed {j in FIXED}:
    intersection_wth_sensor[j] = 1;

subject to inters_prohibited {j in PROHIBITED}:
	intersection_wth_sensor[j] = 0;
	
#subject to interseccions_veines {i in INTERSECCIONS}:
   # intersection_wth_sensor[i] + 
    #	sum{j in INTERSECCIONS: inter_veines[i,j]} intersection_wth_sensor[j] <= 1;
#subject to no_sensor_neighbor {i in INTERSECCIONS}:
    #intersection_wth_sensor[i] > sum{j in inter_veines[i]} intersection_wth_sensor[j];
    #sum{j in inter_veines[i]} intersection_wth_sensor[j] = 1;


    