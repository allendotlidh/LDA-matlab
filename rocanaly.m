function [c1,hist1,c2,hist2,ffp,ffn,eer,far,frr,mer] = rocanaly(pdt,ndt)   %pdt=255*1 ndt=255*254

dmax = max(max(pdt),max(max(ndt)));%dmax = max(max(pdt),max(ndt));-----------------------------------------------
dmin  = min(min(pdt),min(min(ndt)));

i=0;
step   = (dmax-dmin)/100;
pnum = size(pdt,1);%255
nnum = size(ndt,1);%255

[hist1,c1]=hist(pdt,20);%12.5��
[hist2,c2]=hist(ndt,20);%12.5��

mxrrate = 0;
for thrd=dmin:step:dmax
    indjp = find(pdt<=thrd);   %pdt<thrd�ĸ���ռ255�ı���  ������������������
    indjn = find(ndt>thrd );
    ni1=size(indjp,1);
    ni2=size(indjn,1);
    i=i+1;
    ffp(i) = (pnum-ni1)/pnum;   %�����Ǽ�������������ʣ�µĲ���������������
    ffn(i) = (nnum-ni2)/nnum;   %ndt>thrd��������  
    rrate(i)=(ni1+ni2)/(pnum+nnum);%rrate=right rate(��ȷ��)   ������������ȷ��
    if mxrrate<rrate(i)         %maxrrate(max right rate �����ȷ��)��ȷ�ʴ��������ȷ��
        mxrrate=rrate(i);
        frr  = ffp(i);    %pos������v
        far = ffn(i);     %neg������
        thrrdd=thrd;
        mer = 1-mxrrate;  %��max error rate�������ʣ�
    end
end                  %�ҳ�һ������ʹ����������� ���ھ�����С
ind  = find(abs(ffp-ffn)==min(abs(ffp-ffn)));%-----------------ͼƬ����n g�ֲ����ȵ������е��������ɵ�����
thrd = mean(dmin+(ind-1)*step);  %mean(A��  ��ʾ�����A�ľ�ֵ��Ĭ�ϵ�������еľ�ֵ
indjp  = find(pdt<=thrd);        %pdt������������ֵ�������������飬������������ֵ�ж��������
indjn = find(ndt>thrd);
ni1=size(indjp,1);                     %����������
ni2=size(indjn,1);
ffpd = (pnum-ni1)/pnum;            %�����������ĸ���
ffnd = (nnum-ni2)/nnum;
eer =1-(ni1+ni2)/(pnum+nnum);   %��������ܸ���

ind  = find(abs(ffn-0.15)==min(abs(ffn-0.15)));  %  ��������ӽ�0.15�ĸ���
if ffn(ind(1))>=0.15
    ind1=ind(1)+1;
    ind2=ind(1); 
else
    ind1=ind(1);
    ind2=ind(1)-1; 
end
%farfrr15=(ffp(ind1)*abs(ffn(ind1)-0.15)+ffp(ind2)*abs(ffn(ind2)-0.15))/abs(ffn(ind2)-ffn(ind1));

