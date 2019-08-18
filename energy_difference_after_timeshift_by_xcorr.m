subfolders = dir("Experiment*");
foldernames = {subfolders([subfolders.isdir]).name};
for k = 1:numel(foldernames) 
  copyfile("xccor_and_timeshift_analysis.m", foldernames{k});
end

scan_names = ["Baseline1", "Baseline2", "Tumor1", "Tumor2"];
col_titles = cell(6,1);
s_counter = 1;
for m = 1:4
    for n = m+1:4
        col_name = strcat(scan_names(m),"_",scan_names(n));
        col_titles{s_counter} = col_name;
        s_counter = s_counter + 1;
    end
end


warning( 'off', 'MATLAB:xlswrite:AddSheet' ) ;
for k = 1:numel(foldernames) 
  run(fullfile(foldernames{k},'analysis6.m'));  
  writecell(col_titles,"shifted_energy_diff.xlsx",'Sheet',foldernames{k},'Range','A1');
  writecell(energy_diff_table,"shifted_energy_diff.xlsx",'Sheet',foldernames{k},'Range','B1');
end
