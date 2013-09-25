function [H] = TrAdaBoost(TrainS,TrainA,LabelS,LabelA,Test,N,Learner)
%
% H �������������շ����ǩ
% TrainS ԭѵ������
% TrainA ����ѵ������
% LabelS ԭѵ�����ݱ�ǩ(������)
% LabelA ����ѵ�����ݱ�ǩ(������)
% Test  ��������
% N ��������
% Learner ����������
% Write by ChenBo 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainData  = [TrainS;TrainA]
trainLabel = [LabelS;labelA]

% rowS ԭѵ�������ĸ���, columnS ԭѵ��������ά�� ;  rowA ����ѵ�������ĸ���, columnA ����ѵ��������ά��
[rowS,columnS] = size(TrainS)
[rowA,columnA] = size(TrainA)
%rowT ���������ĸ��� , columnT����������ά��
[rowT,columnT] = size(test)

%�㷨��Ҫ��������ѵ�����������ݵ�Ԥ����
testData = [trainData;test]

%��ʼ��ѵ������Ȩ�ؼ�Beta
weight = ones(rowS+rowA,1)/(rowS+rowA)
beta  = 1/(1+sqrt(2*log(rowS/N)))
betaT = zeros(N,1)

%��¼N�ε���ѵ���Ľ��������ѵ��������������ݣ�
resultLabels = ones(N,size(rowS+rowA+rowT,1))

for i=1:N
    p = weight./sum(weight)
    resultLabels(:,i)= WeightKNN(TrainData,TrainLabel,testData,5, weight);
    er = ErrorRate(LabelS,resultLabels(1:rowS,i),weight)  %ԭѵ�����ݵķ��������
    if(er>0.5)
        er = 0.5
    end
    betaT(i)=er/(1-er)
    for j=1:rowS %����ԭѵ�����ݵ�Ȩ��
        weight(j) = weight(j)*bate^abs(result(j,i)-LabelS(j))
    end
    for j=1:rowA %���¸���ѵ�����ݵ�Ȩ��
        weight(rowS+j) = weight(rowS+j)*btatT^(-abs(result(rowS+j,i))-LabelA)
    end
    
end
   for i=1:rowT
       temp1 = sum(-1*resultLabels(rowS+rowA+i,ceil(N/2):N).*betaT())
       temp2 = -1/2*sum(log(betaT(ceil(N/2):N)))
       if(temp1>temp2)
           H(i,1) = 1;
       else
           H(i,1) =-1;
       end
   end
end