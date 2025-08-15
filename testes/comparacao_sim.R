source('conectar/conectar.R')
con_novo <- conectar('linkage2')
con_velho <- conectar('linkage1')


query <- "SELECT * FROM tratado_sim"

sim_novo <- dbGetQuery(con_novo, query)
sim_velho <- dbGetQuery(con_velho, query)


a <- sim_novo |> 
  select(id_unico, id_sim, ds_nome_pac)

b <- sim_velho |>
  select(id_unico,ds_nome_pac, id_SIM)

d <- a |> anti_join(b, by = c("id_unico"))
###########################
## TESTE DE DROPS DO SIM ##
###########################

source('funcoes/algoritmo.R')

sim2 <- sim2 |> start_linkage_dt(c('ds_nome_pac', 'dt_nasc', 'ds_nome_mae', 'ds_bairro_res'))
sim2 <- sim2 |> regras_linkage_dt(c('ds_nome_pac_sound', 'dt_nasc', 'ds_nome_mae_sound', 'ds_bairro_res', 'dt_obito'), 2)
sim2 <- sim2 |> 
  select(par_1, id_unico, id_sim, ds_nome_pac, ds_nome_mae, dt_nasc, nu_cns, ds_nome_mae_sound, everything())


source('funcoes/remove_duplicados_sim.R')
res  <- sim2 |> 
  remove_duplicados_sim()

df_final <- res$data

res$resumo

dropados <- res$drops

