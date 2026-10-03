
# Install reverse correlation toolbox
install.packages("rcicr")

# Load reverse correlation toolbox
library(rcicr)

# Set base face
base = list('male'='MNES.jpg')

# Generate and save stimuli. Each parallel worker holds its own copy of the
# 512px noise basis (about 250 MB), so on a machine with little memory, pass a
# smaller ncores, e.g. ncores = 2.
generateStimuli2IFC(base_face_files = base, n_trials=20, stimulus_path = "./stimuli", label='preconf', nscales=5, noise_type='gabor', sigma=25)
