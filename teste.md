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
    ##  1 v         Q       2923
    ##  2 p         T       2277
    ##  3 t         D         23
    ##  4 d         M       2385
    ##  5 d         I       1172
    ##  6 j         A       1206
    ##  7 t         G       2798
    ##  8 s         R       2389
    ##  9 j         M       2583
    ## 10 l         J       1478
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
    ##  1 a         644313
    ##  2 q         623122
    ##  3 j         615579
    ##  4 t         612062
    ##  5 e         610184
    ##  6 w         604008
    ##  7 i         597240
    ##  8 r         588626
    ##  9 p         583236
    ## 10 d         580460
```
Selecionando a cidade com mais valor dos top 10 candidatos
----------------------------------------------------------
```r
    topCidadePorCandidato <- 
      dados %>% 
      filter(candidato %in% top10candidatoPorValor$candidato) %>% 
      group_by(candidato) %>% 
      filter(valor == pmax(valor, 10)) %>% 
      arrange(candidato)

    topCidadePorCandidato %>% print(n = 30)

    ## # A tibble: 3,995 x 3
    ## # Groups:   candidato [10]
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 a         A       1694
    ##  2 a         P       2443
    ##  3 a         R       2728
    ##  4 a         Q       2781
    ##  5 a         C        497
    ##  6 a         E       1521
    ##  7 a         I       2281
    ##  8 a         U        567
    ##  9 a         L       2585
    ## 10 a         K       2505
    ## 11 a         C        267
    ## 12 a         G        653
    ## 13 a         P        997
    ## 14 a         F       1803
    ## 15 a         C       2106
    ## 16 a         F        891
    ## 17 a         Y       2530
    ## 18 a         X       2031
    ## 19 a         M       1986
    ## 20 a         M       2706
    ## 21 a         T       2178
    ## 22 a         N       1733
    ## 23 a         E       2637
    ## 24 a         O       2824
    ## 25 a         A       2662
    ## 26 a         D       1347
    ## 27 a         H       2368
    ## 28 a         E         73
    ## 29 a         R       2154
    ## 30 a         Z        607
    ## # ... with 3,965 more rows
```
