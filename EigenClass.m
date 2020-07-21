function [D]=EigenClass(Train_Data,Training_Class,Test_Data,k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  Code for paper:  Erkan, U., A Precise and Stable Machine Learning Algorithm: 
% %  Eigenvalue Classification (EigenClass). Neural Computing and Applications,Accept 
% %  Volume, issue and page number will be added later.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     Train_Data = training data
%     Training_Class =  Classes of training data
%     Test_Data = Test data, excluding classes
%     k=the number of eigen values to be used    
    Class_Unique=unique(Training_Class);
    Train_Data(Train_Data == 0) = 0.0001;
    Test_Data(Test_Data == 0) =0.0001;
    Samples_Number=size(Train_Data,2);
        for r=1:numel(Class_Unique)
            b=Train_Data((Training_Class == Class_Unique(r)),:);  
            for i=1:size(Test_Data,1)
                for j=1:size(b,1)                 
                    B(i,j,r)=sum(abs(1-eig(diag(b(j,1:Samples_Number)),diag(Test_Data(i,1:Samples_Number)))));      
                end      
            end
            B(:,:,r)=  sort(B(:,:,r),2);
            C(:,r)=mean(B(:,1:k,r),2);
            clear B;
        end
        for i=1:size(Test_Data,1)
            [~,I] =min(C(i,:));
            D(i,1)=Class_Unique(I);
        end
end