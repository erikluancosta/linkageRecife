source('conectar/conectar.R')
con_novo <- conectar('linkage2')
con_velho <- conectar('linkage1')


query <- "SELECT par_1 as par_1antigo, id_unico, ds_nome_pac, dt_nasc, ds_nome_mae, nu_cns, ds_bairro_res, banco FROM linkage_temp2"

linkage_velho <- dbGetQuery(con_velho, query)


df$id_unico <- sub("NA$", "", df$id_unico)

a <- df |> select(id_unico, par_1, ds_nome_pac, dt_nasc, ds_nome_mae, nu_cns, ds_bairro_res, banco)

b <- a |> inner_join(linkage_velho, by=c('id_unico'))

coco <- b |> filter(is.na(par_1antigo)&!is.na(par_1))
coco <- b |> filter(par_1 %in% coco$par_1)

buscar <- a |> filter(id_unico %in% coco$id_unico)
