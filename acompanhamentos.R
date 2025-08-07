# apenas quem linkou
linkadas <- df |>
  filter(!is.na(par_1)) |>
  select(par_1, ds_nome_pac,
         dt_nasc, ds_nome_mae,
         nu_cns, banco, starts_with("par_c"))


# Mortalidade duplicada
pareamentos <- linkadas |> 
  #filter(banco == 'SIM') |> 
  select(par_1, banco) |> 
  group_by(par_1,banco) |> 
  summarise(n = n()) |>
  pivot_wider(names_from = banco, values_from = n, values_fill = 0)


a <- df |> filter(is.na(id_pareamento))
