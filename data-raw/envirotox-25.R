## The csv files were saved from an xlsx file that was
## downloaded from https://envirotoxdatabase.org/ with the
## search query Chemical Name contains <blank>

library(readr)
library(dplyr)
library(magrittr)
library(chk)

test <- read_csv("data-raw/test.csv")
substance <- read_csv("data-raw/substance.csv")
taxonomy <- read_csv("data-raw/taxonomy.csv")
effect <- read_csv("data-raw/effect.csv")

test %<>%
  filter(Unit == "mg/L") %>%
  filter (`Effect is 5X above water solubility` == 0) %>%
  select(OriginalCAS = `original CAS`, Metric = `Test statistic`, Response = Effect, Type = `Test type`, Species = `Latin name`,  Conc = `Effect value`) %>%
  filter(Type %in% c("A", "C")) %>%
  mutate(Type = if_else(Type == "A", "Acute", "Chronic"))

taxonomy %<>%
  select(Species = `Latin name`, Group = `Trophic Level`, Medium, Class = `Taxonomic class`, Family = `Taxonomic family`) %>%
  filter(!stringr::str_detect(Species, "\\ssp$")) %>%
  filter(Medium %in% c("Freshwater", "Saltwater")) %>%
  mutate(Group = stringr::str_to_sentence(Group),
         Group = stringr::str_replace(Group, "^Amphib$", "Amphibian"),
         Group = stringr::str_replace(Group, "^Invert$", "Invertebrate"))

check_key(taxonomy, "Species")

substance %<>%
  rename(OriginalCAS = `original CAS`)

effect %<>%
  filter(Accepted == "Yes") %>%
  select(Response = Effect, Endpoint)

data <- test %>%
  inner_join(effect, by = "Response") %>%
  semi_join(substance, by = "OriginalCAS") %>%
  select(!Response) %>%
  mutate(Endpoint = stringr::str_to_title(Endpoint))

data %<>%
  mutate(Preferred = case_when(
    Type == "Acute" & Metric %in% c("LC50", "ED50", "EC50" , "LD50",  "IC50",  "LC50*", "LOEC"   , "EC50*",   "ED50", "LC51", "IGC50", "LC60", "IC40", "EC40" , "EC40", "LC40") ~ TRUE,
    Type == "Chronic" & Metric %in% c("NEC (no effect concentration)", "EC10", "LC10", "IC10", "IC07", "EC05") ~ TRUE,
    Type == "Chronic" & Metric %in% c("NOEC", "NOEL", "NOLC", "NOAEC", "EC16", "IC20", "LC20", "EC20") ~ FALSE,
    TRUE ~ NA)) %>%
  filter(!is.na(Preferred))

data %<>%
  group_by(OriginalCAS, Type, Species, Endpoint, Preferred) %>%
  summarise(Conc = exp(mean(log(Conc))), .groups = "drop") %>%
  group_by(OriginalCAS, Type, Species, Endpoint) %>%
  arrange(desc(Preferred)) %>%
  slice(1) %>%
  ungroup() %>%
  group_by(OriginalCAS, Type, Species) %>%
  summarise(Conc = min(Conc), .groups = "drop")

data %<>%
  inner_join(taxonomy, by = "Species")

data %<>%
  mutate(Units = "mg/L"
  ) %>%
  select(Chemical = OriginalCAS, Conc, Species, Type, Medium, everything()) %>%
  mutate(Chemical = as.character(Chemical)) %>%
  group_by(Chemical, Medium, Type) %>%
  filter(n() >= 6) %>%
  filter(length(unique(Class)) >= 4) %>%
  filter(length(unique(Group)) >= 2) %>%
  filter(var(Conc) > 0) %>%
  ungroup() %>%
  arrange(Chemical, Species)

envirotox_25_chronic <- data %>%
  filter(Type == "Chronic")

check_key(envirotox_25_chronic, c("Chemical", "Species"))

usethis::use_data(envirotox_25_chronic, overwrite = TRUE)

envirotox_25_acute <- data %>%
  filter(Type == "Acute")

check_key(envirotox_25_acute, c("Chemical", "Species"))

usethis::use_data(envirotox_25_acute, overwrite = TRUE)
