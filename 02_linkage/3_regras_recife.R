library(tidyverse)
library(data.table)
library(foreign)
library(writexl)
library(vitaltable)
library(tictoc)
library(base)
library(pdftools)



df <- linkage |>
  start_linkage2(c('nu_doc', 'ds_nome_pac_sound', "dt_nasc"))  


# Regra para iniciar o linkage - Ok
df <- linkage |>
  start_linkage2(c('nu_doc', 'ds_nome_pac_sound', "ano_nasc"))  
  #select(par_1, par_c1, ds_nome_pac, dt_nasc, ds_nome_mae, nu_doc, everything())

df <- df |> select(par_1, par_c1, ds_nome_pac, dt_nasc, ds_nome_mae, nu_doc, everything())

# Regra 2 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac", "dt_nasc", "ds_nome_mae", "nu_cns"),
    2)

# Regra 3 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae1", "ds_nome_mae2", "nu_cns", "recem_nasc"),
    3)

# Regra 4 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae1", "ds_nome_mae3", "nu_cns","recem_nasc"),
    4)

# Regra 5 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac", "dia_nasc","ano_nasc", "ds_nome_mae", "nu_cns"),
    5)

# Regra 6 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac", "mes_nasc","ano_nasc", "ds_nome_mae", "nu_cns"),
    6)

# Regra Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac", "mes_nasc","dia_nasc", "ds_nome_mae", "nu_cns"),
    7)

# Regra 8 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3","mes_nasc","dia_nasc", "ds_nome_mae", "nu_cns","recem_nasc"),
    8)

# Regra 9 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc","dia_nasc", "ds_nome_mae", "nu_cns","recem_nasc"),
    9)

# Regra 10 - Ok 
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc","mes_nasc", "ds_nome_mae", "nu_cns","recem_nasc"),
    10)


# Regra 11 - Ok 
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3","ano_nasc", "dt_nasc", "ds_nome_mae3", "nu_cns","recem_nasc"),
    11)



# Regra 12 - Ok 
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac2","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    12)




# VERSAO DAS 12 REGRAS COM SOUNDEX
# Regra 13 - Ok
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "dt_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    13)

# Regra 14
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound", "dt_nasc", "ds_nome_mae1_sound", "ds_nome_mae2_sound", "nu_cns","recem_nasc"),
    14)

# Regra 15
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound", "dt_nasc", "ds_nome_mae1_sound", "ds_nome_mae3_sound", "nu_cns","recem_nasc"),
    15)

# Regra 16
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "dia_nasc","ano_nasc", "ds_nome_mae_sound", "nu_cns"),
    16)

# Regra 17
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "mes_nasc","ano_nasc", "ds_nome_mae_sound", "nu_cns"),
    17)

# Regra 18
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "mes_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns"),
    18)

# Regra 19
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","mes_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    19)

# Regra 20
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc","dia_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    20)

# Regra 21
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    21)


# Regra 22
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac3_sound","ano_nasc", "dt_nasc", "ds_nome_mae3_sound", "nu_cns","recem_nasc"),
    22)



# Regra 23
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1_sound", "ds_nome_pac2_sound","ano_nasc","mes_nasc", "ds_nome_mae_sound", "nu_cns","recem_nasc"),
    23)



# Regras com o telefone
# Regra 24
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "nu_tel", 'dt_nasc',"recem_nasc"),
    24)

# Regra 25
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', 'ds_nome_mae', 'dt_nasc'),
    25)

# Regra 26
df <- df |> 
  regras_linkage2(
    c('par_c25'),
    26)

df <- df |> 
  regras_linkage2(
    c('par_c24'),
    26.1
  )

# Regra 27
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac_sound', 'ds_nome_mae_sound', 'dt_nasc'),
    27)

# Regra 27.1
df <- df |> 
  regras_linkage2(
    c('par_c27'),
    27.1)

# Regras 28
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac1', 'dt_nasc', 'nome_raro',"recem_nasc"),
    28
  )

# Regras 29
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac1', 'dia_nasc', 'mes_nasc', 'nome_raro',"recem_nasc", 'ds_nome_mae1_sound'),
    29
  )

# Regras 30
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac1', 'ano_nasc', 'mes_nasc', 'nome_raro',"recem_nasc", 'ds_nome_mae1_sound'),
    30
  )

# Regras 31
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac1', 'ano_nasc', 'dia_nasc', 'nome_raro',"recem_nasc", 'ds_nome_mae1_sound'),
    31
  )

# Regra 32
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac1", "ds_nome_pac3", "dt_nasc", "ds_nome_mae_sound", "dt_obito","recem_nasc"),
    32)

# Regra 33
df <- df |> 
  regras_linkage2(
    c("ds_nome_pac_sound", "dt_nasc", "ds_nome_mae_sound", "dt_obito","recem_nasc"),
    33)


# Regra 34
df <- df |> 
  regras_linkage2(
    c('dt_nasc', 'dt_obito', 'ds_bairro_res', 'ds_nome_pac1_sound',"ds_nome_pac3_sound",'ds_nome_mae',"recem_nasc"),
    34)

# Regra 35
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac1_sound', 'nu_tel', 'ano_nasc', 'mes_nasc', 'ds_nome_mae1', 'ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    35
  )

# Regra 35.1
df <- df |> 
  regras_linkage2(
    c('par_c35'),
    35.1
  )

# Regra 36
df <- df |> 
  regras_linkage2(
    c('dt_nasc', 'nome_menos_2d', 'ignora_maria', 'ignora_francisca', "ignora_josefa", 'mae_menos5d',"recem_nasc"),
    36
  )

# Regra 36.1
df <- df |> 
  regras_linkage2(
    c('par_c36'),
    36.1
  )

# Regra 37
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac_sound', 'dt_nasc', 'mae_menos5d', 'ignora_maria', 'ignora_francisca', "ignora_josefa"),
    37
  )

# Regra 38
df <- df |> 
  regras_linkage2(
    c('dt_nasc', 'nome_pac_6', 'ds_nome_mae','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    38
  )

# Regra 38.1
df <- df |> 
  regras_linkage2(
    c('par_c38'),
    38.1
  )


# Regra 39
df <- df |> 
  regras_linkage2(
    c('dt_nasc', 'nome_pac_6', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    39
  )

# Regra 40
df <- df |> 
  regras_linkage2(
    c('dt_nasc', 'nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    40
  )

# Regra 41
df <- df |> 
  regras_linkage2(
    c('dia_nasc', 'mes_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc", 'ds_nome_pac1', 'dt_obito'),
    41
  )

# Regra 41.1
df <- df |> 
  regras_linkage2(
    c('par_c41'),
    41.1
  )

# Regra 42
df <- df |> 
  regras_linkage2(
    c('ano_nasc', 'mes_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc", 'ds_nome_pac1'),
    42
  )

# Regra 43
df <- df |> 
  regras_linkage2(
    c('ano_nasc', 'dia_nasc','nome_5_12', 'mae_menos5d','ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc", 'dt_obito'),
    43
  )

# Regra 43.1
df <- df |> 
  regras_linkage2(
    c('par_c43'),
    43.1
  )

# Regra 44
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', 'dt_nasc', 'nu_cns','cd_mun_res', 'ds_bairro_res',"recem_nasc"),
    44
  )

# Regra 45
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', 'ano_nasc', 'dia_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"recem_nasc"),
    45
  )


# Regra 46
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', 'ano_nasc', 'mes_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"recem_nasc"),
    46
  )

# Regra 47
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', 'ds_nome_mae1','dia_nasc', 'mes_nasc','nu_cns','cd_mun_res', 'ds_bairro_res',"recem_nasc"),
    47
  )



# Regra 48
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', "nu_tel", 'ds_nome_mae', 'ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    48
  )

# Regra 49
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac', "nu_cns", 'ds_nome_mae', 'ignora_maria', 'ignora_francisca', "ignora_josefa","recem_nasc"),
    49
  )


# Regra 50
df <- df |> 
  regras_linkage2(
    c('ds_nome_pac_sound', 'dt_nasc', 'mae_menos5d', 'nu_tel',"recem_nasc"),
    50
  )

# Regra 51
df <- df |> 
  regras_linkage2(c('ds_bairro_res','cd_mun_res','nome_menos_5d', 'mae_menos5d', 'dt_nasc', 'ignora_maria',"recem_nasc"),
                  51)

# Regra 52
df <- df |> 
  regras_linkage2(
    c('mae_menos5d', 'ds_nome_pac1', 'ds_nome_pac2_sound', 'dt_nasc', 'ds_bairro_res', 'ds_nome_mae1_sound',"recem_nasc"),
    52)




# Regra 53
df <- df |> 
  regras_linkage2(
    c('mae_menos5d', 'nome_5_12', 'dt_nasc', "nu_cns",'recem_nasc'),
    53)

# Rega 53.q
df <- df |> 
  regras_linkage2(
    c('par_c53'),
    53.1)

# Regra 54
df <- df |> 
  regras_linkage2(
    c('mae_menos5d', 'nome_5_12','ano_nasc' ,'mes_nasc', "nu_cns",'recem_nasc'),
    54)

# Regras 55
df <- df |> 
  regras_linkage2(
    c('mae_menos5d', 'nome_5_12','ano_nasc' ,'dia_nasc', "nu_cns",'recem_nasc'),
    55)


df <- df |> 
  regras_linkage2(
    c('mae_menos5d', 'nome_5_12','mes_nasc' ,'dia_nasc', "nu_cns",'recem_nasc'),
    56)


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


base_registro <- df |> 
  select(id_unico, id_pareamento, id_pessoa, banco, dt_evento_inicio, dt_evento_fim, dt_registro, recem_nasc) |> 
  mutate(
    recem_nasc = as.numeric(recem_nasc), # garante que recem_nasc é numérico
    recem_nasc = case_when(
      recem_nasc == 1 ~ NA_real_,
      is.na(recem_nasc) ~ 1,
      TRUE ~ recem_nasc
    )
  )
