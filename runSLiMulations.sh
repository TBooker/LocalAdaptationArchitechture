#!/bin/bash
#SBATCH --array=1-180
#SBATCH --job-name=TomSlim
#SBATCH --time=20:00:00
#SBATCH --mem=10000
#SBATCH --output=localAdap_landscape.out
#SBATCH --error=localAdap_landscape.err



rep=$(expr $SLURM_ARRAY_TASK_ID + 1)

#  An awk 1-liner to grab rows from a set of config files
line=$(awk -v r=$rep 'NR==r {print; exit}' ~/projects/def-whitlock/booker/LocalAdaptationArchitechture/SlimConfigs/slim_config_sets.txt )

read -r ID REP  MAP1  MAP2  NE  SIGA  VS MIG <<< "$line"

/home/booker/bin/build/slim -d REP=${ID} -d map_1=${MAP1} -d map_2=${MAP2} -d N=${NE} -d sig_a=${SIGA} -d MIG=${MIG} -d Vs=${VS}  /home/booker/projects/def-whitlock/booker/LocalAdaptationArchitechture/SlimConfigs/stabilisingSelection.2DsteppingStone.slim



