Carregando dplyr
----------------

    library(dplyr)

Criando uma base de dados
-------------------------
```r
    dados <- tibble(
      candidato = sample(letters, 10000, replace = T),
      cidade    = sample(LETTERS, 10000, replace = T),
      valor     = sample(1:3000,  10000, replace = T)
    )

    dados

    ## # A tibble: 10,000 x 3
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 y         S       1489
    ##  2 a         X       1277
    ##  3 z         R       1868
    ##  4 a         J       1015
    ##  5 k         H       1208
    ##  6 g         S       1970
    ##  7 t         S        857
    ##  8 o         Z       2849
    ##  9 r         I        127
    ## 10 x         U       2572
    ## # ... with 9,990 more rows
```
Selecionando os top 10 candidatos por valor
-------------------------------------------
```r
    top10candidatoPorValor <- 
      dados %>% 
      group_by(candidato) %>% 
      summarise(valor = sum(valor)) %>% 
      arrange(desc(valor)) %>% 
      top_n(10)

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## Selecting by valor

    top10candidatoPorValor

    ## # A tibble: 10 x 2
    ##    candidato  valor
    ##    <chr>      <int>
    ##  1 n         637727
    ##  2 w         624123
    ##  3 z         622881
    ##  4 f         612844
    ##  5 e         610155
    ##  6 c         603001
    ##  7 r         602271
    ##  8 h         595418
    ##  9 j         595341
    ## 10 v         588858
```
Selecionando a cidade com mais valor dos top 10 candidatos
----------------------------------------------------------
```r
    topCidadePorCandidato <- 
      dados %>% 
      filter(candidato %in% top10candidatoPorValor$candidato) %>% 
      arrange(desc(valor)) %>% 
      group_by(candidato) %>% 
      slice(1:10)

    topCidadePorCandidato %>% print(n = 30)

    ## # A tibble: 100 x 3
    ## # Groups:   candidato [10]
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 c         U       2996
    ##  2 c         A       2991
    ##  3 c         M       2982
    ##  4 c         T       2979
    ##  5 c         R       2977
    ##  6 c         B       2976
    ##  7 c         X       2962
    ##  8 c         E       2946
    ##  9 c         F       2940
    ## 10 c         O       2935
    ## 11 e         F       2998
    ## 12 e         B       2994
    ## 13 e         R       2985
    ## 14 e         J       2983
    ## 15 e         U       2978
    ## 16 e         K       2972
    ## 17 e         L       2971
    ## 18 e         N       2951
    ## 19 e         A       2950
    ## 20 e         D       2946
    ## 21 f         R       2996
    ## 22 f         S       2983
    ## 23 f         M       2966
    ## 24 f         C       2963
    ## 25 f         W       2948
    ## 26 f         Y       2948
    ## 27 f         C       2944
    ## 28 f         N       2938
    ## 29 f         R       2912
    ## 30 f         O       2903
    ## # ... with 70 more rows
```
