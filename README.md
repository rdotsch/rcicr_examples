# rcicr_examples
Reverse correlation examples

## rcicr-psychopy

A complete two-image forced-choice (2IFC) task, from stimuli to classification images:

1. `generate_stimuli.R` generates 20 trials of stimuli in `stimuli/` with [rcicr](https://github.com/rdotsch/rcicr), plus the `.Rdata` file that describes them.
2. `rcictask.py` runs the task in [PsychoPy](https://www.psychopy.org/) and writes the choices to `rcic.csv`.
3. `generate_classification_images.R` reads `rcic.csv` and writes the classification image and anti-classification image to `cis/`.

`rcic_simulated.csv` shows what `rcictask.py` writes. It was made by the task's own trial loop, with each click replaced by a seeded coin flip, over stimuli from `generate_stimuli.R`. The choices are random, so the classification image it gives is noise. Rename it to `rcic.csv` to run step 3 without PsychoPy.

## datasets

Data sets from gender reverse correlation tasks, with the stimulus file they were collected with. See `datasets/gender/README.md`.
