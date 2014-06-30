% this function is used to obtain fisherface from the training set with the
% lgbp feature

function[averface,fisherface] = lda(srcface,fdim)
%���룺num����ͼƬ������ dim����ͼƬ��ά������ Ҳ����ldbp������132160. fdim�����ڴ���ά���ά����
%�����averfaceƽ����(num*dim) fisherface(dim,fdim)
%ldaface=differface*fisherface;(imgnum,fdim)��Ҫ���������ȥƽ������fisherface�ռ�����ͶӰ�õ�һ��ldaface��������LDA��ά�����
%eigenface=differface'*mideigenvec;
%fisherface = eigenface*fisher;(dim*fnim)
%eigenface��fisherface��������ѡȡ���ɷֵ�ͶӰ�ռ䡣
%num=510 dim=132160 fdim=510

%ѵ�������õ�averface fisherface
%����������ͶӰ��fisherfac�ռ��еõ���ά��ά�����������
affile = 'E:\0��֮����\2014summer\matlabtest\savefile\averface.dat';
fffile = 'E:\0��֮����\2014summer\matlabtest\savefile\fisherface.dat';

[num,dim]=size(srcface);

srcface=zeros(num,dim);
averface=zeros(1,dim);
differface=zeros(num,dim);
midmatrix=zeros(num,num);
mideigenvec=zeros(num,num);
mideigenval=zeros(num,num);
eigenface=zeros(dim,num);


 cnum = num/2;
 inum = 2;
fdim=510;
%caculate averface and display and save the image
averface = sum(srcface);
averface = averface/num;
fprintf(1,'Aver face is obtained...');
%pause;

% calculate dispersion matrix of samples
for i=1:num
   differface(i,:)=srcface(i,:)-averface;
end
midmatrix=differface*differface';

% obtain eigenface
[mideigenvec, LATENT, EXPLAINED] = pcacov(midmatrix);
eigenface=differface'*mideigenvec;


%obtain fisher face
eigenface =eigenface(:,1:fdim);
ffsmpl = eigenface'*differface';%fdim*num
ndim   = fdim;
amean  = zeros(ndim,1);
cmean  = zeros(ndim,cnum);
sw     = zeros(ndim,ndim);
sb     = zeros(ndim,ndim);
%calculate intra-class and interclass distribution matrix
for i=1:cnum
   for j=1:inum
      cmean(:,i) = cmean(:,i)+ffsmpl(:,(i-1)*inum+j);
   end
   cmean(:,i) = cmean(:,i)/inum;
   amean      = amean + cmean(:,i);
end
amean = amean/cnum;
for i=1:cnum
   sb = sb + (cmean(:,i)-amean)*(cmean(:,i)-amean)';
   for j=1:inum
      sw = sw + (ffsmpl(:,(i-1)*inum+j)-cmean(:,i))*(ffsmpl(:,(i-1)*inum+j)-cmean(:,i))';
   end
end
sb = sb/cnum;
sw = sw/num;
% solute LDA problem
[H,V,t]   = pcacov(sw);
[row,col] = size(H);
T         = zeros(row,col);
T         = diag(1./sqrt(V));
Tr        = H*T;
[U,S,t]   = pcacov(Tr'*sb*Tr);
fisher    = Tr*U;
%normalization and orthognalization
for i=1:ndim
    fisher(:,i)=fisher(:,i)/norm(fisher(:,i));
end
fisherface = eigenface*fisher;
   
 
fprintf(1,'fisher face is obtained...');
%pause;


s = 1;