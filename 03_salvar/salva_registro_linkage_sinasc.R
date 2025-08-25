source('conectar/conectar.R')
con <- conectar('aws')


# 1. ‑‑ Cria somente a estrutura (0 linhas) -----------------------------
dbWriteTable(
  conn      = con,
  name      = SQL("registro_linkage_sinasc"),   # use SQL() para preservar maiúsculas/minúsculas
  value     = registro_linkage_final[0, ],              # dataframe zerado, mantém tipos
  overwrite = TRUE,                         # recria se já existir
  row.names = FALSE,
  field.types = c(id_registro_linkage = "BIGINT",
                  id_pessoa = "BIGINT")
)

# 2. ‑‑ Ajusta tipos/constraints depois que a tabela existe -------------
dbExecute(con, "
  ALTER TABLE registro_linkage_sinasc 
    ADD PRIMARY KEY (id_registro_linkage)
")

# 3. ‑‑ Insere o conteúdo real (mantém o esquema) -----------------------
tictoc::tic()
dbAppendTable(con, "registro_linkage_sinasc", registro_linkage_final)
tictoc::toc()