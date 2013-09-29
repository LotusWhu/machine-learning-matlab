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

[TrainSPost,LabelSPost,TestPostData,TestPostLabel] = GetTrainTestData(Klungf,base_set_Klungf_label,0.07)
[TrainSNegat,LabelSNegat,TestNegatData,TestNegatLabel] = GetTrainTestData(Klungz,base_set_Klungz_label,0.09)

TrainS = [TrainSPost;TrainSNegat]
LabelS = [LabelSPost;,LabelSNegat]
Test = [TestPostData;TestNegatData]
TestLabel = [TestPostLabel;TestNegatLabel]

%Ǩ���㷨
ResultLabel = TrAdaBoost(TrainS,TrainA,LabelS,LabelA,Test,10);
erT = ErrorRate(ResultLabel,TestLabel)

Post = sum(TestLabel);
Negat = size(TestLabel,1) - Post;
ResultPostT = 0;
ResultNegatT = 0;
for i=1:size(Test,1)
    if(ResultLabel(i)==1 && ResultLabel(i) == TestLabel(i))
        ResultPostT = ResultPostT +1;
    end
    if( ResultLabel(i)==0 && ResultLabel(i) == TestLabel(i) )
        ResultNegatT = ResultNegatT + 1;
    end
end
%��Ǩ����
ResultLabel = WeightedKNN(TrainS,LabelS,Test,5);
er = ErrorRate(ResultLabel,TestLabel)

ResultPost = 0;
ResultNegat = 0;
for i=1:size(Test,1)
    if(ResultLabel(i)==1 && ResultLabel(i) == TestLabel(i))
        ResultPost = ResultPost +1;
    end
    if( ResultLabel(i)==0 && ResultLabel(i) == TestLabel(i) )
        ResultNegat = ResultNegat + 1;
    end
end

