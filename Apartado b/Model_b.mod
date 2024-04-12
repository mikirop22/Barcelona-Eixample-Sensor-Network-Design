set INTERSECCIONS;
set PATHS;
set FIXED;
set Path_intersections within {PATHS cross INTERSECCIONS};
set Inter_veines within {INTERSECCIONS cross INTERSECCIONS};

param max_sensors;
param path_flow{PATHS};

var sensor_path{PATHS} binary;
var intersection_wth_sensor{INTERSECCIONS} binary;

# Funci�n objetivo
maximize total:
    sum {i in PATHS} sensor_path[i] * path_flow[i];

# Restricciones
subject to fixed_sensor {i in FIXED}:
    intersection_wth_sensor[i] = 1;

subject to path_sensorized {i in PATHS}:
    (sum{j in INTERSECCIONS: (i, j) in Path_intersections} intersection_wth_sensor[j]) 
    	>= 2 * sensor_path[i];

subject to max_sensor_limit:
    (sum{j in INTERSECCIONS} intersection_wth_sensor[j]) <= max_sensors;

subject to no_sensor_neighbor {(i,j) in Inter_veines}:
    intersection_wth_sensor[i] <= 1 - intersection_wth_sensor[j];



