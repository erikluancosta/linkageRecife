source('global.R')

# Carregar os dados
sinasc <- dbGetQuery(con, "SELECT * FROM original_sinasc")

