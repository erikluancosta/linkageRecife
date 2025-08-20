source('global.R')
source('funcoes/finaliza_linkage.R')

df <- finaliza_linkage(df)

# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("processo_linkage"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = df[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE#,
  #field.types = c(id_registro_linkage = "BIGINT")#,
  # field.types = c(id_unico = "BIGINT")
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




