clear;
load('Klungf.mat'); %���ݵ���
load('Klungz.mat');
load('Zlungf.mat');
load('Zlungz.mat');

Klungf=mapminmax(Klungf,0,1);%���ݹ�һ��
Klungz=mapminmax(Klungz,0,1);
Zlungf=mapminmax(Zlungf,0,1);
Zlungz=mapminmax(Zlungz,0,1);

aux_set=[Zlungf;Zlungz];%����ҽԺ�β�CT������Ϊ����ѵ������
aux_Zlungf_label=zeros(size(Zlungf,1),1); %��������ǩΪ0
aux_Zlungz_label=ones(size(Zlungz,1),1);%��������ǩΪ1
aux_train_set=aux_set;
aux_train_set_label=[aux_Zlungf_label;aux_Zlungz_label];  %����ѵ�����ݱ�ǩ


[aux_m aux_n]=size(aux_train_set);%����ѵ�����ݵ�������С


base_set=[Klungf;Klungz];  %����Դѵ������
base_set_Klungf_label=zeros(size(Klungf,1),1);
base_set_Klungz_label=ones(size(Klungz,1),1);
base_set_label=[base_set_Klungf_label;base_set_Klungz_label];

[Klungf_m Klungf_n]=size(Klungf);
[Klungz_m Klungz_n]=size(Klungz);

TrainA = aux_train_set;
LabelA = aux_train_set_label;
TrainS = [Klungf(1:20,:);Klungz(1:20,:)];
LabelS = [base_set_Klungf_label(1:20);base_set_Klungz_label(1:20)];
Test = [Klungf(21:Klungf_m,:);Klungz(21:Klungz_m,:)];
TestLabel = [base_set_Klungf_label(21:Klungf_m,:);base_set_Klungz_label(21:Klungz_m,:)]

%Ǩ���㷨
ResultLabel = TrAdaBoost(TrainS,TrainA,LabelS,LabelA,Test,20);
erT = ErrorRate(ResultLabel,TestLabel)
%��Ǩ����
ResultLabel = WeightedKNN(TrainS,LabelS,Test,10);
er = ErrorRate(ResultLabel,TestLabel)