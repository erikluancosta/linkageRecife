source('conectar/conectar.R')
con_novo <- conectar('linkage2')
con_velho <- conectar('linkage1')


query <- "SELECT * FROM tratado_sinan_viol"

sinan_novo <- dbGetQuery(con_novo, query)
sinan_velho <- dbGetQuery(con_velho, query)


a <- sinan_novo |> 
  select(id_unico, id_SINAN_VIOL, ds_nome_pac)

b <- sinan_velho |>
  select(id_unico, id_SINAN_VIOL, ds_nome_pac)

d <- a |> inner_join(b, by = c("id_unico"))
