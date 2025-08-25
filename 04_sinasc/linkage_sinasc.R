library(dplyr)
library(stringi)
library(stringr)
library(tidyr)
source('conectar/conectar.R')

con <- conectar('aws')
#################
## ORGANIZANDO AS BASES
#################
#Base já linkada
linkada <- dbGetQuery(
  con,
  'SELECT 
      --id_registro_linkage,
      id_unico,
      id_pessoa,
      id_pareamento,
      CAST(id_pessoa AS INTEGER) AS par_1,
      par_2,
      ds_nome_pac,
      ds_nome_mae,
      ds_nome_pai,
      dt_nasc,
      nu_cns,
      banco,
      --.rowid,
      --flag,
      original_index
   FROM processo_linkage'
)


# Selecionando variáveis da mãe da base do SINASC
sinasc_mae <- dbGetQuery(
  con,
  'SELECT 
      id_unico,
      id_sinasc,
      "NOMEMAE" as ds_nome_pac,
      "DTNASCMAE" as dt_nasc,
      "NUMSUSMAE" as nu_cns,
      banco,
      \'Mãe\' as nivel
   FROM original_sinasc'
)

# Selecionando variáveis do filho da base do SINASC
sinasc_filho <- dbGetQuery(
  con,
  'SELECT 
      id_unico,
      id_sinasc,
      "NOMERNASC" as ds_nome_pac,
      "DTNASC" as dt_nasc,
      "NOMEMAE" as ds_nome_mae,
      "NOMEPAI" as ds_nome_pai,
      "NUMSUSMAE" as nu_cns,
      banco,
      \'Filho\' as nivel
   FROM original_sinasc'
) 

source('funcoes/ajuste_txt2.R')
## Mãe
sinasc_mae <- sinasc_mae |> 
  ajuste_txt2()  
## Filho
sinasc_filho <- sinasc_filho |> 
  ajuste_txt2()

#################
## LINKAGE
#################

# criando a base do linkage
df2 <- bind_rows(sinasc_filho, sinasc_mae, linkada)

source('funcoes/algoritmo.R')

df2 <- df2 |>
  regras_linkage_dt(c('ds_nome_mae', 'dt_nasc', 'nu_cns'),2)

df2 <- df2 |>
  regras_linkage_dt(c('ds_nome_pac', 'ds_nome_mae', 'dt_nasc'),3)

df2 <- df2 |>
  regras_linkage_dt(c('ds_nome_pac', 'dt_nasc', 'nu_cns'),4)


################
## TABELA DE PAREAMENTO
################

df2 <- df2 |> 
  mutate(
    id_pareamento = ifelse(is.na(id_pareamento), par_1, id_pareamento),
    id_pessoa     = ifelse(is.na(id_pessoa), id_pareamento, id_pessoa),
    id_pessoa     = case_when(
      # Criar novo id_pessoa somente quando nivel é NA ou "Mãe" e id_pessoa também está NA
      (is.na(nivel) | nivel == "Mãe") & is.na(id_pessoa) ~ 
        max(id_pareamento, na.rm = TRUE) + row_number(),
      # Caso contrário, mantém o valor atual
      TRUE ~ id_pessoa
    )
  )


sinasc_final <- df2 |>
  filter(banco == "SINASC") |>
  select(id_unico, nivel, id_pessoa) |>
  mutate(nivel_norm = tolower(stri_trans_general(nivel, "Latin-ASCII"))) |>
  # se houver mais de um par_1 por id_unico/nivel, pega o primeiro distinto
  distinct(id_unico, nivel_norm, id_pessoa, .keep_all = FALSE) |>
  # uma linha por id_unico; colunas: par_1_mae e par_1_filho
  pivot_wider(
    id_cols = id_unico,
    names_from = nivel_norm,
    values_from = id_pessoa,
    names_prefix = "par_1_",
    values_fn = list(id_pessoa = ~unique(na.omit(.x))[1])
  ) |> 
  # mutate(id_pareamento=par_1_mae) |> 
  rename(
    "id_filho" = par_1_filho,
    'id_pessoa_mae' = par_1_mae
  )

#################
## REFERENCIANDO OS IDS DE FILHOS E DE MÃE
#################
sinasc_filho <- df2 |> 
  filter(nivel == 'Filho') |> 
  select(id_unico, id_pessoa, par_1) |> 
  rename("id_pessoa_filho" = id_pessoa,
         "id_pareamento_filho" = par_1)

# Adicionando id fo 
df <- df2 |> 
  filter(nivel %in% c("Mãe", NA_character_)) |> 
  left_join(sinasc_filho, by=c('id_unico'))  |>
  group_by(id_pessoa) |>
  mutate(
    id_pessoa_filho = ifelse(is.na(id_pessoa_filho), id_pareamento_filho, id_pessoa_filho)
  ) |>
  fill(id_pessoa_filho, .direction = "downup") |> 
  ungroup() |> 
  select(-id_pareamento_filho)


id_pessoa_mae <- sinasc_final |>
  filter(!is.na(id_filho)) |>
  select(id_filho, id_pessoa_mae) |> 
  rename(id_pessoa = id_filho)

df <- df |>
  left_join(id_pessoa_mae, by = "id_pessoa")

rm(df2, linkada, sinasc_filho, sinasc_mae)

source('03_salvar/salva_processo_sinasc.R')
