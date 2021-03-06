function[] = BBAwriter(BBA, outputFile)

fid = fopen(outputFile,'w+');

fprintf(fid,'Name =\n\t %s\n\n',BBA.name);

fprintf(fid,'ModelFile=\n\t %s\n\n',BBA.modelFile);

fprintf(fid,'K=\n\t %s\n\n',BBA.K.char);

fprintf(fid,'BBA = {\n');

for k=1:size(BBA.assignments,1)
    %skip assignment to null set if exist (it is actually the conflict!)
    if str2num(BBA.assignments{k,1})~=0
       fprintf(fid,'\t\t<assignment>\n');
           fprintf(fid,'\t\t\t<mass>%s</mass>\n', BBA.assignments{k,2}.char);
           tmp = BBA.assignments{k,1};
           idxs = find(str2num(tmp(:))); %#ok<*ST2NM> %skip the first character which is usually a letter
           for i=1:length(idxs)
               fprintf(fid,'\t\t\t<set>%s</set>\n', BBA.model.EventList(idxs(i)).EventName);
           end
        fprintf(fid,'\t\t</assignment>\n\n');
    end
end
fprintf(fid,'}\n');
fclose(fid);
end