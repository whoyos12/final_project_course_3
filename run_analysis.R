#COURSE GETTING AND CLEANING DATA
#FINAL PROJECT

#Cargamos las librerías
library(data.table)

#Descargamos el conjunto de datos
url_archivo = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists('./UCI HAR Dataset.zip')){
  download.file(url_archivo, './UCI HAR Dataset.zip', mode = "wb")
  unzip('UCI HAR Dataset.zip', exdir = getwd())
}

#Leemos y convertimos los datos
caracteristicas <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
caracteristicas <- as.character(caracteristicas[,2])

data_train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data_train.activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data_train <-  data.frame(data_train.subject, data_train.activity, data_train.x)
names(data_train) <- c(c('subject', 'activity'), caracteristicas)

data_test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data_test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data_test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data_test <-  data.frame(data_test.subject, data_test.activity, data_test.x)
names(data_test) <- c(c('subject', 'activity'), caracteristicas)

#1. Unimos los conjuntos de datos
datos <- rbind(data_train, data_test)

#2. Realizamos la extracción de la media y desviación estandar de cada característica
media_desv <- grep('mean|std', caracteristicas)
subconjunto <- datos[,c(1, 2, media_desv + 2)]

#3. Nombramos las actividades en el conjunto de datos
etiquetas <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
etiquetas <- as.character(etiquetas[,2])
subconjunto$activity <- etiquetas[subconjunto$activity]

#4. Nombramos adecuadamente el conjunto de datos con nombres descriptivos
nuevo_nombre <- names(subconjunto)
nuevo_nombre <- gsub("[(][)]", "", nuevo_nombre)
nuevo_nombre <- gsub("^t", "TimeDomain_", nuevo_nombre)
nuevo_nombre <- gsub("^f", "FrequencyDomain_", nuevo_nombre)
nuevo_nombre <- gsub("Acc", "Accelerometer", nuevo_nombre)
nuevo_nombre <- gsub("Gyro", "Gyroscope", nuevo_nombre)
nuevo_nombre <- gsub("Mag", "Magnitude", nuevo_nombre)
nuevo_nombre <- gsub("-mean-", "_Mean_", nuevo_nombre)
nuevo_nombre <- gsub("-std-", "_StandardDeviation_", nuevo_nombre)
nuevo_nombre <- gsub("-", "_", nuevo_nombre)
names(subconjunto) <- nuevo_nombre

#5. Creamos el conjunto de datos tidy con el promedio y desviacion estandar
datos_tidy <- aggregate(subconjunto[,3:81], by = list(activity = subconjunto$activity, subject = subconjunto$subject),FUN = mean)
write.table(x = datos_tidy, file = "data_tidy.txt", row.names = FALSE)