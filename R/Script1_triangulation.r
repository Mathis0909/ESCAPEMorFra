
#################################################################################################################################################################################
############################################################################# INPUT DATA ########################################################################################
#################################################################################################################################################################################

name_file <- "data_ind4" # name file input (without extension)

path_output <- here::here("output") # path output
dir.create(here::here("output"), showWarnings = FALSE) # creat folder


#################################################################################################################################################################################
############################################################################# RUN ###############################################################################################
#################################################################################################################################################################################
# Export txt
field_BDD <- read.csv(here::here("data", paste0(name_file, ".csv")), header = TRUE, stringsAsFactors = TRUE)
write.table(field_BDD, paste0(path_output, "/", name_file, ".txt"), sep = ",", row.names = FALSE)

# Import table txt
field_BDD <- utils::read.table(paste0(path_output, "/data_ind4.txt"), header = TRUE, sep = ",")

# Date formatage
field_BDD$Date <- as.Date(field_BDD$Date, format = "%d/%m/%Y")

# Transform database to receiver database
BDD_receiver <- sigloc::as.receiver(x = field_BDD)

# Calcul intersection by maximum likelihood estimation (MLE) approach described in Lenth (1981)
BDD_intersect <- sigloc::findintersects(BDD_receiver)

# Estimation of localisation by MLE approach. Warning message if there are bad points detected by group (group = GID column)
BDD_locate <- sigloc::locate(BDD_receiver)

# Shaping database and exportation
BDD_export <- data.frame(matrix(unlist(BDD_intersect), nrow = length(BDD_intersect), byrow = TRUE))
name_obj_list <- names(BDD_intersect) 
row.names(BDD_export) <- name_obj_list # rename row
BDD_export <- t(BDD_export) # transposer le dataframe (inverse col et row)

# Export table
BDD_export <- na.omit(BDD_export) # remove NA (bug triangulation)
utils::write.csv2(x = BDD_export, file = paste0(path_output, "/", "BDD_waypoints.csv"))



