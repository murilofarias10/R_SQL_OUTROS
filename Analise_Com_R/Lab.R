#verifica a pasta de trabalho
getwd()

#Intalando os pacotes para manipulação de dados
install.packages("tidyverse")
install.packages("dplyr")
install.packages("readr")

#Intalando os pacotes para ML
install.packages("solitude")

#Intalando os pacotes para visualização de graficos
install.packages("ggplot2")

#Carregando os pacotes na sessao R
library(tidyverse)
library(dplyr)
library(readr)
library(solitude)
library(ggplot2)

#Carregando os dados
dados_historicos <- read_csv("dados_historicos.csv")
view(dados_historicos)

#CRIANDO o modelo de Machine Learning com algoritimo isolationForest NOVO
#Nao supervisionado
#Está dentro do pacote Solitude
?isolationForest
modelo_ml = isolationForest$new()

#treinar o modelo com metodo fit
modelo_ml$fit(dados_historicos)

#Faz as previsoes com o modelo usando os dados historicos
#este codigo a baixo pode sim ser substituido por este:
  #previsoes_historio = modelo_ml$predict(dados_historicos)
previsoes_historio = dados_historicos %>% 
  modelo_ml$predict() %>% 
  arrange(desc(anomaly_score))



#ver no formato de tabela as previsoesXXXX

view(previsoes_historio)

#Verificar como estão os scores de anomalia e gera um grafico
plot(density(previsoes_historio$anomaly_score))


#Quanto maior é um score maior a chance de ser uma anomalia
#definindo uma regra entao >0.62 é anomalia
#funcao which para aplicar um filtro

indice_novo = previsoes_historio[which(previsoes_historio$anomaly_score >0.65)]


#utilizando o filtro novo
#[antes é linha, depois é coluna]
anomalias = dados_historicos[indice_novo$id, ]
normais = dados_historicos[-indice_novo$id, ]

#Construir com ggplot2
colors()
ggplot() +
  geom_point(data = normais,
             mapping = aes(transacao1, transacao2),
             col = "skyblue3",
             alpha = 0.5) +
  geom_point(data = anomalias,
             mapping = aes(transacao1, transacao2),
             col = "red2",
             alpha = 0.8)


#*** este ponto nao vai criar de novo um modelo, esta usando o modelo criado porém em outro arquivo
#mudando para outro arquivo de dados e 
novos_dados <- read.csv("novos_dados.csv")

view(novos_dados)

previsoes_novas = modelo_ml$predict(novos_dados)

indice_novos_Dados = previsoes_novas[which(previsoes_novas$anomaly_score >0.65)]

anomalias_novos = novos_dados[indice_novos_Dados$id, ]
normais_novos = novos_dados[-indice_novos_Dados$id, ]

colors()
ggplot() +
  geom_point(data = normais_novos,
             mapping = aes(transacao1, transacao2),
             col = "skyblue3",
             alpha = 0.5) +
  geom_point(data = anomalias_novos,
             mapping = aes(transacao1, transacao2),
             col = "red2",
             alpha = 0.8)

#arredondando a coluna para 2 casas decimais
previsoes_novas <- previsoes_novas %>%
  mutate(anomaly_score = round(anomaly_score, 2))

#Criando uma nova coluna
#mencionando se é anomalia ou normal
previsoes_novas <- previsoes_novas %>%
  mutate(status = ifelse(anomaly_score >0.62, "anomalia", "normal"))


view(previsoes_novas)

#Renomeando a coluna "anomaly_score"] <- "faixa_anomalia"
colnames(previsoes_novas)[colnames(previsoes_novas) == "anomaly_score"] <- "faixa_anomalia"

view(previsoes_novas)

#Criando o box plot
ggplot(previsoes_novas, aes(x=status, y=faixa_anomalia, fill=status))+
  geom_boxplot()+
  labs(title = "Box Plot de Anomalias e Normais",
       x = "Status",
       y = "Anomalias")+
  theme_minimal()+
  scale_fill_manual(values = c("anomalia" = "red", "normal" = "blue"))+
  theme(legend.position = "none")

#Salva em disco
write.csv(previsoes_novas, "previsoes_novas.csv")


