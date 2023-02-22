# seance_2_analyse_bivariee.r
# Graphiques pour étudier le lien entre deux variables
# Pierre-O Goffard pierre-olivier.goffard@univ-lyon1.fr
# 26/01/2021

# Lien entre deux variables quantitatives ----
# Graphique de la fonction sinus
x_grid <- seq(- 6 * pi, 6 * pi, 0.01)
y_grid <- sin(x_grid)
df_sinus <- data.frame(x = x_grid, y = y_grid)
ggplot(data = df_sinus, aes(x = x, y = y)) + geom_line(color = "red")

# Importation de ozone.csv
setwd("C:/Users/pierr/OneDrive/Bureau/seance_2_R")
ozone <- read.csv2("ozone (1).csv", 
          stringsAsFactors=TRUE)

# Etude du lien temperature et hauteur du pic d'ozone
ggplot(data = ozone, aes(x = T12, y = maxO3)) + 
  geom_point(shape = 23, fill = "red", size = 3, color = "blue") + 
  geom_smooth(formula = y~x, method = "lm")

# Coefficient de corélation linéaire
cor(ozone$T12, ozone$maxO3)

# Format Date en R
today <- "26/01/2021"
typeof(today)
typeof(Sys.Date())
as.numeric(Sys.Date())
# Conversion d'une chaine de caractère en date avec as.Date
# http://www.duclert.org/r-vecteurs-operations/dates-et-temps-R.php
today_date <- as.Date(today, format = "%d/%m/%Y")
# Changer le format avce la fonction format
format(today_date, format = "%A, %d %B %Y")

# Graphique d'une serie temporelle
data(EuStockMarkets)
time(EuStockMarkets)
library(lubridate)
lubridate::date_decimal(as.numeric(time(EuStockMarkets)))
df_EuStockMarkets <- as.data.frame(EuStockMarkets)
df_EuStockMarkets$date <- lubridate::date_decimal(as.numeric(time(EuStockMarkets)))
ggplot(data = df_EuStockMarkets, aes(x = date)) + 
  geom_line(aes(y = CAC), color = "blue") +
  geom_line(aes(y = DAX), color = "red")

# Lien entre deux variables qualitatives ---
library(questionr)
data(hdv2003)
summary(hdv2003)
# Lien entre les variable nivetud et sport
# Tableau de contingence
tab_contingence <- table(hdv2003$nivetud, hdv2003$sport)
lprop(tab_contingence)
cprop(tab_contingence)

# Diagramme en barre pour la variable nivetud
g <- ggplot(data = hdv2003, aes(x = nivetud)) + geom_bar()
# Axe des x non lisible
# Solution 1: Coord_flip
g + coord_flip()
# Solution 2: Changer l'aspect du texte sur l'axe des x
g + theme(axis.text.x = element_text(size = 9, angle = 45, vjust = 1/2))
# Solution 3: Manipulation des modalités de la variable nivetud
levels(hdv2003$nivetud) <- c(rep("primaire", 3),
                             rep("secondaire", 2), 
                             rep("technique", 2), 
                             "supérieur")
# Suppression des valeurs manquantes
hdv2003_V1 <- hdv2003[!is.na(hdv2003$nivetud), ]
ggplot(data = hdv2003_V1, aes(x = nivetud)) + geom_bar()

# Diagramme en barre pour étudier le lien nivetud et sport
# Solution 1: On splitt les barres et on les empile
ggplot(data = hdv2003_V1, aes(x = nivetud, fill = sport)) + 
  geom_bar(position = "stack")
# Solution 1: On splitt les barres et on les met cote à cote
ggplot(data = hdv2003_V1, aes(x = nivetud, fill = sport)) + 
  geom_bar(position = "dodge")

# Lien entre variable qualitative et quantitative ----
library(insuranceData)
data(AutoBi)
summary(AutoBi)
# Histogramme pour la variable Loss
ggplot(data = AutoBi, aes(x = LOSS)) + geom_histogram(breaks = seq(0,50, 0.25))
# Création de deux histogrammes
# Solution 1: sur un même graphique
ggplot(data = AutoBi, aes(x = LOSS, fill = as.factor(ATTORNEY))) + 
  geom_histogram(breaks = seq(0,50, 0.25), alpha = 0.4)
# Solution 2: deux histogramme dans deux fenêtres graphique cote à cote
ggplot(data = AutoBi, aes(x = LOSS)) + 
  geom_histogram(breaks = seq(0,50, 0.25)) + 
    facet_grid(ATTORNEY~.)
# Boxplot pour la variable loss suivant les valeurs de la variable attorney
AutoBi_small <- AutoBi[AutoBi$LOSS < 50, ]
ggplot(data = AutoBi_small, aes(y = LOSS, x = as.factor(ATTORNEY))) + 
  geom_boxplot()

# Lien entre deux variables quantitatives suivant les modalités d'une variable qualitative ----
ggplot(data = ozone, aes(x = T12, y = maxO3, color = vent)) + 
  geom_point() +
  geom_smooth(method = "lm", se = F)

# Courbes des indices boursiers avec une légende
df_EuStockMarkets_V1 <- data.frame(
  date = rep(df_EuStockMarkets$date, 2), 
  valeur_indice = c(df_EuStockMarkets$CAC,df_EuStockMarkets$DAX),
  nom_indice = c(rep("CAC",nrow(df_EuStockMarkets)), 
                 rep("DAX",nrow(df_EuStockMarkets)))
    )
library(ggthemes)
ggplot(data = df_EuStockMarkets_V1, aes(x = date, y = valeur_indice, color = nom_indice)) +
  geom_line() + scale_color_manual(values = c("red", "blue")) + theme_economist()

       