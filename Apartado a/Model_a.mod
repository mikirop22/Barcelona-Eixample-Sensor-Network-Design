set INTERSECCIONS;
set PATHS;
set FIXED;

param max_sensors;
param path_flow{PATHS}>=0;
param path_intersections{PATHS, INTERSECCIONS} binary;

var sensor_path{PATHS} binary;

var intersection_wth_sensor {INTERSECCIONS} binary; 

# funcion objetivo
maximize total:
	sum {i in PATHS} sensor_path[i]*path_flow[i];

# Restricciones
subject to path_sensorized {i in PATHS}:
    sum{j in INTERSECCIONS} path_intersections[i, j] * intersection_wth_sensor[j] >= 2 * sensor_path[i];
    # Si sensor_path[i] == 0, la restricción no tiene efecto

subject to sensors:
	sum {j in INTERSECCIONS} intersection_wth_sensor[j] <= max_sensors; 
	# Número total de sensores no puede exceder max_sensors
	
subject to inters_fixed {j in FIXED}:
	intersection_wth_sensor[j] = 1;
	# Fija la presencia de sensores en intersecciones fijas