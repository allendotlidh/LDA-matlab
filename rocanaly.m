function [c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt)   %pdt=255*1 ndt=255*254

dmax = max(max(pdt),max(max(ndt)));%dmax = max(max(pdt),max(ndt));-----------------------------------------------
dmin  = min(min(pdt),min(min(ndt)));

i=0;
step   = (dmax-dmin)/100;
pnum = size(pdt,1);%255
nnum = size(ndt,1);%255

[hist1,c1]=hist(pdt,20);%12.5快
[hist2,c2]=hist(ndt,20);%12.5块

mxrrate = 0;
for thrd=dmin:step:dmax
    indjp = find(pdt<=thrd);   %pdt<thrd的个数占255的比例  即满足条件的样本。
    indjn = find(ndt>thrd );
    ni1=size(indjp,1);
    ni2=size(indjn,1);
    i=i+1;
    ffp(i) = (pnum-ni1)/pnum;   %这里是减掉满足条件的剩下的不符合条件样本率
    ffn(i) = (nnum-ni2)/nnum;   %ndt>thrd。。。。  
    rrate(i)=(ni1+ni2)/(pnum+nnum);%rrate=right rate(正确率)   满足条件的正确率
    if mxrrate<rrate(i)         %maxrrate(max right rate 最大正确率)正确率大于最大正确率
        mxrrate=rrate(i);
        frr  = ffp(i);    %pos错误率v
        far = ffn(i);     %neg错误率
        thrrdd=thrd;
        mer = 1-mxrrate;  %（max error rate最大错误率）
    end
end                  %找出一个距离使得类间距离最大 类内距离最小
ind  = find(abs(ffp-ffn)==min(abs(ffp-ffn)));%-----------------图片组中n g分布均匀的所在行的列数构成的数组
thrd = mean(dmin+(ind-1)*step);  %mean(A）  表示求矩阵A的均值，默认的是求各列的均值
indjp  = find(pdt<=thrd);        %pdt距离中少于阈值所在列数的数组，用于求少于阈值有多少种情况
indjn = find(ndt>thrd);
ni1=size(indjp,1);                     %满足条件的
ni2=size(indjn,1);
ffpd = (pnum-ni1)/pnum;            %不满足条件的概率
ffnd = (nnum-ni2)/nnum;
eer =1-(ni1+ni2)/(pnum+nnum);   %不满足的总概率

ind  = find(abs(ffn-0.15)==min(abs(ffn-0.15)));  %  误判率最接近0.15的个数
if ffn(ind(1))>=0.15
    ind1=ind(1)+1;
    ind2=ind(1); 
else
    ind1=ind(1);
    ind2=ind(1)-1; 
end
%farfrr15=(ffp(ind1)*abs(ffn(ind1)-0.15)+ffp(ind2)*abs(ffn(ind2)-0.15))/abs(ffn(ind2)-ffn(ind1));

