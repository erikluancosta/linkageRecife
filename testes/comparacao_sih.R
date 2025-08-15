source('conectar/conectar.R')
con_novo <- conectar('linkage2')
con_velho <- conectar('linkage1')


query <- "SELECT * FROM tratado_sih"

sih_novo <- dbGetQuery(con_novo, query)
sih_velho <- dbGetQuery(con_velho, query)


a <- sih_novo |> 
  select(id_unico, id_sih, ds_nome_pac)

b <- sih_velho |>
  select(id_unico, ds_nome_pac)

d <- a |> inner_join(b, by = c("id_unico"))
