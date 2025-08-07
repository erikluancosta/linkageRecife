# NOVOS TESTES - FALTA VALIDAR
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
    c('ds_nome_pac', 'ano_nasc', 'dia_nasc', 'ds_nome_mae1_sound', 'ds_nome_mae3', 'nao_recem_nasc', 'ignora_maria', 'ignora_francisca', "ignora_josefa"),
    58
  )

df <- df |> 
  regras_linkage_dt(
    c('ds_nome_pac2', 'ds_nome_pac3','dt_nasc','ds_nome_mae', 'nu_cns', 'nao_recem_nasc'),
    59
  )