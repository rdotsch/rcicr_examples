
# Load reverse correlation toolbox
library(rcicr)
library(stringr)

# Load data
rcdata <- read.csv('rcic.csv')

# Extract stimulus number based on trial number
rcdata$stim <- rcdata$trial + 1

# Extract ori/inv from selectedstim
rcdata$oriinv <- str_match(rcdata$selectedstim, "_([invori]+).")[,2]


# Recode left/right selection to weights in CI
rcdata$response[rcdata$oriinv == 'ori'] <- 1
rcdata$response[rcdata$oriinv == 'inv'] <- -1

# Generate CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', 'stimuli/preconf_seed_1_time_Apr_05_2016_12_35.Rdata', scaling='matched')

# Generate anti-CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', 'stimuli/preconf_seed_1_time_Apr_05_2016_12_35.Rdata', scaling='matched', antiCI=T)
