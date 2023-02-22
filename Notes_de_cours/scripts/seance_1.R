# seance_1.r
# Script de la séance 1 du cours d'intro à R
# Pierre-O Goffard pierre-olivier.goffard@univ-lyon1.fr
# 20/01/2021

install.packages("actuar")
library("actuar")
pinvburr(3, shape1 = 1, shape2 = 1/2, scale = 1)
# Si on a pas utilisé library
actuar::pinvburr(3, shape1 = 1, shape2 = 1/2, scale = 1) 
# Les types d'objet R----
var_num <- 423.87
var_char <- "hello"
var_bool <- 4 != 8
var_complex <- complex(real = 4, imaginary = 9)
var_null <- NULL

typeof(var_bool)
is.character(var_char)

# Les valeurs manquantes----
var_na <- NA
is.na(var_na)
0/0
exp(100000)

# Les vecteurs ----
vec_num <- c(13, 2, 567, 1/3)
vec_char <- c("Pierre-O", "Karim", "Anne", "Alexis")

# Indexation des vecteur
vec_char[1]
vec_char[c(2,4)]
vec_char[1:3]
seq(1,10, by = 0.4)
vec_char[-1]
vec_char[-length(vec_char)]

# Application d'une fonction à chaque composante d'un vecteur
log(vec_num)
vec_char == "Karim"
vec_num[vec_num > 4]
vec_num[(vec_num > 4) | (vec_num == 1/3)]

# Fonction appliqué à un vecteur qui renvoit un scalaire
mean(vec_num)

# Opération sur les vecteurs
vec_1 <- 1:4
vec_2 <- 5:8
length(vec_1) == length(vec_2)
vec_1 + vec_2
vec_1 * vec_2
vec_1 %*% vec_2

# Les matrices ----
matrix(c(2,45, 67,43,7/8,9/2), ncol = 2, byrow = TRUE)
matrix(c(2,45, 67,43,7/8,9/2), nrow = 2, byrow = TRUE)
matrix(1, ncol = 5, nrow = 4)

mat <- matrix(seq(0.5, 4, 0.5), ncol = 4, byrow = FALSE)
# Indexation des matrices
mat[1, 2]
mat[,3]

# Application d'une fonction à chaque élement de la matrice
sin(mat)
dim(mat); nrow(mat); ncol(mat)

# Opération sur les matrices
A <- matrix(1:4, ncol = 2)
B <- matrix(5:8, ncol = 2)
A * B
A + B
A %*% B
A %*% t(B)

# Calcul des valeurs propres
eig <- eigen(A)
eig$values
det(A)

# Fonction apply
apply(A, MARGIN = 2, sum)

# Combinaison vecteurs lignes/colonnes
vec_1 <- 1:4
vec_2 <- 5:8
rbind(vec_1, vec_2)
cbind(vec_1, vec_2)

# Les data frames ----
vec_1 <- 1:5
vec_2 <- rep("a", 5)
df <- data.frame(nom_var1 = vec_1, nom_var2 = vec_2)
df$nom_var1
df[1,]
library(MASS)
data("Insurance")
summary(Insurance)

# les listes ----
vecteur <- 1:6
matrice <- diag(5)
ma_liste <- list(vecteur, matrice)
# Indexation des liste
ma_liste[[1]]
names(ma_liste) <- c("vecteur", "matrice")
names(ma_liste)
names(Insurance)

# fonction lapply
liste <- list(
  c("abcdef", 1),
  c("abcdef", 2),
  c("abcdef", 3)
)

help(substr)
substr("abcdef", start = 1, stop = 2)
substr(liste[[1]][1], start = as.numeric(liste[[1]][2]), 
       stop = as.numeric(liste[[1]][2]))
for (l in liste){
  print(substr(l[1], start = as.numeric(l[2]), 
               stop = as.numeric(l[2])))
}

res <- unlist(lapply(liste, function(l) substr(l[1], start = as.numeric(l[2]), 
                                 stop = as.numeric(l[2])) ))

# Gestion du répertoire de travail et importation/exportation----
path_wd <- "C:/Users/pierr/OneDrive/Bureau/seance_1_R"
setwd(path_wd)

# Importation d'un jeu de données
url_data <- paste0("https://www.data.gouv.fr/fr/datasets/r",
                   "/cb94f432-d3e0-44ba-a507-011b07e114c8")
download.file(url = url_data, destfile = "depistage.csv")
read.csv("depistage.csv", sep=";", stringsAsFactors=TRUE)
names(depistage)
head(depistage)

# Exportation d'un jeu de donnée
write.csv(df, file = "df.csv")

