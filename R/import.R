# Importation et remaniement des données

tyrannus<-read.csv("data/Tyrannus_voucher_table_(for_Dryad) (1).csv")

# Etape 1 : Importation des données brutes --------------------------------

tyrannus1<-sfilter(tyrannus, Species %in% c("Tyrannus caudifasciatus","Tyrannus melancholicus","Tyrannus savana","Tyrannus vociferans"))%>.%
select(., -Measurer, -contains("Collection"),-State.province, -County.District,-Locality, -Elevation)
# Etape 2 : Description brève des données ---------------------------------



# Etape 3 : Nettoyage des données  ----------------------------------------



# Etape 4 : Ajout des labels et des unités --------------------------------
names(tyrannus1)[names(tyrannus1) == "Species"] <- "species"
names(tyrannus1)[names(tyrannus1) == "Subspecies"] <- "subspecies"
names(tyrannus1)[names(tyrannus1) == "Specimen.."] <- "specimen"
names(tyrannus1)[names(tyrannus1) == "Country"] <- "country"
names(tyrannus1)[names(tyrannus1) == "BL.Average"] <- "bill_length"
names(tyrannus1)[names(tyrannus1) == "BW.Average"] <- "bill_width"
names(tyrannus1)[names(tyrannus1) == "BD.Average"] <- "bill_depth"
names(tyrannus1)[names(tyrannus1) == "Tarsus.Average"] <- "tarsus"
names(tyrannus1)[names(tyrannus1) == "Kipp.s.Average"] <- "kipp"
names(tyrannus1)[names(tyrannus1) == "WC.Average"] <- "wing_cord"
names(tyrannus1)[names(tyrannus1) == "Tail"] <- "tail"
names(tyrannus1)[names(tyrannus1) == "Age"] <- "age"
names(tyrannus1)[names(tyrannus1) == "Sex"] <- "sex"



tyrannus1[tyrannus1 == "null"] <- NA




levels(tyrannus1$sex)[levels(tyrannus1$sex) == "Female"] <- "Femelle"
levels(tyrannus1$sex)[levels(tyrannus1$sex) == "Male"] <- "Mâle"
levels(tyrannus1$sex)[levels(tyrannus1$sex) == "Unknown"] <- NA

levels(tyrannus1$age)[levels(tyrannus1$age) == "Adult"]       <- "Adulte"
levels(tyrannus1$age)[levels(tyrannus1$age) == "Fledgling"]   <- "Oisillon volant"
levels(tyrannus1$age)[levels(tyrannus1$age) == "HatchYear"]   <- "Jeune de l'année"
levels(tyrannus1$age)[levels(tyrannus1$age) == "Juvenile"]    <- "Juvénile"
levels(tyrannus1$age)[levels(tyrannus1$age) == "Nestling"]    <- "Oisillon au nid"
levels(tyrannus1$age)[levels(tyrannus1$age) == "SecondYear"]  <- "Deuxième année"
levels(tyrannus1$age)[levels(tyrannus1$age) == "Unknown"]     <- NA


tyrannus1$full_sp <- paste(tyrannus1$species, tyrannus1$subspecies, sep = " ")
label(tyrannus1$full_sp) <- "Nom complet"
units(tyrannus1$full_sp) <- NA


tyrannus1[, c(3,5:11)] <- lapply(tyrannus1[, c(3,5:11)], as.numeric)
tyrannus1[, c(1:2,12:14)] <- lapply(tyrannus1[, c(1:2,12:14)], as.factor)


tyrannus1 <- labelise(tyrannus1,
  label = list(
    species       = "Espèce",
    subspecies    = "Sous-espèce",
    specimen      = "Numéro du spécimen",
    country       = "Pays",
    bill_length   = "Longueur du bec",
    bill_width    = "Largeur du bec",
    bill_depth    = "Profondeur du bec",
    tarsus        = "Longueur du tarse",
    kipp          = "Distance de Kipp",
    wing_cord     = "Longueur du cordon alaire",
    tail          = "Longueur de la queue",
    age           = "Âge",
    sex           = "Sexe"
  ),
  units = list(
    species       = NA,
    subspecies    = NA,
    specimen      = NA,
    country       = NA,
    bill_length   = "mm",
    bill_width    = "mm",
    bill_depth    = "mm",
    tarsus        = "mm",
    kipp          = "mm",
    wing_cord     = "mm",
    tail          = "mm",
    age           = "Années",
    sex           = NA
  )
)
label(tyrannus1$full_sp) <- "Nom complet"
units(tyrannus1$full_sp) <- NA

caudi<-sfilter(tyrannus1, species=="Tyrannus caudifasciatus")
melan<-sfilter(tyrannus1, species=="Tyrannus melancholicus")
savana<-sfilter(tyrannus1, species=="Tyrannus savana")
vocif<-sfilter(tyrannus1, species=="Tyrannus vociferans")


# Etape 5 : Sauvegarde locale des données retravaillées -------------------

write$rds(tyrannus1, "data/tyrannus.rds")
