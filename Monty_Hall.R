library(ggplot2)

# Demonstracao do Problema de Monty Hall

n <- 10000 # Numero de repeticoes
vitorias <- c() # Vetor onde serao gravadas as vitorias
portas <- c(1:3) # Vetor de portas

###################################
# Estrategia 1 - Nao muda a porta #
###################################

for (i in 1:n){
  
  porta_premio <- sample(x = portas, size = 1) # porta com premio
  escolha <- sample(x = portas, size = 1) # escolha do jogador
  
  # Se a escolha for igual a porta premiada vence [1]
  if (porta_premio == escolha){
    
    vitorias <- c(vitorias, 1)
    
  # Se a escolha for diferente da porta premiada perde [0]
  } else {
    
    vitorias <- c(vitorias, 0)
    
  }
}

# Computa resultados
data <-
  data.frame(rodada = c(1:n),
             perc.ganha = cumsum(vitorias)/c(1:n))
  
# Plot
resultados_estrategia1 <- 
  ggplot(data, aes(x = rodada, y = perc.ganha)) +
  geom_line() +
  geom_hline(yintercept=1/3,
             color = "red")

resultados_estrategia1

###############################
# Estrategia 2 - Muda a porta #
###############################

vitorias <- c() # Vetor onde serao gravadas as vitorias

for (i in 1:n){
  
  porta_premio <- sample(x = portas, size = 1) # porta com premio
  escolha1 <- sample(x = portas, size = 1) # primeira escolha do jogador
  
  x <- portas[-c(porta_premio, escolha1)] # variavel auxliar
  
  porta_eliminada <- if(length(x) > 1) sample(x, size = 1) else x # elimina
  
  escolha2 <- portas[-c(escolha1,porta_eliminada)] # jogador muda de porta
  
  # Se a escolha 2 for igual a porta premiada vence [1]
  if (porta_premio == escolha2){
    
    vitorias <- c(vitorias, 1)
    
  # Se a escolha 2 for diferente da porta premiada perde [0]
  } else {
    
    vitorias <- c(vitorias, 0)
    
  }
  
}

# Computa resultados
data <-
  data.frame(rodada = c(1:n),
             perc.ganha = cumsum(vitorias)/c(1:n))

# Plot
resultados_estrategia2 <-
  ggplot(data, aes(x = rodada, y = perc.ganha)) +
  geom_line() +
  geom_hline(yintercept=2/3,
             color = "red")

resultados_estrategia2
