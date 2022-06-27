The following commands will grab the columns of a config file, using the SLURM_ARRAY_ID to index individual SLiMulations

```


rep=$(expr $SLURM_ARRAY_ID + 1)

#  An awk 1-liner to grab rows from a set of config files

line=$(awk -v r=$rep 'NR==r {print; exit}' configs )

read -r REP  MAP1  MAP2  NE  SIGA  VS MIG <<< "$line"


```

## Making environments for SLiMulations

Running the following script generates a set of environments for running SLiM simulations.

```
python buildEnvironments.py
```
