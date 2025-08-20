source('conectar/conectar.R')
con <- conectar('aws')

# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("processo_linkage_sinasc"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = df[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE#,
  #field.types = c(id_registro_linkage = "BIGINT")#,
  # field.types = c(id_unico = "BIGINT")
)


# 3. ‑‑ Insere o conteúdo real (mantém o esquema) -----------------------
tictoc::tic()
dbAppendTable(con, "processo_linkage_sinasc", df)
tictoc::toc()



# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("sinasc_ids"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = sinasc_final[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE#,
  #field.types = c(id_registro_linkage = "BIGINT")#,
  # field.types = c(id_unico = "BIGINT")
)

tictoc::tic()
dbAppendTable(con, "sinasc_ids", sinasc_final)
tictoc::toc()
