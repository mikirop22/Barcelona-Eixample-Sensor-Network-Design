# Obrir el arxiu de entrada
with open('input.txt', 'r') as file:
    lines = file.readlines()

# Crear un diccionari per a emmagatzemar les dades
data = {}
path_flow ={}
intersections = []
fixed = []


#######################################################
### Comencem a llegir les dades i a emmagatzemarles ###
#######################################################

i = 1

line = lines[i].split() # emmagatzemem els valors de la linia que estan separats per espais
for inter in line:
    intersections.append(inter)
    
i+=3 # saltem tres perque la seguent linia es buida, i la seguent d'aquesta es 'PATH'    
line = lines[i].split()
for path in line:
    data[path] = []

i += 3 # passem a tractar els FIXED    
line = lines[i].split()
for fix in line:
    fixed.append(fix)

i += 3 # tractem els PROHIBITED
line = lines[i].split()
for prohb in line:
    intersections.remove(prohb) # eliminem de les interseccions aquelles en les que no podem posar cap sensor


i += 3 # tractem els path_flow
while not 'path_intersections' in lines[i]:
    if len(lines[i]) > 1:
        parts = lines[i].split()
        path = parts[0]
        flow = parts[1]
        path_flow[path] = flow
    i += 1

i += 1      
# fem un bucle per apuntar les interseccions de cada camí 
while not 'intersection_neighborhood' in lines[i]:
    if len(lines[i]) > 1:
        parts = lines[i].split()
        path = parts[0]
        intersection = parts[1]
        data[path].append(intersection)
    i += 1

###############################################
### Escribim les dades en un nou arxiu .dat ###
###############################################

with open('output1.dat', 'w') as outfile:
    outfile.write("set INTERSECCIONS := ") 
    outfile.write(' '.join(map(str, intersections)))
    outfile.write(";\n")
    
    outfile.write("set PATHS := ")
    outfile.write(' '.join(map(str, data.keys())))
    outfile.write(";\n")
    
    outfile.write("set FIXED := ")
    outfile.write(' '.join(map(str, fixed)))
    outfile.write(";\n")
    
    outfile.write("\nparam max_sensors := 15;")
    
    outfile.write("\n")
    outfile.write("\nparam path_flow :=")
    
    for path, flow in path_flow.items():    
        #outfile.write("\t\t\t\t")
        outfile.write(f"\t\t\t\t\n{path} {flow}")
    outfile.write(";\n")
    
    outfile.write("\nparam path_intersections:\n")
    outfile.write("\t\t\t")
    # Escribir los nombres de las intersecciones como encabezado
    for intersection in intersections:
        outfile.write(intersection + " ")
    outfile.write(":=\n")
    
    # Escribir los datos de intersecciones para cada ruta
    for path, inters in data.items():
        outfile.write(f"\t{path.ljust(10)}")
        for intersection in intersections:
            outfile.write("1 " if intersection in inters else "0 ")
        outfile.write("\n")
    outfile.write(";")