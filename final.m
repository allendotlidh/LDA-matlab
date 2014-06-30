function final(num)

%load srcface
mpath = 'E:\0方之创新\2014summer\matlabtest\featest\';
Files = dir(fullfile(mpath,'*.txt'));
LengthFiles = length(Files);
if LengthFiles~=510
    fprintf('lengthfiles error ');
end
srcface=zeros(510,132160);
for i = 1:LengthFiles
    srcface(i,:)= load(strcat(mpath,Files(i).name));
end
switch num
	case 0
		%1)0级降维
[pdt,ndt]=distance0(srcface)

[c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt)
Plot(c1,hist1/max(hist1),'r-');hold on
Plot(c2,hist2/max(hist2),'b-');figure;
	case 1
	%2)1级降维
[pdt,ndt]=distance(srcface,averface,fisherface)
[c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt)
Plot(c1,hist1/max(hist1),'r-');hold on;
Plot(c2,hist2/max(hist2),'b-');figure;
	case 2
	%3）2级降维
%多次调用lda.m
%--------begin(40+1)LDA
fprintf('begin the (40+1)LDA...');

averface=[];
fisherface=[]
for index=1:40
    tempface=srcface(:,56*59*(index-1)+1:56*59*(index));
    [averfacetemp,fisherfacetemp] = dolda(tempface,510);
    averface=[averface,averfacetemp];
    fisherface=[fisherface,fisherfacetemp];
end
for i=1:size(srcface,1)
	srcface(i,:)=srcface(i,:)-averface;
end
tempface=srcface*fisherface;
 [averfacetemp,fisherfacetemp] = dolda(tempface,510);
 %think  averface=[averface,averfacetemp];
 averface=averfacetemp;
 fisherface=fisherfacetemp;
[pdt,ndt]=distance(srcface,averface,fisherface)
[c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt);
%保存结果分析代
save('algo1distance.mat', 'pdt','ndt');
save('algo1performance.mat', 'c1','hist1','c2','hist2','ffp','ffn','eerexp','farexp','frrexp','merexp');
Plot(c1,hist1/max(hist1),'r-');hold on ;
Plot(c2,hist2/max(hist2),'b-');
	case 3
	
%4)---------------
fprintf('begin the (56+1)LDA...');

averface=[];
fisherface=[]
for index=1:56
    tempface=srcface(:,40*59*(index-1)+1:40*59*(index));
    [averfacetemp,fisherfacetemp] = dolda(tempface,510);
    averface=[averface,averfacetemp];
    fisherface=[fisherface,fisherfacetemp];
end
for i=1:size(srcface,1)
	srcface(i,:)=srcface(i,:)-averface;
end
tempface=srcface*fisherface;
 [averfacetemp,fisherfacetemp] = dolda(tempface,510);
 averface=averfacetemp;
 fisherface=fisherfacetemp;
[pdt,ndt]=distance(srcface,averface,fisherface)
[c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt);
%保存结果分析代
save('algo1distance.mat', 'pdt','ndt');
save('algo1performance.mat', 'c1','hist1','c2','hist2','ffp','ffn','eerexp','farexp','frrexp','merexp');
Plot(c1,hist1/max(hist1),'r-');hold on ;
Plot(c2,hist2/max(hist2),'b-');
	case 4
	
%4)----3级降维

fprintf('begin the (40*56+1)LDA...');

averface=[];
fisherface=[]
for index=1:56*40
    tempface=srcface(:,(index-1)*59*+1:index*59);%59->50
    [averfacetemp,fisherfacetemp] = dolda2(tempface,50);%这里不需要转置
    averface=[averface,averfacetemp];
    fisherface=[fisherface,fisherfacetemp];
end
for i=1:size(srcface,1)
	srcface(i,:)=srcface(i,:)-averface;
end
srcface=srcface*fisherface;

averface=[];
fisherface=[]
for index=1:56
   tempface=srcface(:,(index-1)*40*50*+1:index*40*50);%40*50->510
 [averfacetemp,fisherfacetemp] = dolda(tempface,510);
 averface=[averface,averfacetemp];
    fisherface=[fisherface,fisherfacetemp];
for i=1:size(srcface,1)
	srcface(i,:)=srcface(i,:)-averface;
end
srcface=srcface*fisherface;
averface=[];
fisherface=[]

[pdt,ndt]=distance(srcface,averface,fisherface)
[c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt);
%保存结果分析代
save('algo1distance.mat', 'pdt','ndt');
save('algo1performance.mat', 'c1','hist1','c2','hist2','ffp','ffn','eerexp','farexp','frrexp','merexp');
Plot(c1,hist1/max(hist1),'r-');hold on ;
Plot(c2,hist2/max(hist2),'b-');
	

end
end
%low the feature





