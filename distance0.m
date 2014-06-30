%专为0级降维设计
function[pdt,ndt]=distance(srcfile)
%{
输入：feafile(imgNum,dim)样本集，降维的没降维的都行.510*132160
averface:1*dimen
fisherface:dimen*fdim
输出：pdt同类样本的距离，ndt不同间的的距离
pdt:255*1  size(feafile,1)/2 * 1
ndt:255*254*4   
%}



feafile=srcfile;

peopleNum=size(feafile,1)/2;
fdim=size(feafile,2);
pdt=zeros(peopleNum,1);%peopleNum
for i=1:peopleNum
	pdt(i,1)=sum(abs(feafile(2*i-1,:)-feafile(2*i,:)))/fdim;
end

%255*254*4
ndt=zeros(peopleNum*(peopleNum-1)*4,1);index=0;
for j=1:peopleNum*2
   for k=1:peopleNum*2
      if mod(j,2)==0
         if k~=j && k~=(j-1)
            index=index+1;
            ndt(index,1)=sum(abs(feafile(j,:)-feafile(k,:)))/fdim;
         end
      end
       if mod(j,2)~=0
            if k~=j && k~=(j+1)
                index=index+1;
             ndt(index,1)=sum(abs(feafile(j,:)-feafile(k,:)))/fdim;
            end
        end
   end
end

save('algo1distance0.mat', 'pdt','ndt');

