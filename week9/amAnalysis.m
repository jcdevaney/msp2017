function res=amAnalysis(ss,vv,avmYIN,labs,sr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% res=amAnalysis(ss,vv,avmYIN,labs,sr)
%
% Description: Get pitch data for inputted YIN vals and labels
%
% (c) copyright 2012, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gamma=1000000;
win=floor(.2*sr/32);
dctSize=floor(.25*sr/32);
dctSizeMA=floor(dctSize-win/2);
ap=0.1;

for s = ss
    for v = vv
        for n = 1 : length(labs{s,v})
            res.f0vals{s,v,n}=avmYIN{s,v}.f0(ceil(labs{s,v}(n,1)*sr/32):floor(labs{s,v}(n,2)*sr/32));
            res.apvals{s,v,n}=avmYIN{s,v}.ap(ceil(labs{s,v}(n,1)*sr/32):floor(labs{s,v}(n,2)*sr/32));
            f0valstmp=res.f0vals{s,v,n}(res.apvals{s,v,n}<ap);
            res.regmean{s,v,n}=nanmean(f0valstmp);
            res.regstd{s,v,n}=nanstd(f0valstmp);
            if length(f0valstmp) > 9
                sorted = sort(f0valstmp);
                res.robustmean{s,v,n}=nanmean(sorted(floor(length(sorted)*.1):ceil(length(sorted)*.9)));
                res.robuststd{s,v,n}=nanstd(sorted(floor(length(sorted)*.1):ceil(length(sorted)*.9)));
            else
                res.robustmean{s,v,n}=res.regmean{s,v,n};
                res.robuststd{s,v,n}=res.regstd{s,v,n};
            end          
            try
                res.ppitch{s,v,n}=perceivedPitch(f0valstmp, 1/sr*32, gamma);
            catch
                sprintf('perceivedPitch failed: %d %d %d', s, v, n)
            end                
            if length(f0valstmp) > 2*win
                matmp=movingavg(f0valstmp, win);
            else
                try
                    matmp=movingavg(f0valstmp, floor(length(f0valstmp)*.4));
                catch
                    sprintf('movingavg failed: %d %d %d', s, v, n)
                end
            end 
            res.MA{s,v,n}=matmp(~isnan(matmp));
            if length(f0valstmp) > 2*dctSize
                [res.dct{s,v,n} tmp]=noteDct(f0valstmp(end-dctSize:end), 3, sr/32);
                [res.dctMA{s,v,n} tmp]=noteDct(res.MA{s,v,n}(end-dctSizeMA:end), 3, sr/32);
            else                
                dctSizetmp=floor(length(f0valstmp)/2);
                dctSizeMAtmp=floor(length(f0valstmp)/2);
                try
                    [res.dct{s,v,n} tmp]=noteDct(f0valstmp(dctSizetmp:end), 3, sr/32);
                    [res.dctMA{s,v,n} tmp]=noteDct(res.MA{s,v,n}(end-dctSizetmp:end), 3, sr/32);   
                catch
                    sprintf('noteDct failed: %d %d %d', s, v, n)
                end
            end
            [res.vibratoDepth{s,v,n} res.vibratoRate{s,v,n}]=calculateVibrato((f0valstmp-mean(f0valstmp))*1200,sr/32);
        end
    end
end