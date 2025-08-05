source('global.R') # a conexão já é montada aqui
source('funcoes/ajuste_txt2.R')

# Carregar os dados do banco de dados
sim <- dbGetQuery(con, "SELECT * FROM original_sim")

sim2 <- sim |> 
  vitallinkage::upper_case_char() |>
  vitallinkage::padroniza_variaveis(namestand2,nome_base = "SIM") |> 
  vitallinkage::ajuste_data(tipo_data=1) |>
  vitallinkage::ano_sim() |> # Adicionando o ano
  vitallinkage::copia_nomes() |>
  vitallinkage::gemelar("ds_nome_pac") |> # Cria coluna de gemelar
  mutate(
    id_registro_linkage = -1,
    recem_nasc = ifelse(
      grepl(
        "^(RN |FM |FM1 |FM2 |FMI |FMII |IFM|RECEM NASCIDO|RN NASCIDO|NATIMORTO|NATIMORTI|FETO MORTO|FETO|MORTO|NASCIDO VIVO|VIVO|NASCIDO|SEM DOC|CADAVER|NATIMORTE|RECEM|IGNORADO|RECEM NASCIDO DE )", 
        ds_nome_pac), 1, NA),
    nu_cns = str_trim(case_when(
      nu_cns == "000000000000000" ~ NA_character_,
      nu_cns == "00000000000" ~ NA_character_,
      nu_cns == "000000000" ~ NA_character_,
      nu_cns == "00000000000000" ~ NA_character_,
      nu_cns == "000000000000000" ~ NA_character_,
      nu_cns == "000000000000001" ~ NA_character_,
      nu_cns == "000000000000002" ~ NA_character_,
      nu_cns == "000000000000003" ~ NA_character_,
      nu_cns == "000000000000004" ~ NA_character_,
      nu_cns == "000000000000005" ~ NA_character_,
      nu_cns == "000000000000006" ~ NA_character_,
      nu_cns == "000000000000007" ~ NA_character_,
      nu_cns == "000000000000008" ~ NA_character_,
      nu_cns == "000000000000009" ~ NA_character_,
      nu_cns == "000000000000010" ~ NA_character_,
      nu_cns == "000000000000011" ~ NA_character_,
      nu_cns == "" ~ NA_character_,
      TRUE ~ nu_cns
    ))
  )|> 
  ajuste_txt2() |> 
  vitallinkage::soundex_linkage("ds_nome_pac") |>
  vitallinkage::soundex_linkage("ds_nome_pai") |>
  vitallinkage::soundex_linkage("ds_nome_mae") |>
  mutate(across(starts_with("ds_nome_"), ~ ifelse(. == "", NA, .))) |> 
  mutate(across(starts_with("ds_nome_"), ~ ifelse(. == "0000", NA, .))) |> 
  vitallinkage::ajuste_res() |> # Ajusta as variáveis que contem "_res" na composição
  vitallinkage::soundex_linkage("ds_bairro_res") |>
  vitallinkage::soundex_linkage("ds_rua_res") |>
  vitallinkage::soundex_linkage("ds_comple_res") |>
  mutate(across(ends_with("_res2"), ~ ifelse(. == "", NA, .))) |> 
  mutate(across(ends_with("_res2_sound"), ~ ifelse(. == "0000", NA, .))) |> 
  vitallinkage::drop_duplicados_sim_padronizado() |> 
  ## NOVAS VARIÁVEIS
  vitallinkage::ds_raca_sim() |> # Ajustando a raça/cor
  vitallinkage::corrige_sg_sexo() |> # Ajustando a variável sg_sexo
  vitallinkage::nu_idade_anos_sim() |> # Ajustanso a idade em anos
  dplyr::mutate(morreu=1) |>  
  mutate(
    ds_raca = stringr::str_to_title(ds_raca),
    ds_raca = case_when(
      ds_raca == "Ignorado" ~ "Ignorada",
      ds_raca == "Indigena" ~ "Indígena",
      TRUE ~ ds_raca)
  ) |> 
  mutate(
    ano = as.numeric(ano),
    ano_nasc = year(dt_nasc)
  ) |> 
  select(id_sim, id_registro_linkage, id_unico, everything()) |>
  arrange(id_sim)


sim <- sim2
rm(sim2)
#-----------------------------------
# Adicionar ao banco de dados
#-----------------------------------

# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("tratado_sim"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = sim[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE,
  field.types = c(id_sim = "BIGINT",
                  id_registro_linkage = "BIGINT")
)

# 2. ‑‑ Ajusta tipos/constraints depois que a tabela existe -------------
dbExecute(con, "
  ALTER TABLE tratado_sim 
    ADD PRIMARY KEY (id_sim)
")


# 3. ‑‑ Insere o conteúdo real (mantém o esquema) -----------------------
dbAppendTable(con, "tratado_sim", sim)


