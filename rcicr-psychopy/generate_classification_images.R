
# Load reverse correlation toolbox
library(rcicr)
library(stringr)

# Load data
rcdata <- read.csv('rcic.csv')

# Extract the stimulus number from the file name, e.g. preconf_male_1_00012_ori.png
# is stimulus 12. Reading it from the name, not the trial counter, keeps the
# two matched however the task ordered the trials.
rcdata$stim <- as.numeric(str_match(rcdata$selectedstim, "_([0-9]+)_(ori|inv)\\.")[,2])

# Extract ori/inv from selectedstim
rcdata$oriinv <- str_match(rcdata$selectedstim, "_([invori]+).")[,2]


# Recode left/right selection to weights in CI
rcdata$response[rcdata$oriinv == 'ori'] <- 1
rcdata$response[rcdata$oriinv == 'inv'] <- -1

# Locate the .Rdata file generate_stimuli.R wrote. Its name carries the
# timestamp it was generated at, so it can't be hardcoded here. Error on more
# than one match rather than silently picking the lexicographically-first --
# stimuli/ ends up with two if generate_stimuli.R is ever re-run (a different
# seed, say) without clearing the old file first, and guessing could pair
# these responses with the wrong stimulus set.
rdata_files <- list.files("stimuli", pattern = "\\.Rdata$", full.names = TRUE)
if (length(rdata_files) == 0) {
  stop("No .Rdata file found in stimuli/ -- run generate_stimuli.R first.")
} else if (length(rdata_files) > 1) {
  stop("Multiple .Rdata files found in stimuli/: ", paste(rdata_files, collapse = ", "),
       ". Delete the ones that don't belong, or set rdata_file to the right one directly.")
}
rdata_file <- rdata_files[1]

# Generate CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', rdata_file, scaling='matched', targetpath = 'cis')

# Generate anti-CI
ci <- generateCI2IFC(rcdata$stim, rcdata$response, 'male', rdata_file, scaling='matched', antiCI=T, targetpath = 'cis')
