source('global.R')
source('conectar/conecatar.R')

# conectando ao banco de dados local
con <- conectar('linkage2')

# carregando a base bruta
sinasc <- readxl::read_excel("00_base_original/dados/recife_novo_linkage_2024/sinasc_2010_2023/DN 2010_2023.xlsx")


