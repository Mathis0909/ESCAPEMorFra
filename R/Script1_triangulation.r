
################################################### Donnée


field_BDD <- read.csv(here::here("data", "data_ind4.csv"), header = TRUE, stringsAsFactors = TRUE)

path_output <- here::here("output")
dir.create(here::here("output"), showWarnings = FALSE)







###################################################### Run

# Conversion csv to txt
write.table(field_BDD, paste(path_output, "/data_ind4.txt", sep = ""))

# Import table
field_BDD <- utils::read.table(here::here("output", "data_ind4.txt"), header = TRUE, stringsAsFactors = TRUE)

# Date formatage
field_BDD$Date <- as.Date(field_BDD$Date, format="%d/%m/%Y")

# Transform bearing database to receiver database
BDD_receiver <- sigloc::as.receiver(x = field_BDD)

# Calcul bearings intersection by maximum likelihood estimation (MLE) approach described in Lenth (1981)
BDD_intersect <- sigloc::findintersects(BDD_receiver)

# Estimation of localisation by MLE approach. Warning message if there are bad points detected by group (group = GID column)
BDD_locate <- sigloc::locate(BDD_receiver)

# Shaping database and exportation
BDD_export <- data.frame(matrix(unlist(BDD_intersect), nrow = length(BDD_intersect), byrow = TRUE))
name_obj_list <- names(BDD_intersect)
row.names(BDD_export) <- name_obj_list
BDD_export <- t(BDD_export)

utils::write.csv2(x = BDD_export, file = paste0(path_output, "/", "BDD_waypoints.csv"))



