library(dplyr)
library(stringi)
library(stringr)
library(tidyr)
source('conectar/conectar.R')

con <- conectar('aws')


registro_linkage <- dbGetQuery(
  con,
  "SELECT * FROM registro_linkage"
)

sinasc_linkage <- dbGetQuery(
  con,
  "SELECT * FROM processo_linkage_sinasc"
)

nasc_filho = dbGetQuery(
  con,
  'SELECT id_unico, "DTNASC" as dt_nasc_filho FROM original_sinasc'
)

id_registro <-max( registr_linkage$id_registro_linkage ) 

# Criar a tabela de registro_linkage com sinasc
sinasc_linkage_2 <- sinasc_linkage |> 
  filter(banco == 'SINASC') |> 
  left_join(nasc_filho, by = 'id_unico') |>
  mutate(
    dt_evento_inicio = dt_nasc_filho,
    dt_evento_fim = dt_nasc_filho,
    dt_registro = dt_nasc_filho,
    id_registro_linkage = id_registro + row_number()
  ) |> 
  select(id_registro_linkage, id_unico, id_pareamento, id_pessoa, banco, dt_nasc, dt_nasc_filho) 

parentesco <- sinasc_linkage |> select(id_unico, id_mae, id_pessoa_filho)


registro_linkage_final <- bind_rows(registr_linkage, sinasc_linkage_2) |> 
  left_join(
    parentesco,
    by = c('id_unico')
  )




