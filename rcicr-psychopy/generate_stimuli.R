
# Install reverse correlation toolbox
install.packages("rcicr")

# Load reverse correlation toolbox
library(rcicr)

# Set base face
base = list('male'='mnes.jpg')

# Generate and save stimuli
generateStimuli2IFC(base_face_files = base, n_trials=20, stimulus_path = "./stimuli", label='preconf', nscales=5, noise_type='gabor', sigma=25)
