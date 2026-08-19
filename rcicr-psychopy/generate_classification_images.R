
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

# Locate the .Rdata file generate_stimuli.R wrote. Its name carries the
# timestamp it was generated at, so it can't be hardcoded here.
rdata_file <- list.files("stimuli", pattern = "\\.Rdata$", full.names = TRUE)[1]
if (is.na(rdata_file)) {
  stop("No .Rdata file found in stimuli/ -- run generate_stimuli.R first.")
}

# Generate CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', rdata_file, scaling='matched', targetpath = 'cis')

# Generate anti-CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', rdata_file, scaling='matched', antiCI=T, targetpath = 'cis')
