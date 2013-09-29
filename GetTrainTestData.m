function [TrainData,TrainDataLabel,TestData,TestDataLabel]= GetTrainTestData(Data,DataLabel,Percent)

%TrainData ���ѡ���ѵ������
%TraninDataLabel ѵ�����ݵı�ǩ
%TestData ���ѡ��Ĳ�������
%TestDataLabel �������ݵı�ǩ
%Percent ѵ��������ռ�İٷֱ�
%Data ��������
%DataLabel ���ݱ�ǩ

TrainDataNum = ceil(size(Data,1)*Percent);
SelectDataIndex = randperm(size(Data,1));

TrainData = Data(SelectDataIndex(1:TrainDataNum),:);
TrainDataLabel = DataLabel(SelectDataIndex(1:TrainDataNum));

TestData = Data(SelectDataIndex(TrainDataNum+1:size(Data,1)),:);
TestDataLabel = DataLabel(SelectDataIndex(TrainDataNum+1:size(Data,1)));
end