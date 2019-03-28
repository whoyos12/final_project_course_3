CodeBook
================

Este code book describe variables, datos y cualquier transformación o
trabajo realizado para limpiar los datos.

## Fuente de los datos

  - Sitio donde los datos fueron obtenidos:
    <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

  - Datos originales:
    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## Descripción del conjunto de datos

Los detalles del conjunto de datos pueden ser encontrados en
“README.txt” en el archivo ZIP que contiene los datos originales.

### División de los datos

El conjunto de datos obtenido ha sido dividido aleatoriamente en dos
conjuntos, donde el 70% de los voluntarios fueron seleccionados para
generar los datos de entrenamiento y el 30% los datos de prueba.

### Mediciones

Las siguientes señales del sensor fueron capturadas usando el
acelerómetro y giroscopio del smartphone: \* aceleración lineal de tres
ejes \* Velocidad angular triaxial a una velocidad constante de 50Hz

Las señales capturadas fueron pre-procesadas aplicando filtros de ruido
y luego muestreadas en ventanas deslizantes de ancho fijo de 2.56 seg. y
50% de superposición (128 lecturas/ventana). De cada ventana se obtuvo
un vector de características calculando variables del dominio del tiempo
y la frecuencia. Vea la sección ‘Selección de características’ a
continuación, también el archivo ‘features\_info.txt’ tiene detalles
completos.

### Unión de los conjuntos de datos

datos (10299 filas con 563 columnas) es creado usando la función
rbind().

### Extracción de características

La extracción de la media y desviación estandar se realizó usando la
funciones grep(), mean() y sd().

### Cambio de los nombres de las actividades

Este paso fue realizado para cambiarlo a etiquetas.

### Nombres de variables descriptivos

Esto se realizó usando las funciones gsub() y names(). Las variables
fueron cambiadas así:

t – timeDomain f – frequencyDomain Acc – Acelerometer Gyro – Gyroscope
Mag – Magnitude mean – Mean std – StandardDeviation

### Datos tidy

Fue realizado usando la función agregate() para obtener el conjunto
llamado datos\_tidy. Además se usó la función write.txt() para exportar
a un archivo .txt
