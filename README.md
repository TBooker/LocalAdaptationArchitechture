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

Then run the simulations on your favourite server...

Fill in details here from ComputeCanada...

## Run GWAS analysis on simulated data...

First thing to do is to extract a sample of individuals out from the simulated populations...

```{sh}

# make a directory to store the results for each simulation...

parallel "python ../../../bin/sampleFromPopulation.py --tree ../../StochasticMapSLiMulations/{}_1_15.trees -i 1000 -o rep_{}/{}_1000inds" ::: $(seq 1 200)


```




comedy - tragedy = time
