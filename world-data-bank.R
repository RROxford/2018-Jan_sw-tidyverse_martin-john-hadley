library("tidyverse")
library("readxl")

world_data <-
  read_xlsx("data-raw/Data_Extract_From_World_Development_Indicators.xlsx",
            "Data")

colnames(world_data) <- tolower(make.names(colnames(world_data)))

world_data <- world_data %>%
  filter(!is.na(series.name))

world_data <- world_data %>%
  select(-country.code,-series.code) %>%
  gather(year, databank.value, -country.name, 
         -series.name) %>%
  arrange(country.name, year)

world_data %>%
  mutate(year = str_extract(year, "[0-9]+"),
         year = as.integer(year),
         databank.value = as.numeric(databank.value)) %>%
  select(year, databank.value, everything()) %>%
  write_csv("data-raw/tidied-databank-data.csv")


tidied_world_data <- read_csv("data-raw/tidied-databank-data.csv")

tidied_world_data %>%
  filter(country.name == "Canada") %>%
  ggplot(aes(x = year,
             y = databank.value,
             color = series.name)) +
  geom_line() +
  theme(legend.position = "bottom")

gg_my_plot <- tidied_world_data %>%
  filter(series.name == "Pump price for diesel fuel (US$ per liter)") %>%
  group_by(country.name) %>%
  summarise(mean.value = mean(databank.value, 
                              na.rm = TRUE)) %>%
  ggplot(aes(x = country.name,
             y = mean.value)) +
  geom_col() +
  coord_flip()

ggsave("my-beautiful-plot.png",
       plot = gg_my_plot,
       width = 10,
       units = "in",
       dpi = 300)

gg_my_plot










