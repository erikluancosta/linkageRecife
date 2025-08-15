source('global.R')
source('02_linkage/query.R')
source('02_linkage/regras.R')
source('03_salvar/salva_processo_linkage.R')
source('03_salvar/salva_registro_linkage.R') # joga com sinasc como nivel da mãe
# TEstar carregar com o linkage do sinasc antes
source("03_salvar/salva_tabela_pessoa.R")


























# Selecionando variáveis da base de linkage
df <- dbGetQuery(
  con,
  'SELECT 
      id_unico,
      id_pessoa,
      id_pareamento,
      ds_nome_pac,
      dt_nasc,
      ds_nome_mae,
      nu_cns,
      ds_nome_pai,
      banco
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


# Ajustando os nomes para o padrão do linkage
source('funcoes/ajuste_txt2.R')
## Mãe
sinasc_mae <- sinasc_mae |> 
              ajuste_txt2()  
## Filho
sinasc_filho <- sinasc_filho |> 
                ajuste_txt2()


df_menor <- bind_rows(sinasc_filho, sinasc_mae, df)


rm(df, sinasc_mae, sinasc_filho)

source('funcoes/algoritmo.R')

df_menor <- df_menor |>
  start_linkage_dt(c('ds_nome_mae', 'dt_nasc', 'nu_cns'))

df_menor <- df_menor |>
  regras_linkage_dt(c('ds_nome_pac', 'ds_nome_mae', 'dt_nasc'),2)

df_menor <- df_menor |>
  regras_linkage_dt(c('ds_nome_pac', 'dt_nasc', 'nu_cns'),3)



sinasc_filtro <- df_menor |>
  filter(banco == 'SINASC', !is.na(par_1)) |> 
  select(par_1)

com_sinasc <- df_menor |> 
  filter(par_1 %in% sinasc_filtro$par_1)
