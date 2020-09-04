Carregando dplyr
----------------

    library(dplyr)

Criando uma base de dados
-------------------------
```r
    dados <- tibble(
      candidato = sample(letters, 100, replace = T),
      cidade    = sample(LETTERS, 100, replace = T),
      valor     = sample(1:3000,  100, replace = T)
    )

    dados

    ## # A tibble: 100 x 3
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 l         K        870
    ##  2 w         R       2396
    ##  3 m         B       1283
    ##  4 i         W       1114
    ##  5 p         O        235
    ##  6 u         U       1129
    ##  7 e         T       2534
    ##  8 q         H         51
    ##  9 c         Q       1796
    ## 10 j         K       2416
    ## # ... with 90 more rows
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
    ##    candidato valor
    ##    <chr>     <int>
    ##  1 c         11433
    ##  2 z          9971
    ##  3 k          9014
    ##  4 i          8817
    ##  5 w          8633
    ##  6 e          8153
    ##  7 b          8066
    ##  8 d          7955
    ##  9 l          7299
    ## 10 s          7229
```
Selecionando a cidade com mais valor dos top 10 candidatos
----------------------------------------------------------
```r
    topCidadePorCandidato <- 
      dados %>% 
      filter(candidato %in% top10candidatoPorValor$candidato) %>% 
      group_by(candidato) %>% 
      filter(valor == max(valor)) %>% 
      arrange(desc(valor))

    topCidadePorCandidato

    ## # A tibble: 10 x 3
    ## # Groups:   candidato [10]
    ##    candidato cidade valor
    ##    <chr>     <chr>  <int>
    ##  1 b         D       3000
    ##  2 e         K       2989
    ##  3 i         K       2981
    ##  4 l         I       2949
    ##  5 z         P       2945
    ##  6 k         Q       2938
    ##  7 d         W       2848
    ##  8 s         R       2777
    ##  9 w         Z       2751
    ## 10 c         B       2468
```
