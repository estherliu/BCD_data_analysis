% origin_data{ sender index, receiver index, scan index }
origin_data = cell(16,16,4);
filtered_data = cell(16,16,4);
scan_names = ["Baseline1", "Baseline2", "Tumor1", "Tumor2"];
amplitude = cell(240,4);
f_sample = 160e9;
f_bandpass = [1.7e9 4e9];

%load files
scan_counter = 1;
for scan_name = scan_names
    dataFiles = dir(strcat(scan_name,'/*.txt'));
    pair_counter = 1;
    for i = 1:16
        for j = 1:16
            if i~=j
                filename = strcat("sig_A",int2str(i),"_A",int2str(j), "_hw16.txt");
                filelocation = fullfile(scan_name, filename);
                filecontent = importdata(filelocation);
                origin_data{i,j,scan_counter} = filecontent;
                curr_signal = filecontent(:,1);
                filtered_data{i,j,scan_counter} = bandpass(curr_signal(:), f_bandpass, f_sample);
                amplitude{pair_counter,scan_counter} = max(curr_signal);
                pair_counter = pair_counter + 1;
            end
        end
    end
    scan_counter = scan_counter + 1;
end


corrdata = cell(240,7);
pair_counter = 1;
scan_sum = zeros(6,1);
for i = 1:16
    for j = 1:16
        if i~=j
            pairname = strcat("A",int2str(i),"_A",int2str(j));
            corrdata{pair_counter,1}=pairname;
            scans_counter = 2;
            for scan1 = 1:4
                for scan2 = scan1+1:4
                    x1 = origin_data(i,j,scan1);
                    x2 = origin_data(i,j,scan2);
                    y1 = x1{1,1}(:,1);
                    y2 = x2{1,1}(:,1);
                    [c,lags] = xcorr(y1,y2,30,'normalized');
                    [M,I] = max(c);                    
                    corrdata{pair_counter,scans_counter}=lags(I);
                    scan_sum(scans_counter-1) = scan_sum(scans_counter-1) + power(lags(I),2);
                    scans_counter = scans_counter + 1;
                end
            end
            pair_counter = pair_counter + 1;
        end
    end
end

table = [corrdata, amplitude];
sortedtable = sortrows(table,8,'descend');


