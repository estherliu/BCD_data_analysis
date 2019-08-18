# BCD_data_analysis

#Each **Experiment_xx** folders should be filled with 4 data folders **"Baseline1", "Baseline2", "Tumor1", "Tumor2"**, each has 240 data files named **"sig_Ax_Ax_hw16.txt"**. 

Running **timeshift_values_by_xcorr.m** generates a file showing the estimated time shift values for every antenna pairs and every scan pairs, sorted by signal amplitude.

Running **energy_difference_after_timeshift_by_xcorr.m** generates a file showing that, for each scan pairs, the sum of energy differences for all antenna pairs.

In each **Experiment_xx** folders, first run **load_file.m**, then plot the signal of an antenna pair by running *plot_signal(tx,rx,raw_data,filtered_data,removed_data)*, where *tx* and *rx* are integers indicate the number of the antenna pair, *raw_data, filtered_data* and *removed_data* are constant names.
