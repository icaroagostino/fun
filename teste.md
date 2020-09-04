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
    ##  1 k         E       2755
    ##  2 y         J         16
    ##  3 s         S        132
    ##  4 s         T       2790
    ##  5 r         E         94
    ##  6 g         K       2695
    ##  7 w         Y       1810
    ##  8 o         M       2594
    ##  9 s         Z       1868
    ## 10 z         K       2805
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
    ##  1 a         635160
    ##  2 t         633083
    ##  3 e         625680
    ##  4 x         613914
    ##  5 u         609915
    ##  6 v         598981
    ##  7 h         593082
    ##  8 r         586554
    ##  9 d         586373
    ## 10 i         578126
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

    topCidadePorCandidato

    ## # A tibble: 4,003 x 3
    ## # Groups:   candidato [10]
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 a         C       2221
    ##  2 a         W        125
    ##  3 a         M        383
    ##  4 a         O       1015
    ##  5 a         O       2896
    ##  6 a         M       2555
    ##  7 a         D        464
    ##  8 a         J       2751
    ##  9 a         V       2365
    ## 10 a         V       2353
    ## # ... with 3,993 more rows
```
