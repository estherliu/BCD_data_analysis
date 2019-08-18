
raw_data = cell(16,16,4);
scan_names = ["Baseline1", "Baseline2", "Tumor1", "Tumor2"];

%load files
scan_counter = 1;
for scan_name = scan_names
    for i = 1:16
        for j = 1:16
            if i~=j
                filename = strcat("sig_A",int2str(i),"_A",int2str(j), "_hw16.txt");
                filelocation = fullfile(scan_name, filename);
                raw_data{i,j,scan_counter} = importdata(filelocation);
            end
        end
    end
    scan_counter = scan_counter + 1;
end


%shift and calculate energy difference
shiftval = zeros(16,16,6);
scan_sum = zeros(6,1);
result = zeros(240,6);
pair_counter = 1;
for i = 1:16
    for j = 1:16      
        if i~=j
            scans_counter = 1;
            for scan1 = 1:4
                for scan2 = scan1+1:4
                    sig1 = raw_data{i,j,scan1}(:,1);
                    sig2 = raw_data{i,j,scan2}(:,1);
                    [c,lags] = xcorr(sig1,sig2,30,'normalized');
                    [M,I] = max(c);
                    %distance to shift
                    distance = lags(I);
                    shiftval(i,j,scans_counter)=distance;
                    %do shifting
                    shift_sig2 = circshift(sig2, distance);
                    windowed_sig1 = sig1(100:4000);
                    windowed_sig2 = shift_sig2(100:4000);
                    %calculate energy difference between 2 signals
                    sig_diff = energy_difference(windowed_sig1,windowed_sig2);
                    result(pair_counter,scans_counter) = sig_diff;
                    scan_sum(scans_counter) = scan_sum(scans_counter) + abs(lags(I));
                    scans_counter = scans_counter + 1;
                end
            end
            pair_counter = pair_counter + 1;
        end        
    end
end

energy_diff_table = cell(6);
for scan = 1:6
    energy_diff_table{scan} = add_up(result(:,scan));
end

%helper functions 
function s = add_up(data)
sum = 0;
for i = 1:240
    sum = sum + data(i);
end
s = sum;
end

function d = energy_difference(sig1, sig2)
[sample_size, ~] = size(sig1);
sum = 0;
for k = 1:sample_size
    sum = sum + power(sig1(k)-sig2(k),2);
end
d = sum;
end

