function results = confusionmatResults(original_label,predicted_label)

[mat,~] = confusionmat(original_label,predicted_label);

len=size(mat,1);
TP=zeros(len,1);
TN=zeros(len,1);
FP=zeros(len,1);
FN=zeros(len,1);

Ai=zeros(len,1);
Pi=zeros(len,1);
Ri=zeros(len,1);
macroFi=zeros(len,1);

TotalSamples = sum(sum(mat));

for i=1:len
    TP(i)=mat(i,i);
    FP(i)=sum(mat(:, i))-mat(i,i);
    FN(i)=sum(mat(i,:))-mat(i,i);
    
    tempMat = mat;
    tempMat(:,i) = []; % remove column
    tempMat(i,:) = []; % remove row    
    TN(i) = sum(sum(tempMat));
    
    Ai(i)  = (TP(i)+TN(i)) / TotalSamples;           
    Pi(i) = TP(i)/(TP(i)+FP(i));
    Ri(i) = TP(i)/(TP(i)+FN(i));
    macroFi(i) = 2*Pi(i)*Ri(i)/(Pi(i)+Ri(i));
    
end

accuracy = mean(Ai,'omitnan');
precision=mean(Pi,'omitnan');
recall=mean(Ri,'omitnan');
macro_fscore=mean(macroFi,'omitnan');

micro_precision=nansum(TP)/(nansum(TP)+nansum(FP));
micro_recall=nansum(TP)/(nansum(TP)+nansum(FN));
micro_fscore=2*(micro_precision*micro_recall)/(micro_precision+micro_recall);

results=[accuracy precision recall macro_fscore micro_fscore];
end