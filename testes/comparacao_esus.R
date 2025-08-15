source('conectar/conectar.R')
con_novo <- conectar('linkage2')
con_velho <- conectar('linkage1')


query <- "SELECT id_esus_aps, id_unico, ds_nome_pac FROM tratado_esus_aps_2"

esus_novo <- dbGetQuery(con_novo, query)
esus_velho <- dbGetQuery(con_velho, 'SELECT id_unico, ds_nome_pac FROM tratado_esus_aps')


a <- esus_novo #|> 
  #select(id_unico, id_esus_aps, tbc_no_cidadao)

b <- esus_velho #|>
  #select(id_unico, tbc_no_cidadao)

d <- a |> anti_join(b, by = c("id_unico"))
