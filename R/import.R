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



# Etape 4 : Ajout des labels et des unités --------------------------------



# Etape 5 : Sauvegarde locale des données retravaillées -------------------
write$rds(thraupidae, "data/thraupidae.rds")
