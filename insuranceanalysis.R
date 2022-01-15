#test 
#cargar paquete readxl
library(readr)
library(dplyr)
colnames(DB)
options(scipen = 999)
DB<-read.csv("/home/alejandro/R/insuranceanalysis2/insurance.csv", sep=",")
View(DB)

#-----HISTOGRAMA DE KM-----
DB2 <- select(DB, Kilometres)
View(DB2)
hist(DB2$Kilometres, main= "Histograma de Kilometros", 
     ylab="Observadores", xlab="Kilometros", col="blue")

#-----HISTOGRAMA POR MUNICIPIO-----
DB3<- select(DB, Zone)
View(DB3)
hist(DB3$Zone, main= "Histograma de municipios ", 
     ylab="Observadores", xlab="Municipio", col="blue")


#-----HISTOGRAMA DE BONO-----
DB4 <- select(DB, Bonus)
View(DB4)
hist(DB4$Bonus, main= "Histograma de bonos ", 
     ylab="Observadores", xlab="Bono", col="green")


#-----HISTOGRAMA DE Modelo-----
DB5 <- select(DB, Make)
View(DB5)
hist(DB5$Make, main= "Histograma de modelo ", 
     ylab="Observadores", xlab="Modelo", col="green")


#-----HISTOGRAMA DE Asegurados----
DB6 <- select(DB, Insured)
View(DB6)
hist(DB6$Insured, main= "Histograma de asegurados ", 
     ylab="Observadores", xlab="Asegurador", col="blue")


#-----HISTOGRAMA DE Modelo----
DB7 <- select(DB, Claims)
View(DB7)
hist(DB7$Claims, main= "Histograma de reclamaciones ", 
     ylab="Observadores", xlab="Reclamaciones", col="blue")


#-----HISTOGRAMA DE Pagos----
DB8 <- select(DB, Payment)
View(DB8)
hist(DB8$Payment, main= "Histograma de pagos ", 
     ylab="Observadores", xlab="Pagos", col="blue")



#-------------------------------PASO 2--------------------------------
#Crear categorías en función al número de reclamaciones, severidad,riesgo, etc.

#a) Kilometros
#a.1)Suma de asegurados por KM
install.packages("ggplot2")
library("ggplot2")
CK1 <- select(DB, Kilometres, Insured)
data <- data.frame(Kilometres = 1:5,
                   Insured = 1:100000)
ggplot(data = CK1, aes(x=Kilometres,   y=Insured))+
  geom_col()+labs(title="Suma de asegurados por kilometros",
                  x="Kilometros",
                  y="Suma de asegurados")


#a.2)Suma de reclamaciones por KM
CK2 <- select(DB, Kilometres, Claims)
data <- data.frame(Kilometres = 1:5,
                   Claims= 1:100000)
ggplot(data=CK2, aes(x=Kilometres, y=Claims))+
  geom_col()+labs(title = "Suma de reclamaciones por kilometro",
                  x="Kilometros",
                  y="Suma de reclamaciones")

#a.3)Suma de pagos por KM
CK3 <- select(DB, Kilometres, Payment)
data <- data.frame(Kilometres = 1:5,
                   Payment= 1:500000)
ggplot(data=CK3, aes(x=Kilometres, y=Payment))+
  geom_col()+labs(title = "Suma de pagos por kilometro",
                  x="Kilometros",
                  y="Suma de pagos")



#b.1) Suma de asegurados por Municipio
DK1 <- select(DB, Zone, Insured)
data<- data.frame(Zone= 1:100,
                  Insured=1:100000)
ggplot(data = DK1, aes(x=Zone,   y=Insured))+
  geom_col()+labs(title="Suma de asegurados por Municipio",
                  x="Municipios",
                  y="Suma de asegurados")


#b.2) Suma de reclamaciones por Municipio
DK2 <- select(DB, Zone, Claims)
data<- data.frame(Zone= 1:100,
                  Claims=1:100000)
ggplot(data = DK2, aes(x=Zone,   y=Claims))+
  geom_col()+labs(title="Suma de reclamaciones por Municipio",
                  x="Municipios",
                  y="Suma de reclamaciones")

#b.3) Suma de pagos por Municipio
DK3 <- select(DB, Zone, Payment)
data<- data.frame(Zone= 1:100,
                  Insured=1:100000)
ggplot(data = DK3, aes(x=Zone,   y=Payment))+
  geom_col()+labs(title="Suma de pagos por Municipio",
                  x="Municipios",
                  y="Suma de pagos")


#c.1) Suma de asegurados por modelo
EK1 <- select(DB, Make, Insured)
data<- data.frame(Make= 1:10,
                  Insured=1:100000)
ggplot(data = EK1, aes(x=Make,   y=Insured))+
  geom_col()+labs(title="Suma de asegurados por Modelo",
                  x="Modelo",
                  y="Suma de asegurados")


#c.2) Suma de reclamaciones por modelo
EK2 <- select(DB, Make, Claims)
data<- data.frame(Make= 1:10,
                  Claims=1:100000)
ggplot(data = EK2, aes(x=Make,   y=Claims))+
  geom_col()+labs(title="Suma de reclamaciones por Modelo",
                  x="Modelo",
                  y="Suma de reclamaciones")


#c.3) Suma de pagos por modelo
EK3 <- select(DB, Make, Payment)
data<- data.frame(Make= 1:10,
                  Claims=1:500000)
ggplot(data = EK3, aes(x=Make,   y=Payment))+
  geom_col()+labs(title="Suma de pagos por Modelo",
                  x="Modelo",
                  y="Suma de pagos")


#---------------------------------------------------------------------------
#-----------------------------PASO 3--------------------------------------
#----------------------------------------------------------------------------
#El valor total de pagos es una variable fundamental por lo que el
#Comité está interesados en saber si esta es una consecuencia (correlación) 
#de el número de reclamaciones y del número de años de la cartera

#a)Obtener matriz de correlación de para saber cuales 
#variable tienen mejor correlación con la variable pagos

#a)Obtener matriz de correlación de para saber 
#cuales variable tienen mejor correlación con la variable pagos
install.packages("corrplot")
install.packages("plotly")
source("http://www.sthda.com/upload/rquery_cormat.r")

mydata<-DB[, c(1,2,3,4,5,6,7)]
head(mydata)

#Computing the correlation matrix
rquery.cormat(mydata)

#Upper triangle of the correlation matrix
rquery.cormat(mydata, type="upper")



#b)Realizar un scatterplot de las variables con más correlación:
install.packages("devtools")
library(devtools)
install.packages("ggplot2")
library("ggplot2")
install.packages("easyGgplot2")


df <- DB[, c("Kilometres", "Zone", "Bonus", "Make", "Insured", "Claims", 
             "Payment")]
head(df)

ggplot(DB, aes(x=Claims, y=Payment))+geom_point()




#---------------------------------------------------------------------------
#-----------------------------PASO 4--------------------------------------
#----------------------------------------------------------------------------
#4 El Comité quiere encontrar las variables que impactan que el pago
#aumenta o disminuye. Por lo tanto es necesario realizar una regresión
#para encontrar qué variables impactan más a la variable pago (prueba p).

#a) La prueba P consiste en encontrar valores P > 0.05 al realizar una 
#regresión esto significa que se descarta la hipótesis nula es decir 
#relevancia hacia la variable pago.


install.packages("metan")
library(metan)

corrl<-corr_coef(DB)
plot(corrl)
print(corrl)
getwd()
sink("DB.txt")
print(corrl)
sink()


View(DB)


m(y~x)
summary(lm(y~x))



#PRUEBA con Claims
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Claims<-ads$Claims

plot(Claims, Payment)

plot(Claims, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs reclamaciones", xlab="Reclamaciones", ylab = "Pagos")

model<-lm(Claims~Payment)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)


#Prueba con Insured
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Insured<-ads$Insured


plot(Insured, Payment)
plot(Insured, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs asegurados", xlab="Asegurados", ylab = "Pagos")

model<-lm(Payment~Insured)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)


#Prueba con Make
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Make<-ads$Make

plot(Make, Payment)

plot(Make, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs reclamaciones", xlab="Modelo", ylab = "Pagos")

model<-lm(Make~Payment)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)


#PRUEBA CON BONOS
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Bonus<-ads$Bonus

plot(Bonus, Payment)

plot(Bonus, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs bonos", xlab="Bonos", ylab = "Pagos")

model<-lm(Payment~Bonus)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)


#PRUEBA con Zonas
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Zone<-ads$Zone

plot(Payment, Zone)

plot(Zone, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs zonas", xlab="Zona", ylab = "Pagos")

model<-lm(Payment~Zone)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)


#PRUEBA con Kilometros
ads<-read.csv("DB")

View(ads)
nrow(ads)
ncol(ads)

colnames(ads)
Payment<-ads$Payment
Kilometres<-ads$Kilometres

plot(Kilometres, Payment)

plot(Kilometres, Payment, pch=16, cex=1, col="blue",
     main="Pagos vs Kilometros", xlab="Kilometros", ylab = "Kilometros")

model<-lm(Payment~Kilometres)

summary(model)

attributes(model)

coefficients(model)

coef(model)

abline(model)



#b)Graficar las variables relevantes (4) usando otra vez una gráfica scatterplot
#y la línea de regresión que le corresponderia si si solo se tomara
#en cuenta pago vs variable

#1)Variable Reclamaciones
DB

plot(DB$Claims, DB$Payment, main = "Variable de reclamaciones",
     xlab="Reclamaciones", ylab="Pagos", col=c("royalblue", "grey"))
legend(x="topright", legend = c("trace 0", "trace 1"), fill = c("royalblue", "grey"))

abline(lm(Payment~Claims, data = DB), col="Red")



#2)Variable Asegurados
plot(DB$Insured, DB$Payment, main = "Variable de asegurados",
     xlab="Asegurados", ylab="Pagos")

abline(lm(Payment~Insured, data = DB), col="Red")



#3)Variable Modelo
plot(DB$Make, DB$Payment, main = "Variable de modelo",
     xlab="Modelo", ylab="Pagos")

abline(lm(Payment~Make, data = DB), col="Red")


#4)Variable Bonos
plot(DB$Bonus, DB$Payment, main = "Variable de bonos",
     xlab="Bonos", ylab="Pagos")

abline(lm(Payment~Bonus, data = DB), col="Red")


#5)Variable Zona
plot(DB$Zone, DB$Payment, main = "Variable de zona",
     xlab="Zona", ylab="Pagos")

abline(lm(Payment~Zone, data = DB), col="Red")


#6)Variable Kilometros
plot(DB$Kilometres, DB$Payment, main = "Variable de kilometros",
     xlab="Reclamaciones", ylab="Pagos")

abline(lm(Payment~Kilometres, data = DB), col="Red")


#NOTA: APARTE DE LAS VARIABLES RECLAMACIONES Y ASEGURADOS,
#NO SE CUALES OTRAS VARIABLES SON LAS QUE TIENEN MAS CORRELACION
#---------------------------------------------------------------------------
#-----------------------------PASO 5--------------------------------------
#----------------------------------------------------------------------------
#Finalmente el Comité quiere decidir si se deberían cobrar tarifas
#especiales dependiendo de factores como ubicación, cantidad asegurada,
#kilómetros, bonos etc. por lo tanto necesitamos saber el costo de
#asegurar un determinado riesgo por año.

#Para eso deberán calcular sum(pagos)/suma(asegurados)=costo del riesgo.
#por cada una de las siguientes categorias:

#a)Por municipio




#PRUEBA DE SUMA
colSums(DB)

aggregate(x=DB$Zone,
          by=list(DB$Payment),
          FUN=sum)


colnames(DB)

costoriesgo<-sum(Payment)/sum(Insured)












