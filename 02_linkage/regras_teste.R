# NOVOS TESTES - FALTA VALIDAR 
df <- df |> 
  mutate(
    pac_13 = substr(ds_nome_pac, 1, 13),
    mae_13 = substr(ds_nome_mae, 1, 13),
  )



df <- df |> 
  regras_linkage_dt(
    c('pac_13', 'mae_13', 'dia_nasc', 'mes_nasc', 'nu_cns'),
    58
  )

df <-  df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'mae_13','dia_nasc', 'ano_nasc', 'nu_cns', 'nao_recem_nasc'),
    59
  )

df <-  df |> 
  regras_linkage_dt(
    c('pac_13', 'mae_13','mes_nasc', 'ano_nasc', 'nu_cns', 'nao_recem_nasc'),
    60
  )



df <-  df |> 
  regras_linkage_dt(
    c('pac_13', 'dt_nasc','ds_nome_mae_sound', 'nu_cns', 'nao_recem_nasc'),
    61
  )

df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'ds_nome_pac2_sound', 'dt_nasc', 'ds_nome_mae', 'nu_cns'),
    62
  )

df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac1', 'dt_nasc', 'ds_nome_mae1', 'ds_nome_mae2', 'ds_bairro_res'),
    63
  )


df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'dia_nasc', 'mes_nasc', 'ds_nome_mae1', 'ds_nome_mae2', 'nu_cns'),
    64
  )

df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac', 'dt_nasc', 'ds_nome_mae', 'nao_recem_nasc'),
    65
  )
