# seance_2_analyse_univariee.r
# Script asocié à la première partie de la séance 2 du cours d'intro à R
# Pierre-Olivier Goffard pierre-olivier.goffard@univ-lyon1.fr 
# 23/01/2021

setwd("C:/Users/pierr/OneDrive/Bureau/seance_2_R")

# Packages----
library(ggplot2)
library(insuranceData)

# Données AutoClaims----
data("AutoClaims")
head(AutoClaims)
summary(AutoClaims)

# Etude d'une variable quantitative ----
# Histogramme basique
ggplot(data = AutoClaims) + aes(x = PAID) + geom_histogram()
# Histogramme avec des proportions
ggplot(data = AutoClaims, aes(x = PAID)) + 
  geom_histogram(aes(y = ..density..), 
                 breaks = seq(0, max(AutoClaims$PAID), 200))  
# Boxplot
ggplot(data = AutoClaims, aes(y = PAID)) + geom_boxplot()

# Histogram custom
library(gridExtra)
(h <- ggplot(data = AutoClaims, aes(x = PAID)) + 
  geom_histogram(aes(y = ..density..), 
                 breaks = seq(0, max(AutoClaims$PAID), 200), fill = "blue") +
    labs(x = "Montant des sinistres",
         y = "Proportion",
         title = "Histogramme des \n montants de sinistres") 
     +
  theme(axis.text = element_text(size = 10),
        plot.title = element_text(size = 14, hjust = 1 / 2)) +
  scale_x_continuous(breaks = c(0,30000, 60000))
)

(b <- ggplot(data = AutoClaims, aes(y = PAID)) + geom_boxplot(fill = "red") +
    labs(y = "Montant des sinistres",
         x = "",
         title = "Boîte à moustache \n des montants de sinistres") + 
    theme(axis.text = element_text(size = 10),
          plot.title = element_text(size = 14, hjust = 1 / 2),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank() 
          ) +
    geom_hline(aes(yintercept = mean(PAID)), color = "blue", linetype = "dashed")
  ) 

h_b <- grid.arrange(h, b, nrow = 1)

ggsave(h_b, filename = "hist_boxplot.pdf")

# Graphique pour variable qualitative ----
# Importation de ozone.csv
ozone <- read.csv2("ozone (1).csv")
head(ozone)
summary(ozone)
ozone$vent <- as.factor(ozone$vent)
table(ozone$vent)
# Diagramme en barre pour la variable vent 
ggplot(data = ozone, aes(x = vent)) + geom_bar(fill = "green")
# Diagramme en barre custom qui indique des proportions plutôt que des effectif
# et qui colorie les barres différemment suivant les modalités
library(scales)
ggplot(data = ozone) + 
  geom_bar(aes(x = vent, fill = vent, y = ..count.. / sum(..count..))) +
  scale_y_continuous(labels = percent) +
  labs(y = "Pourcentage")

# Jouons avec le système de coordonnées pour obtenir un diagramme en 
# bar horizontal
ggplot(data = ozone) + 
  geom_bar(aes(x = vent, fill = vent, y = ..count.. / sum(..count..))) +
  scale_y_continuous(labels = percent) +
  labs(y = "Pourcentage") + coord_flip()

# Jouons avec le système de coordonnées pour obtenir un diagramme en secteur²²²²²²
ggplot(data = ozone) + 
  geom_bar(aes(x = 1, fill = vent, y = ..count.. / sum(..count..))) +
  scale_y_continuous(labels = percent,
breaks = round(as.numeric(cumsum(rev(table(ozone$vent)/length(ozone$vent)))),digit = 2) 
) + labs(y = "Pourcentage") + coord_polar(theta = "y")  
