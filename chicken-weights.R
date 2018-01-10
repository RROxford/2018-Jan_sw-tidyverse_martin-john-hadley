library("broom")
library("tidyverse")

datasets::chickwts
filter(chickwts, feed == "horsebean")

chickwts %>%
  filter(feed == "horsebean") %>%
  select(weight) %>%
  .[[1]]

chickwts %>%
  filter(feed == "casein") %>%
  select(weight) %>%
  .[[1]]

t.test(
  chickwts %>%
    filter(feed == "horsebean") %>%
    select(weight) %>%
    .[[1]],
  chickwts %>%
    filter(feed == "casein") %>%
    select(weight) %>%
    .[[1]]
) %>%
  tidy()



