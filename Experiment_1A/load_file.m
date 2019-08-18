
raw_data = cell(16,16,4);
filtered_data = cell(16,16,4);
removed_data = cell(16,16,4);
amplitude = cell(16,16,4);
scan_names = ["Baseline1", "Baseline2", "Tumor1", "Tumor2"];
f_sample = 160e9;
f_bandpass = [1.7e9 4e9];
%load files
scan_counter = 1;
for scan_name = scan_names
    for i = 1:16
        for j = 1:16
            if i~=j
                filename = strcat("sig_A",int2str(i),"_A",int2str(j), "_hw16.txt");
                filelocation = fullfile(scan_name, filename);
                filecontent = importdata(filelocation);
                %store raw data 
                raw_data{i,j,scan_counter} = filecontent;                
                curr_signal = filecontent(:,1);
                %store filtered data
                filtered_signal = bandpass(curr_signal(:), f_bandpass, f_sample);
                filtered_data{i,j,scan_counter} = filtered_signal;
                %store removed signal
                removed_signal = curr_signal - filtered_signal;
                removed_data{i,j,scan_counter} = removed_signal;
                %find amplitude
                amplitude{i,j,scan_counter} = max(curr_signal);
            end
        end
    end
    scan_counter = scan_counter + 1;
end

