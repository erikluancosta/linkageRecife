library(dplyr)
library(stringi)
library(stringr)
library(tidyr)

source('conectar/conectar.R')

con <- conectar('aws')

df <- dbGetQuery(
  con,
  "
  SELECT
    pl.id_pessoa,
    pl.id_pareamento,
    pl.ds_nome_pac as nome,
    pl.ds_nome_mae as nome_mae,
    pl.ds_nome_pai as nome_pai,
    pl.dt_nasc,
    pl.nu_cns,
    esus.cd_raca as raca_esus,
    sinanv.ds_raca as raca_sinanv,
    sinani.ds_raca as raca_sinani,
    sim.ds_raca as raca_sim,
    sih.ds_raca as raca_sih,
    pl.sg_sexo as sexo
  FROM processo_linkage pl
  LEFT JOIN tratado_esus_aps as esus on pl.id_unico = esus.id_unico
  LEFT JOIN tratado_sinan_viol as sinanv on pl.id_unico = sinanv.id_unico
  LEFT JOIN tratado_sinan_iexo as sinani on pl.id_unico = sinani.id_unico
  LEFT JOIN tratado_sim as sim on pl.id_unico = sim.id_unico
  LEFT JOIN tratado_sih as sih on pl.id_unico = sih.id_unico
  "
)


