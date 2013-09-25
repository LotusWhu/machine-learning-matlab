function result = WeightedKNN(trainX, trainclassY,testZ, k, weight,type) 
 
% Classify using the Nearest neighbor algorithm 

% Inputs: 
% trainX	       - Train sample matrix, n*d, n points, each d dimentions 
% trainclassY	   - class of trainX, n*1 
% testZ            - Test sample matrix , N*d 
% k		           - Number of nearest neighbors  
% type             - specified measure distance: 2norm, 1norm  etc.

% Outputs: 
% result	       - class of testZ, N*1 
 
%  �ж�trainX��testZ��������ά���Ƿ���ͬ                                       
if size(trainX,2) ~= size(testZ,2)                                       
    error ('trainX and testZ must have same column dimensions !')         %  ά��dӦ����ͬ 
end    
 
%  �ж�k�����Ƿ��ȡ 
n= length(trainclassY);                                                   %  ѵ�����������    
if ( n < k)                                 
   error('You specified more neighbors than existed points.') 
end                                                                       %  ѡ��Ľ������������������� 

class               = unique(trainclassY);                                %  unique(x)��ʾ�г�����x���ظ���Ԫ�أ������������У���������ų������Ŀ 
N                   = size(testZ, 1);                                     %  testZ�������������Լ����������� 
result              = zeros(N, 1);                                        %  ��ʼ��result����,N*1���������testZ����� 
 
%  ȷ��ʹ�õĶ������룬��δָ����Ĭ��Ϊ2norm ,Ĭ����������Ȩ�����
if  nargin < 6                                                            %  nargin��ʾ������������ĸ�����<6��typeδ���� 
    type = '2norm';                                                       %  L2����������ŷ�Ͼ���
end

%δָ������Ȩ�أ�Ĭ��Ȩ�����
if nargin < 5
    weight = ones(n,1);                                                  %  ��������Ȩ�ض���ȣ�Ϊ1
    type = '2norm'
end
 
%  ������ѡ�Ķ������룬��testZ��N�����������k���ڷ���  
switch type                                                               %  ��type���� 
     
case '2norm'                                                              %  ʹ��L2������ŷ�Ͼ��� 
    for i = 1:N 
        dist = sum((trainX - ones(n,1)*testZ(i,:)).^2,2)./weight          %  dist ��ʾ��i�����Ե�ֱ���n��ѵ��������֮���ŷʽ�����ƽ�� 
        [m, indices]    = sort(dist);                                     %  ���������о���    
        histclass       = hist(trainclassY(indices(1:k)), class);         %  ȡǰk����̾����Ӧ�ĵ���������𣬰���class����ֱ��ͼͳ��,histclassΪclass�и�����ֵĴ��� 
        [c, best]       = max(histclass);                                 %  cȡ���������������Ǹ����Ĵ�����best��ǳ�c��histclass�ж�Ӧindex����Ϊclass��index 
        result(i)       = class(best);                                    %  testZ�ĵ�i����ȡbest��class�ж�Ӧ����� 
    end 
     
case '1norm'                                                              %  ʹ��L1�������� Manhatan ���� 
    for i = 1:N 
        dist = sum(abs(trainX - ones(n,1)*testZ(i,:)),2)./weight          %  dist ��ʾ��i�����Ե�ֱ���n��ѵ��������֮���L1���� 
        [m, indices]    = sort(dist);    
        histclass       = hist(trainclassY(indices(1:k)), class); 
        [c, best]       = max(histclass); 
        result(i)       = class(best); 
    end 
     
%case 'match'           ʹ��match��ƥ�䣩���룬��ͬԪ��Խ�࣬Խƥ�䣬����Խ�� 
%    for i = 1:N 
%        dist            = sum(trainX == ones(n,1)*testZ(i,:),2);  ����ͬȡ1������ȡ0 
%        [m, indices]    = sort(dist,2);  ���������У���������ʾ��ƥ�� 
%        histclass       = hist(trainclassY(indices(1:k)), class); 
%        [c, best]       = max(histclass); 
%        result(i)       = class(best); 
%    end 
     
otherwise 
    error('Unknown measure function'); 
end
