clc;
clear all;
close all;
warning off;

    DM=importdata('Wine.mat');
    Data_Class=DM(:,end);
    K_fold=5;
    k=3;
    Indices = crossvalind('Kfold',Data_Class,K_fold);
    
    for i = 1:K_fold
        Test = (Indices == i); 
        Train = ~Test;
        Training_Data=DM(Train,1:end-1);
        Training_Data_Class=DM(Train,end);
        Test_Data=DM(Test,1:end-1);  
        Test_Data_Class=DM(Test,end); 
        D=EigenClass(Training_Data,Training_Data_Class,Test_Data,k);%EigenClass(Train_Data,Training_Data_Class,Test_Data,k value);
        EVAL(i,:)=confusionmatResults(Test_Data_Class, D);%Results 
        clear PC;clear Test_Data(:,end);%%In each iteration, Test_Data is deleted because the number of total samples is not the same.
    end

    %Accuracy / recision / Recall / Macro-F measure/ Micro-F measure
    Mean_Results=mean(EVAL)




