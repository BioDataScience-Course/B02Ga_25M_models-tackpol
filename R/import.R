# Importation et remaniement des données
birds<-read$csv("https://pasta.lternet.edu/package/data/eml/edi/1130/1/789d490f183f045e3b2ae9919eb6008e", cache_file="data/cache/birds.csv")

# Etape 1 : Importation des données brutes --------------------------------

thraupidae<-sfilter(birds, family_name == "Thraupidae")

# Etape 2 : Description brève des données ---------------------------------



# Etape 3 : Nettoyage des données  ----------------------------------------

thraupidae$length[thraupidae$length == "-"] <- NA
thraupidae$rwing[thraupidae$rwing == "-"] <- NA
thraupidae$rtarsu[thraupidae$rtarsu == "-"] <- NA
thraupidae$blenght[thraupidae$blenght == "-"] <- NA
thraupidae$bheight[thraupidae$bheight == "-"] <- NA
thraupidae$bwidth[thraupidae$bwidth == "-"] <- NA
thraupidae$occiput[thraupidae$occiput == "-"] <- NA
thraupidae$tail[thraupidae$tail == "-"] <- NA
thraupidae$bmass[thraupidae$bmass == "-"] <- NA

thraupidae$sex[thraupidae$sex == "I"] <- NA
thraupidae$age[thraupidae$age == "I"] <- NA

thraupidae[, 6:14] <- lapply(thraupidae[, 6:14], as.numeric)

thraupidae[, c(1:2, 4:5)] <- lapply(thraupidae[, c(1:2, 4:5)], as.factor)

levels(thraupidae$sex)[levels(thraupidae$sex) == "F"] <- "Femelle"
levels(thraupidae$sex)[levels(thraupidae$sex) == "M"] <- "Mâle"
levels(thraupidae$age)[levels(thraupidae$age) == "A"] <- "Adulte"
levels(thraupidae$age)[levels(thraupidae$age) == "J"] <- "Juvénile"


# Etape 4 : Ajout des labels et des unités --------------------------------
thraupidae<-labelise(thraupidae, label=list(
  taxon_name="Espèce",
  family_name="Famille",
  date="Date de capture",
  sex="Sexe",
  age="Age",
  length="Longueur",
  rwing="Longueur de l'aile",
  rtarsu="Longueur du tarse",
  blenght="Longueur du bec",
  bheight="Hauteur du bec",
  bwidth="Largeur du bec",
  occiput="Longueur de l'os occipital",
  tail="Longueur de la queue",
  bmass="Masse"),
   units= list(
  taxon_name=NA,
  family_name=NA,
  date=NA,
  sex=NA,
  age=NA,
  length="cm",
  rwing="cm",
  rtarsu="cm",
  blenght="cm",
  bheight="cm",
  bwidth="cm",
  occiput="cm",
  tail="cm",
  bmass="g"
))


# Etape 5 : Sauvegarde locale des données retravaillées -------------------
write$rds(thraupidae, "data/thraupidae.rds")

