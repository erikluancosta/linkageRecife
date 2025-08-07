### CRIAÇÃO DO PAR DE REGISTRO (antigo par_f)

library(dplyr)
library(tidyr)
library(lubridate)
# Função para finalizar o linkage e criar o par de registro
finaliza_linkage <- function(df) {
  
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
    ) |> 
    select(id_pessoa, id_pareamento, ds_nome_pac, dt_nasc, ds_nome_mae, nu_cns, banco, starts_with("par_c"), everything()) 
  return(df)
  
}


cria_base_registro <- function(df){
  
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
  return(base_registro)
}
