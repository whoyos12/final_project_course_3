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

## Selección de características

Las características seleccionadas para esta base de datos provienen del
acelerómetro y giroscopio de señales crudas triaxiales tAcc-XYZ y
tGyro-XYZ.

  - Las señales del dominio del tiempo se capturaron a una velocidad
    constante de 50 Hz, el prefijo “t” indica tiempo.
  - Las señales se filtraban para eliminar el ruido.
  - La señal de aceleración se separó en señales de aceleración de
    cuerpo y gravedad:
      - tBodyAcc-XYZ
      - tGravityAcc-XYZ
  - Posteriormente, la aceleración lineal del cuerpo y la velocidad
    angular se derivaron en el tiempo para obtener señales de Jerk:
      - tBodyAccJerk-XYZ
      - tBodyGyroJerk-XYZ
  - A continuación, se calculó la magnitud de estas señales
    tridimensionales utilizando la forma euclidiana:
      - tBodyAccMag
      - tGravityAccMag
      - tBodyAccJerkMag
      - tBodyGyroMag
      - tBodyGyroJerkMag
  - Finalmente se aplicó una Transformada Rápida de Fourier (FFT) a
    algunas de estas señales, el prefijo ‘f’ indica señales en el
    dominio de frecuencia:
      - fBodyAcc-XYZ
      - fBodyAccJerk-XYZ
      - fBodyGyro-XYZ
      - fBodyAccJerkMag
      - fBodyGyroMag
      - fBodyGyroJerkMag

Esto nos deja con el siguiente conjunto de señales, el sufijo ‘-XYZ’
denota señales triaxiales en las direcciones X, Y y Z:

1.  tBodyAcc-XYZ
2.  tGravityAcc-XYZ
3.  tBodyAccJerk-XYZ
4.  tBodyGyro-XYZ
5.  tBodyGyroJerk-XYZ
6.  tBodyAccMag
7.  tGravityAccMag
8.  tBodyAccJerkMag
9.  tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

Las características se combinaron además con una variedad de variables
estimadas, como el valor medio, la desviación estándar, el valor máximo
y mínimo del conjunto, etc. Esto suma más de 550 indicadores diferentes
en total. El archivo ‘features.txt’ lista todas las variables.

## Transformaciones

Como se estipula en los requisitos, se realizaron las siguientes
transformaciones para mantener el resultado limpio y ordenado:

  - La formación y los conjuntos de pruebas se han fusionado para formar
    un único conjunto de datos.
  - Del amplio espectro de características sólo se consideraron las
    medidas en la media y la desviación estándar.
  - Se utilizaron apropiadamente los nombres y etiquetas descriptivas de
    las actividades para aumentar la legibilidad de los datos.
  - Se creó un conjunto de datos separado y ordenado como paso final de
    los esfuerzos de refinamiento de datos.

Además de las transformaciones obligatorias mencionadas anteriormente,
los nombres de las características han sido modificados para adherirse a
los estándares de nomenclatura del lenguaje R. Esto permitió un uso
elegante de las funciones de lenguaje R, como el filtrado de nombres de
columnas, y una mayor legibilidad del código. Considero que esta
transformación adicional es un cambio menor, que creo que no tiene un
impacto adverso en la información original.

Ejemplo de ajuste del nombre de la característica:

  - “tBodyAcc-mean()-X” se ha sustituido por “tBodyAcc\_mean\_X”.
  - “tBodyAcc-std()-Z” se ha sustituido por “tBodyAcc\_std\_Z”.
  - etc.

The transformations are achieved by the script called run\_analysis.R,
which:

1.  Carga todos los paquetes de R que no sean el base. Se cargan dplyr y
    reshape2.
2.  Define un número de funciones de ayuda para promover la
    reutilización del código.
3.  Descarga el conjunto de datos original y verifica su contenido.
4.  Carga conjuntos de datos de actividad y nombres de etiquetas.
5.  Carga los conjuntos de datos de entrenamiento y pruebas y mejora los
    nombres de las columnas con las etiquetas apropiadas.
6.  Fusiona los conjuntos de datos de entrenamiento y de pruebas
    utilizando el soporte de dplyr para el encadenamiento de métodos.
7.  Crea un conjunto de datos independiente y ordenado basado en la
    media y las desviaciones estándar.
8.  Saves the tidy dataset as “tidy\_data.txt”
