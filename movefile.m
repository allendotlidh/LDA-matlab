function movefile()
%�ƶ�ͼƬ��ǰ����Ϊtrain ������Ϊtest
mpath = 'E:\0��֮����\2014summer\matlabtest\fea\';
dpath='E:\0��֮����\2014summer\matlabtest\featrain\';
d2path='E:\0��֮����\2014summer\matlabtest\featest\';
Files = dir(fullfile(mpath,'*.txt'));
LengthFiles = length(Files);

for i = 1:4:LengthFiles
    copyfile(strcat(mpath,Files(i).name),dpath);
    copyfile(strcat(mpath,Files(i+1).name),dpath);
    copyfile(strcat(mpath,Files(i+2).name),d2path);
    copyfile(strcat(mpath,Files(i+3).name),d2path);
end