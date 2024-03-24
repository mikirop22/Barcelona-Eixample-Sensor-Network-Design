# Abrir el archivo de entrada
with open('C:/Users/Usuario/OneDrive - Universitat Politècnica de Catalunya/Escritorio/UPC/4rt Quadrimestre/OPT/AMPL/Practica_Modelitzacio/input.txt', 'r') as file:
    lines = file.readlines()

# Crear un diccionario para almacenar los datos
data = {}
intersections = []

i = 1

while not 'param' in lines[i]:
    line = lines[i].split()
    for inter in line:
        intersections.append(inter)
    i += 1    

i += 1 # per saltar-nos el param

# Procesar cada línea del archivo
while i < len(lines):
    line = lines[i]
    parts = line.split()
    path = parts[0]
    intersection = parts[1]
    if path not in data:
        data[path] = []
    data[path].append(intersection)
    i += 1

# Escribir los datos en un nuevo archivo .dat
with open('C:/Users/Usuario/OneDrive - Universitat Politècnica de Catalunya/Escritorio/UPC/4rt Quadrimestre/OPT/AMPL/Practica_Modelitzacio/output.txt', 'w') as outfile:
    outfile.write("param path_intersections:\n")
    outfile.write("\t\t\t\t")
    
    # Escribir los nombres de las intersecciones como encabezado
    for intersection in intersections:
        outfile.write(intersection + " ")
    outfile.write(":=\n")
    
    # Escribir los datos de intersecciones para cada ruta
    for path, inters in data.items():
        outfile.write(f"\t{path.ljust(20)}")
        for index, intersection in enumerate(intersections):
            outfile.write("1 " if intersection in inters else "0 ")
        outfile.write("\n")
    outfile.write(";")
