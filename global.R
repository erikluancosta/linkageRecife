#---------------------------
# Carregando pacotes
#---------------------------
library(vitallinkage)
library(vitaltable)
library(tidyr)
library(dplyr)
library(foreign)
library(RPostgres)
library(DBI)


#---------------------------
# Carregar a função de conexão
#---------------------------
source('conectar/conectar.R')
con <- conectar('linkage2')