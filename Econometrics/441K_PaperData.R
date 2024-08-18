library("tidyverse")
library(readr)

data <- read_csv("Data/short_paper_data.csv")
hhi <- read_csv("Data/hhi.csv")
unemployment <- read_csv("Data/unemployment.csv")
poverty <- read_csv("Data/PovertyReport.csv")
premium <- read_csv("Data/premium.csv")
race <- read_csv("Data/race.csv", na = "N/A")
rpp <- read_csv("Data/rpp.csv")
patient <- read_csv("Data/patient.csv")

premium|>
  ggplot(aes(x = TotalPremium)) +
  geom_histogram()

race2 <- race|>
  mutate(AI = ifelse(is.na(`American Indian/Alaska Native`), 0, `American Indian/Alaska Native`))|>
  mutate(NH = ifelse(is.na(`Native Hawaiian/Other Pacific Islander`), 0, `Native Hawaiian/Other Pacific Islander`))|>
  mutate(Other = AI + NH + `Multiple Races`)
# joins

PaperData <- data|>
  left_join(hhi, by = "State")|>
  left_join(patient, by = "State")|>
  left_join(poverty, by = "State")|>
  left_join(premium, by = "State")|>
  left_join(unemployment, by = "State")|>
  left_join(rpp, by = "State")|>
  left_join(race2, by = "State")

write.csv(PaperData, 
          "PaperData.csv", row.names=FALSE)


# TA suggested adding income as another control variable
# I figured rpp (regional price parity) covers it but who knows?
Data <- read_csv("Data/441KPaperData.csv")
income <- read_csv("Data/medianfamincome.csv")

PaperData <- Data|>
  left_join(income, by = "State")
write.csv(PaperData, 
          "PaperData.csv", row.names=FALSE)

