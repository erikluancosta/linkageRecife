source('02_linkage/query.R')

# PARA REINICIAR AS REGRAS SEM RODAR TDO DNV
df <- df |> 
  mutate(
    par_1 = par_c1
  ) |> 
  select(-starts_with(c("par_c2", "par_c3", "par_c4", "par_c5"))) |> 
  select(-par_c6, -par_c7, -par_c8, -par_c9, -par_c10, -par_c11, -par_c12, -par_c13, -par_c14, -par_c15, -par_c16, -par_c17,-par_c18, -par_c19) 


# Iniciando o linkage
df <- linkage |>
  start_linkage_dt(c('nu_doc', 'ds_nome_pac_sound', "ano_nasc"))  
rm(linkage)


# Regra para iniciar o linkage - Ok
tictoc::tic('tempo total do linkage')
df <- df |> select(par_1, par_c1, ds_nome_pac, dt_nasc, ds_nome_mae, nu_cns, everything())
# Regra 2 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac", "dt_nasc", "ds_nome_mae", "nu_cns"),
    2)

# Regra 3 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae1", "ds_nome_mae2", "nu_cns", "nao_recem_nasc"),
    3)

# Regra 4 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae1", "ds_nome_mae3", "nu_cns","nao_recem_nasc"),
    4)

# Regra 5 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac", "dia_nasc","ano_nasc", "ds_nome_mae", "nu_cns"),
    5)

# Regra 6 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac", "mes_nasc","ano_nasc", "ds_nome_mae", "nu_cns"),
    6)

# Regra Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac", "mes_nasc","dia_nasc", "ds_nome_mae", "nu_cns"),
    7)

# Regra 8 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3","mes_nasc","dia_nasc", "ds_nome_mae", "nu_cns","nao_recem_nasc"),
    8)

# Regra 9 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc","dia_nasc", "ds_nome_mae", "nu_cns","nao_recem_nasc"),
    9)

# Regra 10 - Ok 
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc","mes_nasc", "ds_nome_mae", "nu_cns","nao_recem_nasc"),
    10)

# Regra 11 - Ok 
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc", "dt_nasc", "ds_nome_mae3", "nu_cns","nao_recem_nasc"),
    11)

# Regra 12 - Ok 
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac2","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    12)

# VERSAO DAS 12 REGRAS COM SOUNDEX
# Regra 13 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "dt_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    13)

# Regra 14 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound", "dt_nasc", "ds_nome_mae1_sound", "ds_nome_mae2_sound", "nu_cns","nao_recem_nasc"),
    14)

# Regra 15 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound", "dt_nasc", "ds_nome_mae1_sound", "ds_nome_mae3_sound", "nu_cns","nao_recem_nasc"),
    15)

# Regra 16 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "dia_nasc","ano_nasc", "ds_nome_mae_sound", "nu_cns"),
    16)

# Regra 17 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "mes_nasc","ano_nasc", "ds_nome_mae_sound", "nu_cns"),
    17)

# Regra 18 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "mes_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns"),
    18)

# Regra 19 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","mes_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    19)

# Regra 20 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    20)

# Regra 21 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    21)

# Regra 22 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc", "dt_nasc", "ds_nome_mae3_sound", "nu_cns","nao_recem_nasc"),
    22)

# Regra 23 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1_sound", "ds_nome_pac2_sound","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","nao_recem_nasc"),
    23)

# Regras com o telefone
# Regra 24 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "nu_tel", 'dt_nasc',"nao_recem_nasc"),
    24)

# Regra 25 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'ds_nome_mae', 'dt_nasc'),
    25)

# Regra 26 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac_sound','dt_nasc','mae_menos10d', 'nao_recem_nasc'),
    26)

# Regra 27 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac_sound', 'ds_nome_mae_sound', 'dt_nasc'),
    27)


# Regras 28 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'dt_nasc', 'nome_raro',"nao_recem_nasc"),
    28
  )

# Regras 29 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'dia_nasc', 'mes_nasc', 'nome_raro',"nao_recem_nasc", 'ds_nome_mae1_sound'),
    29
  )

# Regras 30 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'ano_nasc', 'mes_nasc', 'nome_raro',"nao_recem_nasc", 'ds_nome_mae1_sound'),
    30
  )

# Regras 31 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'ano_nasc', 'dia_nasc', 'nome_raro',"nao_recem_nasc", 'ds_nome_mae1_sound'),
    31
  )

# Regra 32 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae_sound", "dt_obito","nao_recem_nasc"),
    32)

# Regra 33 - Ok
df <- df |> 
  regras_linkage_dt(
    c("ds_nome_pac_sound", "dt_nasc", "ds_nome_mae_sound", "dt_obito","nao_recem_nasc"),
    33)

# Regra 34 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dt_nasc', 'dt_obito', 'ds_bairro_res', 'ds_nome_pac1_sound',"ds_nome_pac3_sound",'ds_nome_mae',"nao_recem_nasc"),
    34)

# Regra 35 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1_sound', 'nu_tel', 'ano_nasc', 'mes_nasc', 'ds_nome_mae1', 'ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    35
  )

# Regra 36 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dt_nasc', 'nome_menos_2d', 'ignora_maria', 'ignora_francisca', "ignora_josefa", 'mae_menos5d',"nao_recem_nasc"),
    36
  )

# Regra 37 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac_sound', 'dt_nasc', 'mae_menos5d', 'ignora_maria', 'ignora_francisca', "ignora_josefa"),
    37
  )

# Regra 38 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dt_nasc', 'nome_pac_6', 'ds_nome_mae','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    38
  )


# Regra 39 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dt_nasc', 'nome_pac_6', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    39
  )

# Regra 40 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dt_nasc', 'nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    40
  )

# Regra 41 - Ok
df <- df |> 
  regras_linkage_dt(
    c('dia_nasc', 'mes_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc", 'ds_nome_pac1', 'dt_obito'),
    41
  )

# Regra 42 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ano_nasc', 'mes_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc", 'ds_nome_pac1'),
    42
  )

# Regra 43 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ano_nasc', 'dia_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc", 'dt_obito'),
    43
  )

# Regra 44 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'dt_nasc', 'nu_cns','cd_mun_res', 'ds_bairro_res',"nao_recem_nasc"),
    44
  )

# Regra 45 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'ano_nasc', 'dia_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"nao_recem_nasc"),
    45
  )

# Regra 46 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'ano_nasc', 'mes_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"nao_recem_nasc"),
    46
  )

# Regra 47 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'ds_nome_mae1','dia_nasc', 'mes_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"nao_recem_nasc"),
    47
  )

# Regra 48 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', "nu_tel", 'ds_nome_mae', 'ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    48
  )

# Regra 49 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', "nu_cns", 'ds_nome_mae', 'ignora_maria', 'ignora_francisca', "ignora_josefa","nao_recem_nasc"),
    49
  )

# Regra 50 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac_sound', 'dt_nasc', 'mae_menos5d', 'nu_tel',"nao_recem_nasc"),
    50
  )

# Regra 51 - Ok
df <- df |> 
  regras_linkage_dt(
    c('ds_bairro_res','cd_mun_res','nome_menos_5d', 'mae_menos5d', 'dt_nasc', 'ignora_maria',"nao_recem_nasc"),
    51)

# Regra 52 - Ok
df <- df |> 
  regras_linkage_dt(
    c('mae_menos5d', 'ds_nome_pac1', 'ds_nome_pac2_sound', 'dt_nasc', 'ds_bairro_res', 'ds_nome_mae1_sound',"nao_recem_nasc"),
    52)


# Regra 53 - Ok
df <- df |> 
  regras_linkage_dt(
    c('mae_menos5d', 'nome_5_12', 'dt_nasc', "nu_cns",'nao_recem_nasc'),
    53)

# Regra 54 - Ok
df <- df |> 
  regras_linkage_dt(
    c('mae_menos5d', 'nome_5_12','ano_nasc' ,'mes_nasc', "nu_cns",'nao_recem_nasc'),
    54)

# Regras 55 - Ok
df <- df |> 
  regras_linkage_dt(
    c('mae_menos5d', 'nome_5_12','ano_nasc' ,'dia_nasc', "nu_cns",'nao_recem_nasc'),
    55)

# NOVOS TESTES
df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'ds_nome_pac2', 'dt_nasc','ds_nome_mae2', 'ds_nome_mae3', 'ds_nome_mae1_sound'),
    56
  )


df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac_sound', 'dt_nasc', 'ds_nome_mae_sound', 'nao_recem_nasc'),
    57
  )

df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac2', 'ds_nome_pac3','dt_nasc','ds_nome_mae', 'nu_cns', 'nao_recem_nasc'),
    58
  )
tictoc::toc()


### CRIAÇÃO DO PAR DE REGISTRO (antigo par_f)

df <- df %>% 
  mutate(
    # Primeiro, substitui os valores NA em par_1
    id_pessoa = if_else(
      is.na(par_1),
      # Cria novos valores para os NA a partir do maior valor de par_1
      max(par_1, na.rm = TRUE) + row_number(),
      # Caso contrário, mantém o valor de par_1
      par_1
    )
  ) |> 
  rename(
    "id_pareamento" = par_1
  )


df <- df |> 
  select(id_unico, id_pareamento, id_pessoa, starts_with('par_c'), everything())


base_registro <- df |> 
  select(id_unico, id_pareamento, id_pessoa, banco, dt_nasc, dt_evento_inicio, dt_evento_fim, dt_registro, recem_nasc) |> 
  mutate(
    recem_nasc = as.numeric(recem_nasc), # garante que recem_nasc é numérico
  # recem_nasc = case_when(
  #   recem_nasc == 1 ~ NA_real_,
  #  is.na(recem_nasc) ~ 1,
  #   TRUE ~ recem_nasc,
  across(starts_with("dt_"), ~ as.Date(.)),
    id_registro_linkage = row_number()
  ) |> 
  select(id_registro_linkage, everything())


#-----------------------------------
# Conexão com o banco de dados
#-----------------------------------
library(RPostgres)
library(DBI)
# Configurar a conexão ao banco de dados PostgreSQL
con <- dbConnect(
  RPostgres::Postgres(),
  host = "localhost",
  port = 5432,          # Porta padrão do PostgreSQL
  user = "postgres",
  password = "123",
  dbname = "linkage_recife_novo"
)

# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("processo_linkage"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = df[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE#,
  #field.types = c(id_unico = "BIGINT")
)

# 2. ‑‑ Ajusta tipos/constraints depois que a tabela existe -------------
dbExecute(con, "
  ALTER TABLE processo_linkage 
    ADD PRIMARY KEY (id_unico)
")

# 3. ‑‑ Insere o conteúdo real (mantém o esquema) -----------------------
tictoc::tic()
dbAppendTable(con, "processo_linkage", df)
tictoc::toc()







# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("registro_linkage"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = base_registro[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE,
  field.types = c(id_registro_linkage = "BIGINT",
                  id_pessoa = "BIGINT")
)

# 2. ‑‑ Ajusta tipos/constraints depois que a tabela existe -------------
dbExecute(con, "
  ALTER TABLE registro_linkage 
    ADD PRIMARY KEY (id_registro_linkage)
")

# 3. ‑‑ Insere o conteúdo real (mantém o esquema) -----------------------
tictoc::tic()
dbAppendTable(con, "registro_linkage", base_registro)
tictoc::toc()

