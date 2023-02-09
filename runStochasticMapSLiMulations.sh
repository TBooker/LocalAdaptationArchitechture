#!/bin/bash
#SBATCH --array=1-1200
#SBATCH --job-name=TomSlim
#SBATCH --time=12:00:00
#SBATCH --mem=5000
#SBATCH --output=localAdap_landscape.out
#SBATCH --error=localAdap_landscape.err



rep=$(expr $SLURM_ARRAY_TASK_ID + 1)

#  An awk 1-liner to grab rows from a set of config files
line=$(awk -v r=$rep 'NR==r {print; exit}' ~/projects/def-whitlock/booker/LocalAdaptationArchitechture/SlimConfigs/stochastic_slim_config_sets.txt )

read -r ID REP  MAP  NE  SIGA  VS MIG <<< "$line"

/home/booker/bin/build/slim -d "dir='/home/booker/projects/def-whitlock/booker/LocalAdaptationArchitechture/StochasticMapSLiMulations/'" -d REP=${ID} -d MAP=${MAP} -d N=${NE} -d sig_a=${SIGA} -d MIG=${MIG} -d Vs=${VS}  /home/booker/projects/def-whitlock/booker/LocalAdaptationArchitechture/SlimConfigs/stochasticMaps.stabilisingSelection.2DsteppingStone.slim

#cp  ${SLURM_TMPDIR}/${REP}_* ${SLURM_SUBMIT_DIR}/

