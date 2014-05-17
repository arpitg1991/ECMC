topics = dlmread('TM/NG20Topics.csv',' ');
true_labels = dlmread('20NG_labels.csv');
TM100 = csvread('TM\NG20clusters.csv');
topics = topics(:,1:6);
csim = pdist(topics,'cosine');
csim = 1 - squareform(csim) ; 
%%
%similarity method 2 
inpSize = size(topics,1) ; 
csim = zeros (inpSize ) ;
for (i = 1:inpSize )
    for ( j = 1:inpSize ) 
        csim (i,j) = topics(i,TM100(i) +1 ) * topics(j,TM100(j) +1) ;
        if ( TM100 (i) ~= TM100(j) ) 
            csim(i,j) = csim (i,j) * -1 ; 
        end
    end

end
newcsim = csim ; 
%%
topics2 = topics ; 
csim = newcsim ; 
partialMatrix = createBlanks(csim ,-0.2, 0.08,2 ) ;

%%
%Perform Matrix Completion
cd('inexact_alm_mc\')
completeMatrix = inexact_alm_mc(partialMatrix) ;    
completeMatrix1 = completeMatrix ; 
completeMatrix = completeMatrix.U*completeMatrix.V' ;
cd ..
%%
%Spectral clustering 
completeMatrix = completeMatrix + abs(min(min(completeMatrix)));
completeMatrix = completeMatrix + 0.000001 ;
completeMatrix = 1./ completeMatrix ;
predictedLabels = sc(completeMatrix,0,6);
nmi(true_labels+1,predictedLabels)
%%

