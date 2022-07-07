list.files()

library(stringr)
library(dplyr)
library(base)

triang1=read.csv(here::here("data","data_track_1.csv"),header=T,dec=".",sep=",",encoding="UTF-8")

summary(triang1)

# Crée une nouvelle colonne qui prend en compte l'heure, l'indivudis et la date
mutate(triang1,GID=str_c(Individu, Date, Heure))
# Inclure cette nouvelle colonne dans "triang1"
triang1$GID<-str_c(triang1$Individu,triang1$Date,triang1$Heure)
# GID deviens passe de numérique à un facteur
triang1$GID<-as.factor(triang1$GID)
# GID en facteur interprétable numériquement
triang1$GID<-as.numeric(triang1$GID)

#afficher toute les ligne ou le GDI n'est présent qu'un fois
tmp<-table(triang1$GID)
Az1=names(tmp)[tmp==1]
#suppression des lignes avec un seul Az
triang1=subset(triang1,!triang1$GID%in%(Az1))
#suppression des ligne avec 2 Az ..........

## export des fichier depuis R
#triang1--- suppr de toute les ligne avec 1 seul GID

#dir.create("data_output")
#write.csv(triang1,file="triang1.csv",row.names = FALSE)
#install.packages("openxlsx")
#library(openxlsx)
#write.table(triang1,"triang1.csv", sep=",",fileEncoding = "UTF-8")

#triangHI --- dossier avec juste les HI gîte et HI chasse

triangHI=read.csv("data_track_1.csv",header=T,dec=".",sep=",",encoding="UTF-8")
mutate(triangHI,GID=str_c(Individu, Date, Heure))
triangHI$GID<-str_c(triangHI$Individu,triangHI$Date,triangHI$Heure)
triangHI$GID<-as.factor(triangHI$GID)
triangHI$GID<-as.numeric(triangHI$GID)
triangHI=subset(triangHI, Type.de.relevé..T.Hichasse.Higîte.=="HI gîte" |  Type.de.relevé..T.Hichasse.Higîte.=="HI chasse" )
summary(triangHI)
write.table(triangHI,"triangHI.csv", sep=",",fileEncoding = "UTF-8",col.names=NA)

#triang2 --- point 2 azimuth synchrone --- biangulation

triang2=read.csv("data_track_1.csv",header=T,dec=".",sep=",",encoding="UTF-8")
mutate(triang2,GID=str_c(Individu, Date, Heure))
triang2$GID<-str_c(triang2$Individu,triang2$Date,triang2$Heure)
triang2$GID<-as.factor(triang2$GID)
triang2$GID<-as.numeric(triang2$GID)
tmp2<-table(triang2$GID)
Az2=names(tmp2)[tmp2==2]
triang2=subset(triang2,triang2$GID%in%(Az2))
write.table(triang2,"triang2.csv", sep=",",fileEncoding = "UTF-8",col.names=NA)

#triang3 --- point avec 3 azimuth synchrone --- triangulation

triang3=read.csv("data_track_1.csv",header=T,dec=".",sep=",",encoding="UTF-8")
mutate(triang3,GID=str_c(Individu, Date, Heure))
triang3$GID<-str_c(triang3$Individu,triang3$Date,triang3$Heure)
triang3$GID<-as.factor(triang3$GID)
triang3$GID<-as.numeric(triang3$GID)
tmp3<-table(triang3$GID)
Az3=names(tmp3)[tmp3==3]
triang3=subset(triang3,triang3$GID%in%(Az3))
write.table(triang3,"triang3.csv", sep=",",fileEncoding = "UTF-8",col.names=NA)

#triang4 --- point avec 4 azimuth synchrone 

triang4=read.csv("data_track_1.csv",header=T,dec=".",sep=",",encoding="UTF-8")
mutate(triang4,GID=str_c(Individu, Date, Heure))
triang4$GID<-str_c(triang4$Individu,triang4$Date,triang4$Heure)
triang4$GID<-as.factor(triang4$GID)
triang4$GID<-as.numeric(triang4$GID)
tmp4<-table(triang4$GID)
Az4=names(tmp4)[tmp4==4]
triang4=subset(triang4,triang4$GID%in%(Az4))
write.table(triang4,"triang4.csv", sep=",",fileEncoding = "UTF-8",col.names=NA)


# Dossier individu 4

data_ind4=subset(triang1,Individu=="4")
mutate(data_ind4,GID=str_c(Date, Heure))
data_ind4$GID<-str_c(data_ind4$Individu,data_ind4$Date,data_ind4$Heure)
data_ind4$GID<-as.factor(data_ind4$GID)
data_ind4$GID<-as.numeric(data_ind4$GID)
tmp5<-table(data_ind4$GID) ### Ajouter colonne pour modifier le GID 1,2,3.... == 4.1, 4.2, 4.3.....
Az5=names(tmp5)[tmp5==1]
data_ind4=subset(data_ind4,!data_ind4$GID%in%(Az5))
write.table(data_ind4,"data_ind4.csv", sep=",",fileEncoding = "UTF-8",col.names = NA)



######## Création de colonne GID sur data_track_1 avec le GID qui correspond à l'indivudu #############

data_track_1 <- read.csv(here::here("data","data_track_1.csv"),header=T,dec=".",sep=",",encoding="UTF-8")

# Crée une nouvelle colonne qui prend en compte l'heure, l'indivudis et la date
dplyr::mutate(data_track_1,GID=stringr::str_c(Date, Heure, Individu))

# Inclure cette nouvelle colonne dans "triang1"
data_track_1$GID<-stringr::str_c(data_track_1$Individu,data_track_1$Date,data_track_1$Heure)

# GID deviens passe de numérique à un facteur
data_track_1$GID<-as.factor(data_track_1$GID)

# GID en facteur interprétable numériquement
data_track_1$GID<-as.numeric(data_track_1$GID)

tmp <-table(data_track_1$GID)


#Export du fichier data_track_1
#utils::write.table(data_track_1,"data_track_1.csv", sep=",",fileEncoding = "UTF-8", row.names = FALSE)

# Modification de la colonne GID en fonction des individus
ind4 <- subset(data_track_1,Individu=="4" )

#summary(ind4)
#ind4$GID <- base::replace(ind4, c(1 113), c(4.001, 4.113))

dplyr::mutate(data_track_1,GID=stringr::str_c(Date, Heure))

ind4$GID <-stringr::str_c(ind4$Individu,ind4$Date,ind4$Heure)

ind4$GID <- as.factor(ind4$GID)

ind4$GID <- c(4001: 4256)

ind4$GID<-as.numeric(ind4$GID, c(1, 3))

i