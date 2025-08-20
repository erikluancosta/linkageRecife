# apenas quem linkou
linkadas <- df2 |>
  filter(!is.na(par_1)) |>
  select(par_1, ds_nome_pac,
         dt_nasc, ds_nome_mae,
         nu_cns, banco, starts_with("par_c"))


# Mortalidade duplicada
pareamentos <- linkadas |> 
  #filter(banco == 'SIM') |> 
  select(par_1, banco) |> 
  group_by(par_1,banco) |> 
  summarise(n = n(), .groups = 'drop') |>
  pivot_wider(names_from = banco, values_from = n, values_fill = 0) |> 
  janitor::adorn_totals('col') |> 
  janitor::adorn_totals('row')


mae <- df2 |> filter(banco == "SINASC", nivel == 'Mãe') |> 
  select(par_1)
filho <- df2 |> filter(banco == "SINASC", nivel == 'Filho') |> 
  select(par_1)

filhos_ids <- unique(if (is.data.frame(filho)) filho[["par_1"]] else filho)
maes_ids   <- unique(if (is.data.frame(mae))   mae[["par_1"]]   else mae)

pareamentos <- pareamentos |>
  dplyr::mutate(
    filho = ifelse(par_1 %in% filhos_ids, 1, 0),
    mae   = ifelse(par_1 %in% maes_ids,   1, 0)
  ) |>
  dplyr::filter(
    SINASC > 0,
    SINAN_VIOL > 0,
    par_1 %in% maes_ids | par_1 %in% filhos_ids
  ) |> 
  mutate(par_1 = as.numeric(par_1))



