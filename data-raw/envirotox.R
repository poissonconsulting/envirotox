# Modified from <https://github.com/miinay/SSD_distribution_comparison/blob/main/Rcode.R>

############################################################
###Procedure
#0. Package 
#1. Prepare the example data set
#2. Select and process the toxicity data
#3. Select chemicals to be analyzed
############################################################

graphics.off()
rm(list = ls())

#### 0. Package ----
library(openxlsx)
library(dplyr)
library(tidyr)
library(EnvStats)
library(mousetrap)

## file <- "example.xlsx" This is the example data.
file <- "envirotox.xlsx"
path <- file.path("data-raw", file)

#### 1. Prepare the example data set ----
# This dataset "example.xlsx" includes 20,000 test records randomly selected from the "EnviroTox" database only for demonstration.
# All the data used in this study was collected from the "EnviroTox" database and please contact the authors if you like to exactly reproduce our results.

#import data
EnviroTox_test <- read.xlsx(path, sheet="test")
EnviroTox_chem <- read.xlsx(path, sheet="substance")
EnviroTox_taxo <- read.xlsx(path, sheet="taxonomy")


#### 2. Select and process the toxicity data ----
EnviroTox_test_selected <- EnviroTox_test %>%
  filter (Test.statistic=="EC50" & Test.type=="A" | Test.statistic=="LC50" & Test.type=="A"  |
            Test.statistic=="NOEC" & Test.type=="C" | Test.statistic=="NOEL" & Test.type=="C") %>% 
  filter (Effect.is.5X.above.water.solubility =="0") %>%
  mutate (original.CAS = EnviroTox_chem[match(.$CAS, EnviroTox_chem$CAS),"original.CAS"] ) %>%
  mutate_at(vars(Effect.value), as.numeric) %>%
  mutate (Effect.value = replace(.$Effect.value, !is.na(.$Effect.value), .$Effect.value * 10^3) ) %>%  # transform unit (mg/L to ug/L)
  mutate (Unit = replace(Unit, Unit=="mg/L","µg/L")) %>%
  mutate (Substance=EnviroTox_chem[match (.$original.CAS, EnviroTox_chem$original.CAS) ,"Chemical.name"]) %>%
  separate (Substance, into=c("Short_name"),sep=";",extra="drop" ) 

## calculate geometric mean and select chemicals analyzed based on the number of species
EnviroTox_test_selected2 <- aggregate(EnviroTox_test_selected$Effect.value,
                                      by=list(original.CAS = EnviroTox_test_selected$original.CAS,
                                              Test.type=EnviroTox_test_selected$Test.type,
                                              Latin.name=EnviroTox_test_selected$Latin.name),
                                      function(x) geoMean(x) ) %>%
  dplyr::rename(Effect.value=x) %>%
  mutate (Trophic.Level = EnviroTox_taxo[match (.$Latin.name, EnviroTox_taxo$Latin.name) ,"Trophic.Level"] ) %>%
  mutate (Substance=EnviroTox_chem[match (.$original.CAS, EnviroTox_chem$original.CAS) ,"Chemical.name"]) %>%
  separate (Substance, into=c("Short_name"),sep=";",extra="drop" )  %>%
  group_by(original.CAS,Test.type) %>% 
  filter(n()>=6) %>%
  filter(var(Effect.value) > 0)


## Organize information of chemicals and the toxicity
EnviroTox_ssd <- aggregate(x=as.numeric(EnviroTox_test_selected2$Effect.value),
                           by=list(original.CAS=EnviroTox_test_selected2$original.CAS, Test.type=EnviroTox_test_selected2$Test.type),
                           FUN=function(x) mean(log10( x ) ) )  %>%
  mutate(sd=aggregate(EnviroTox_test_selected2$Effect.value,
                      by=list(EnviroTox_test_selected2$original.CAS, EnviroTox_test_selected2$Test.type), function(x) sd(log10( x ) ) )[,3]   )   %>%
  dplyr::rename(mean=x) %>%
  mutate(HC5 = qlnorm (0.05, meanlog=log(10^mean), sdlog=log(10^sd) ) ) %>%
  mutate (Substance=EnviroTox_chem[match (.$original.CAS, EnviroTox_chem$original.CAS) ,"Chemical.name"]) %>%
  mutate (No_species = aggregate(EnviroTox_test_selected2$Latin.name,
                                 by=list(EnviroTox_test_selected2$original.CAS,EnviroTox_test_selected2$Test.type), function(x) length(unique(x)) )[,3]) %>%
  mutate (No_trophic=aggregate(EnviroTox_test_selected2$Trophic.Level,
                               by=list(EnviroTox_test_selected2$original.CAS,EnviroTox_test_selected2$Test.type), function(x) length(unique (x)) )[,3]) %>%
  filter(!is.na(sd)) %>%
  mutate(Test.type = replace(Test.type, Test.type=="A", "Acute")) %>%
  mutate(Test.type = replace(Test.type, Test.type=="C", "Chronic"))%>%
  pivot_wider(names_from=Test.type, values_from=c("mean","sd","HC5","No_species","No_trophic")) %>%
  mutate (ConsensusMoA = EnviroTox_chem[match (.$original.CAS, EnviroTox_chem$original.CAS), "Consensus.MOA"] ) %>%
  mutate (ASTER = EnviroTox_chem[match (.$original.CAS, EnviroTox_chem$original.CAS) ,"ASTER"] )


## Calculate bimodality coefficient (BC)

# acute data
BC_A <- EnviroTox_test_selected2 %>%
  filter(Test.type =="A") %>%
  group_by(original.CAS) %>%
  dplyr::summarize(BC = mousetrap::bimodality_coefficient(log10(Effect.value))) %>%
  select(original.CAS, BC)

# chronic data
BC_C <- EnviroTox_test_selected2 %>%
  filter(Test.type =="C") %>%
  group_by(original.CAS) %>%
  dplyr::summarize(BC = mousetrap::bimodality_coefficient(log10(Effect.value))) %>%
  select(original.CAS, BC)

#### 3. Select chemicals to be analyzed ----
## Get the lists of chemicals to be used SSD estimation

EnviroTox_ssd_HH_A <- EnviroTox_ssd %>%
  filter (No_trophic_Acute >= 2  ) %>%
  filter (No_species_Acute >= 6 ) %>%
  left_join(BC_A, by = "original.CAS") %>%
  separate (Substance, into=c("Short_name"), sep=";", extra="drop") %>%
  mutate(Yanagihara24 = No_species_Acute >= 10 & No_trophic_Acute >= 3 & BC <= 0.555,
         Iwasaki25 = No_species_Acute > 50 & No_trophic_Acute >= 3) %>%
  select(original.CAS, Yanagihara24, Iwasaki25)

EnviroTox_ssd_HH_C <- EnviroTox_ssd %>%
  filter (No_trophic_Chronic >= 2  ) %>%
  filter (No_species_Chronic >= 6 ) %>%
  left_join(BC_C, by = "original.CAS") %>%
  separate (Substance, into=c("Short_name"), sep=";", extra="drop")  %>%
  mutate(Yanagihara24 = No_species_Chronic >= 10 & No_trophic_Chronic >= 3, BC <= 0.555) %>%
  select(original.CAS, Yanagihara24)

envirotox_acute <- EnviroTox_test_selected2 %>% 
  filter(Test.type == "A") %>%
  inner_join(EnviroTox_ssd_HH_A, by = "original.CAS") %>%
  mutate(Iwasaki25 = Iwasaki25 & !(Short_name %in% 
  c("Arsenic(III) sulfide", "Cadmium chloride", "Chromium trioxide", "Copper",
    "Cupric oxide", "Lead nitrate", "Mercuric nitrate", "Nickel chloride", 
    "Silver sulfate", "Sodium selenite", "Zinc oxide")))

envirotox_chronic <-  EnviroTox_test_selected2 %>% 
  filter(Test.type == "C") %>%
  inner_join(EnviroTox_ssd_HH_C, by = "original.CAS")

envirotox_acute <- envirotox_acute %>%
  ungroup() %>%
  select(Chemical = Short_name, Conc = Effect.value, Species = Latin.name, Group = Trophic.Level, OriginalCAS = original.CAS, Yanagihara24, Iwasaki25) %>%
  as_tibble() %>%
  filter(!(Chemical == "Acriflavine" & OriginalCAS == 65589700 & !Yanagihara24)) %>%
  filter(!(Chemical == "Imidacloprid" & OriginalCAS == 105827789 & !Yanagihara24))
  
envirotox_chronic <- envirotox_chronic %>%
  ungroup() %>%
  select(Chemical = Short_name, Conc = Effect.value, Species = Latin.name, Group = Trophic.Level, OriginalCAS = original.CAS, Yanagihara24) %>%
  as_tibble() 

envirotox_chemical <- envirotox_acute %>%
  bind_rows(envirotox_chronic) %>%
  distinct(Chemical, OriginalCAS) %>%
  mutate(OriginalCAS = as.integer(OriginalCAS)) %>%
  arrange(Chemical)

envirotox_acute <- envirotox_acute |>
  select(!OriginalCAS) %>%
  arrange(Chemical, Species)

envirotox_chronic <- envirotox_chronic |>
  select(!OriginalCAS) %>%
  arrange(Chemical, Species)

chk::check_key(envirotox_acute, c("Chemical", "Species"))
chk::check_key(envirotox_chronic, c("Chemical", "Species"))
chk::check_key(envirotox_chemical, "Chemical")
chk::check_key(envirotox_chemical, "OriginalCAS")

usethis::use_data(envirotox_acute, overwrite = TRUE)
usethis::use_data(envirotox_chronic, overwrite = TRUE)
usethis::use_data(envirotox_chemical, overwrite = TRUE)
