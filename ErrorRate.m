function  ER = ErrorRate(LabelR, LabelH,Weight)

% ER ��������Ĵ�����
% weight ����Ȩ��
% LabelR ������ʵ��ǩ
% LabelH ����Ԥ���ǩ
if(nargin <3)
    Weight = ones(size(LabelR,1),1);
end

ER = sum((Weight.*abs(LabelH-LabelR))/sum(Weight))

end