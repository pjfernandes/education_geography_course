library(tidyverse)

setwd("/home/uff/Área de Trabalho/arquivos/eja_variation")
dir()
unzip("microdados_ed_basica_20.zip")
dir()

df_2009 <- read_csv2("microdados_ed_basica_2009.csv")
df_2022 <- read_csv2("microdados_ed_basica_2022.csv")

##### EJA ESCOLAS ESTADUAIS E PRIVADAS RIO
eja_rio_2009_estaduais <- df_2009 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 | TP_DEPENDENCIA == 3, IN_EJA==1, TP_SITUACAO_FUNCIONAMENTO==1)

eja_rio_2022_estaduais <- df_2022 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 | TP_DEPENDENCIA == 3, IN_EJA==1, TP_SITUACAO_FUNCIONAMENTO==1)

eja_rio_2009_privadas <- df_2009 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4, IN_EJA == 1, TP_SITUACAO_FUNCIONAMENTO==1)

eja_rio_2022_privadas <- df_2022 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4, IN_EJA == 1, TP_SITUACAO_FUNCIONAMENTO==1)

###################ANALISE NUMERO DE ESCOLAS ESTADUAIS E PRIVADAS NO RIO - ENSINO MEDIO
rio_2009_publicas <- df_2009 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 , TP_SITUACAO_FUNCIONAMENTO==1)

rio_2022_publicas <- df_2022 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 , TP_SITUACAO_FUNCIONAMENTO==1)

rio_2009_privadas <- df_2009 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4 , TP_SITUACAO_FUNCIONAMENTO==1, IN_MED == 1)

rio_2022_privadas <- df_2022 %>% 
  filter(
    grepl('Rio de Janeiro', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4 , TP_SITUACAO_FUNCIONAMENTO==1, IN_MED == 1)

##### EJA ESCOLAS ESTADUAIS Niterói
#eja_nit_2009 <- df_2009 %>% 
#  filter(
#    grepl('Niter', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 | TP_DEPENDENCIA == 3, IN_EJA==1, TP_SITUACAO_FUNCIONAMENTO==1)

#eja_nit_2022 <- df_2022 %>% 
#  filter(
#    grepl('Niter', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 2 | TP_DEPENDENCIA == 3, IN_EJA==1, TP_SITUACAO_FUNCIONAMENTO==1)

#eja_nit_2009_privadas <- df_2009 %>% 
#  filter(
#    grepl('Niter', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4, IN_EJA_MED==1, TP_SITUACAO_FUNCIONAMENTO==1)

#eja_nit_2022_privadas <- df_2022 %>% 
#  filter(
#    grepl('Niter', NO_MUNICIPIO), SG_UF == "RJ", TP_DEPENDENCIA == 4, IN_EJA_MED==1, TP_SITUACAO_FUNCIONAMENTO==1)

############################### PEGANDO COORDENADAS LAT/LONG DAS ESCOLAS A PARTIR DO GOOGLE MAPS API
#install.packages("ggmap")
library(ggmap)

register_google(key="")

end_eja_rio_2009_estaduais <- paste(eja_rio_2009_estaduais$DS_ENDERECO, as.numeric(eja_rio_2009_estaduais$NU_ENDERECO), "Rio de Janeiro")
end_eja_rio_2022_estaduais <- paste(eja_rio_2022_estaduais$DS_ENDERECO, as.numeric(eja_rio_2022_estaduais$NU_ENDERECO), "Rio de Janeiro")
end_eja_rio_2009_privadas <- paste(eja_rio_2009_privadas$DS_ENDERECO, as.numeric(eja_rio_2009_privadas$NU_ENDERECO), "Rio de Janeiro")
end_eja_rio_2022_privadas <- paste(eja_rio_2022_privadas$DS_ENDERECO, as.numeric(eja_rio_2022_privadas$NU_ENDERECO), "Rio de Janeiro")

end_rio_2009_publicas <- paste(rio_2009_publicas$DS_ENDERECO, as.numeric(rio_2009_publicas$NU_ENDERECO), "Rio de Janeiro")
end_rio_2022_publicas <- paste(rio_2022_publicas$DS_ENDERECO, as.numeric(rio_2022_publicas$NU_ENDERECO), "Rio de Janeiro")
end_rio_2009_privadas <- paste(rio_2009_privadas$DS_ENDERECO, as.numeric(rio_2009_privadas$NU_ENDERECO), "Rio de Janeiro")
end_rio_2022_privadas <- paste(rio_2022_privadas$DS_ENDERECO, as.numeric(rio_2022_privadas$NU_ENDERECO), "Rio de Janeiro")

end_rio_2022_privadas <- end_rio_2022_privadas[c(-163, -400, -489)]
################################################################################
result_end_eja_rio_2009_estaduais <- geocode(end_eja_rio_2009_estaduais)
result_end_eja_rio_2022_estaduais <- geocode(end_eja_rio_2022_estaduais)
result_end_eja_rio_2009_privadas <- geocode(end_eja_rio_2009_privadas)
result_end_eja_rio_2022_privadas <- geocode(end_eja_rio_2022_privadas)

result_end_rio_2009_publicas <- geocode(end_rio_2009_publicas)
result_end_rio_2022_publicas <- geocode(end_rio_2022_publicas)
result_end_rio_2009_privadas <- geocode(end_rio_2009_privadas)
result_end_rio_2022_privadas <- geocode(end_rio_2022_privadas)

result_end_eja_rio_2009_estaduais_2 <- result_end_eja_rio_2009_estaduais[complete.cases(result_end_eja_rio_2009_estaduais),]
result_end_eja_rio_2022_estaduais_2 <- result_end_eja_rio_2022_estaduais[complete.cases(result_end_eja_rio_2022_estaduais),]
result_end_eja_rio_2009_privadas_2 <- result_end_eja_rio_2009_privadas[complete.cases(result_end_eja_rio_2009_privadas),]
result_end_eja_rio_2022_privadas_2 <- result_end_eja_rio_2022_privadas[complete.cases(result_end_eja_rio_2022_privadas),]

result_end_rio_2009_publicas_2 <- result_end_rio_2009_publicas[complete.cases(result_end_rio_2009_publicas),]
result_end_rio_2022_publicas_2 <- result_end_rio_2022_publicas[complete.cases(result_end_rio_2022_publicas),]
result_end_rio_2009_privadas_2 <- result_end_rio_2009_privadas[complete.cases(result_end_rio_2009_privadas),]
result_end_rio_2022_privadas_2 <- result_end_rio_2022_privadas[complete.cases(result_end_rio_2022_privadas),]

########### EXPORTANDO SHAPEFILES
library(sp)
library(raster)

coordinates(result_end_eja_rio_2009_estaduais_2) <- c("lon", "lat")
coordinates(result_end_eja_rio_2022_estaduais_2) <- c("lon", "lat")
coordinates(result_end_eja_rio_2009_privadas_2) <- c("lon", "lat")
coordinates(result_end_eja_rio_2022_privadas_2) <- c("lon", "lat")
coordinates(result_end_rio_2009_publicas_2) <- c("lon", "lat")
coordinates(result_end_rio_2022_publicas_2) <- c("lon", "lat")
coordinates(result_end_rio_2009_privadas_2) <- c("lon", "lat")
coordinates(result_end_rio_2022_privadas_2) <- c("lon", "lat")

shapefile(result_end_eja_rio_2009_estaduais_2, "shape/result_end_eja_rio_2009_estaduais.shp", overwrite=T)
shapefile(result_end_eja_rio_2022_estaduais_2, "shape/result_end_eja_rio_2022_estaduais.shp", overwrite=T)
shapefile(result_end_eja_rio_2009_privadas_2, "shape/result_end_eja_rio_2009_privadas.shp", overwrite=T)
shapefile(result_end_eja_rio_2022_privadas_2, "shape/result_end_eja_rio_2022_privadas.shp", overwrite=T)
shapefile(result_end_rio_2009_publicas_2, "shape/result_end_rio_2009_publicas.shp", overwrite=T)
shapefile(result_end_rio_2022_publicas_2, "shape/result_end_rio_2022_publicas.shp", overwrite=T)
shapefile(result_end_rio_2009_privadas_2, "shape/result_end_rio_2009_privadas.shp", overwrite=T)
shapefile(result_end_rio_2022_privadas_2, "shape/result_end_rio_2022_privadas.shp", overwrite=T)
#################################################################
library(tmap)

#rj <- shapefile("shape/RJ_Municipios_2022.shp")

estaduais_2009 <- shapefile("shape/result_end_rio_2009_publicas.shp")
estaduais_2022 <- shapefile("shape/result_end_rio_2022_publicas.shp")
privadas_2009 <- shapefile("shape/result_end_rio_2009_privadas.shp")
privadas_2022 <- shapefile("shape/result_end_rio_2022_privadas.shp")

eja_estaduais_2009 <- shapefile("shape/result_end_eja_rio_2009_estaduais.shp")
eja_estaduais_2022 <- shapefile("shape/result_end_eja_rio_2022_estaduais.shp")
eja_privadas_2009 <- shapefile("shape/result_end_eja_rio_2009_privadas.shp")
eja_privadas_2022 <- shapefile("shape/result_end_eja_rio_2022_privadas.shp")

tmap_mode("view")

#COMPARAÇÃO ESCOLAS PARTICULARES x ESTADUAIS (2009 - 2022)
tm_shape(estaduais_2009, id="2009") + tm_dots("ID", palette="Reds") + #estaduais_2009
  tm_shape(estaduais_2022) + tm_dots("ID", palette="Greens") + #estaduais_2022
  tm_shape(privadas_2009) + tm_dots("ID", palette="Blues") + #privadas_2009
  tm_shape(privadas_2022) + tm_dots("ID", palette="Oranges") #privadas_2022

#COMPARAÇÃO EJA (ESTADUAIS x PARTICULARES) (2009 - 2022)
tm_shape(eja_estaduais_2009, id="2009") + tm_dots("ID", palette="Reds") + #eja_estaduais_2009
  tm_shape(eja_estaduais_2009) + tm_dots("ID", palette="Greens") + #eja_estaduais_2009
  tm_shape(eja_privadas_2009) + tm_dots("ID", palette="Blues") + #eja_privadas_2009
  tm_shape(eja_privadas_2022) + tm_dots("ID", palette="Oranges") #eja_privadas_2022
