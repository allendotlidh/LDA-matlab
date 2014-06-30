function movefile()
%移动图片。前两张为train 后两张为test
mpath = 'E:\0方之创新\2014summer\matlabtest\fea\';
dpath='E:\0方之创新\2014summer\matlabtest\featrain\';
d2path='E:\0方之创新\2014summer\matlabtest\featest\';
Files = dir(fullfile(mpath,'*.txt'));
LengthFiles = length(Files);

for i = 1:4:LengthFiles
    copyfile(strcat(mpath,Files(i).name),dpath);
    copyfile(strcat(mpath,Files(i+1).name),dpath);
    copyfile(strcat(mpath,Files(i+2).name),d2path);
    copyfile(strcat(mpath,Files(i+3).name),d2path);
end