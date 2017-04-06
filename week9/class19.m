% running mircluster on segments
ragSegs=mirsegment('ragtime');
mircluster(ragSegs, mirmfcc(ragSegs))
mircluster(ragSegs, mircentroid(ragSegs))
mircluster(ragSegs, {mirmfcc(ragSegs), mircentroid(ragSegs)})

avmSegs=mirsegment('avm');
mircluster(avmSegs, mirmfcc(avmSegs))
mircluster(avmSegs, mircentroid(avmSegs))
mircluster(avmSegs, {mirmfcc(avmSegs), mircentroid(avmSegs)})