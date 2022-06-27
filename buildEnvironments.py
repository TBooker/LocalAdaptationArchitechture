
from libpysal.weights import lat2W
from esda.moran import Moran
from nlmpy import nlmpy
import numpy as np
import matplotlib.pyplot as plt

autocorrelationParameters = np.array([i for i in range(-200,200,2)])/60

summary_output = open("map_summary.txt", "w")

for a in range(len(autocorrelationParameters)):

    autocorrelationParameter = autocorrelationParameters[a]

    nlm = nlmpy.mpd(nRow=14,
                    nCol=14,
                    h=autocorrelationParameters[a])
    mean_val = nlm.flatten().mean()

    while mean_val > 0.55 or mean_val < 0.45:
        nlm = nlmpy.mpd(nRow=14,
                        nCol=14,
                        h=autocorrelationParameters[a])
        mean_val = nlm.flatten().mean()

# Create the matrix of weights
    w = lat2W(nlm.shape[0], nlm.shape[1])

 # Crate the pysal Moran object
    mi = Moran(nlm, w)

# Calculate Moran's I
    moran_I = mi.I


    map_summary_stats = [str(a+1), str(autocorrelationParameter), str(moran_I)]
    summary_output.write( "\t".join(map_summary_stats) + "\n" )

    map_output = open( "my_maps/" + str(a+1)+"_map.txt", "w")
    for m in (nlm.flatten()-nlm.flatten().mean())/nlm.flatten().std():
        map_output.write( str(m) + "\n" )
    map_output.close()

summary_output.close()
