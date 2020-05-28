clear all;
clc;
close all;
global DEM safth hmax scfitness;
a=load('XYZmesh.mat');%读取数字高程信息DEM
DEM=a;
DEM.Z=DEM.Z;
safth=60;

hmax=max(max(DEM.Z));
hmin=min(min(DEM.Z));
%DEM.Z=randint(size(DEM.Z,1),size(DEM.Z,2),[0 100]);
ganum=100;
dnanum=60;
dnalength=50;
childrennum=dnanum;

np=zeros(1,dnanum);
nsort=zeros(1,dnanum);
fitness=zeros(dnanum,3);
scfitness=zeros(dnanum,3);
congestion=zeros(1,dnanum);
startpoint=[1,1,100];
goalpoint=[101,101,100];
startpoint(3)=DEM.Z(startpoint(1),startpoint(2))+safth;
goalpoint(3)=DEM.Z(goalpoint(1),goalpoint(2))+safth;
dna=zeros(dnanum,dnalength+1,3);
totalfitness=zeros(2,ganum+1,3);

for i=1:1:dnanum
    for j=2:1:dnalength
        for k=1:1:2
         %dna(i,j,k)=randint(1,1,[1 101]);    
        dna(i,j,1)=j*100/dnalength; 
        dna(i,j,2)=j*100/dnalength+randi([0 20],1,1)-10;  
        if dna(i,j,2)<1
           dna(i,j,2)=1;
        elseif dna(i,j,2)>101
           dna(i,j,2)=101;      
        end
        %dna(i,j,k)=floor(100*j/dnalength);
        %dna(i,j,k)=j;
        end    
        dna(i,j,3)=DEM.Z(dna(i,j,1),dna(i,j,2))+safth; 
        %dna(i,j,3)=randint(1,1,[safth safth+hmax]);
        %dna(i,j,3)=safth+hmax;
    end
    for k=1:1:3
    dna(i,1,k)=startpoint(k);
    dna(i,dnalength+1,k)=goalpoint(k);
    end
end


for n=1:1:ganum
n

fitness=NSGA2_fitness(dna);
scfitness=fitness;

mmin(1)=min(fitness(:,1));
mmin(2)=min(fitness(:,2));
mmin(3)=min(fitness(:,3));
mmax(1)=max(fitness(:,1));
mmax(2)=max(fitness(:,2));
mmax(3)=max(fitness(:,3));
totalfitness(1,n,:)=mmin;
totalfitness(2,n,:)=mmax;
nsort=NSGA2_SORT(fitness);

children=NSGA2_chlidren(dna,childrennum,nsort);

children_out=NSGA2_cross(children);

%children=children_out;

children=NSGA2_variation(children_out);


combinedna(1:1:dnanum,:,:)=dna(1:1:dnanum,:,:);

combinedna(dnanum+1:1:dnanum+childrennum,:,:)=children(1:1:dnanum,:,:);
childrenfitness=NSGA2_fitness(children); 
combinefitness(1:1:dnanum,:)=fitness(1:1:dnanum,:);
combinefitness(dnanum+1:1:dnanum+childrennum,:)=childrenfitness(1:1:dnanum,:);


dna=NSGA2_BESTN(combinedna,combinefitness,dnanum);

end
mmin(1)=min(fitness(:,1));
mmin(2)=min(fitness(:,2));
mmin(3)=min(fitness(:,3));
mmax(1)=max(fitness(:,1));
mmax(2)=max(fitness(:,2));
mmax(3)=max(fitness(:,3));
totalfitness(1,ganum+1,:)=mmin;
totalfitness(2,ganum+1,:)=mmax;
nsort=NSGA2_SORT(fitness);

fitness=NSGA2_fitness(dna);

bestnum=10;
bestdna=zeros(bestnum,dnalength+1,3);
bestdna=NSGA2_RESULTN(dna,fitness,bestnum);
bestfitness=NSGA2_fitness(bestdna);

nsort=NSGA2_SORT(bestfitness);
resultnum=0;
for i=1:1:bestnum
    if nsort(1,i)==1
       resultnum=resultnum+1;
       resultdna(resultnum,:,:)=bestdna(i,:,:);
       resultdnafitness(resultnum,:)=bestfitness(i,:);
    end
end
resultdnafitness(:,1)=resultdnafitness(:,1)/min(resultdnafitness(:,1));
resultdnafitness(:,2)=resultdnafitness(:,2)/min(resultdnafitness(:,2))
resultdnafitness(:,3)=resultdnafitness(:,3)/min(resultdnafitness(:,3))
resultnum
resultdnafitness
figure(1);
mesh(DEM.X,DEM.Y,DEM.Z);
axis([0 100 0 100 hmin hmax*2]);
colormap summer;
grid off;
xlabel('x/km');
ylabel('x/km');
zlabel('x/m');
hold on;


figure(2);
plot(1:1:ganum+1,totalfitness(1,:,1),'r',1:1:ganum+1,totalfitness(2,:,1),'b');
legend('最小值','最大值');
grid on;
xlabel('迭代次数');
ylabel('航迹长度代价');
title('航迹长度收敛曲线');
hold on;
figure(3);
plot(1:1:ganum+1,totalfitness(1,:,2),'r',1:1:ganum+1,totalfitness(2,:,2),'b');
legend('最小值','最大值');
grid on;
xlabel('迭代次数');
ylabel('安全性代价');
title('威胁度收敛曲线');
hold on;
figure(4);
plot(1:1:ganum+1,totalfitness(1,:,3),'r',1:1:ganum+1,totalfitness(2,:,3),'b');
legend('最小值','最大值');
grid on;
xlabel('迭代次数');
ylabel('隐蔽性代价');
title('隐蔽性收敛曲线');
hold on;
figure(5);
for i=1:1:resultnum
plot3(resultdnafitness(i,1)/min(resultdnafitness(:,1)),resultdnafitness(i,2)/min(resultdnafitness(:,2)),resultdnafitness(i,3)/min(resultdnafitness(:,3)),'ro');
text(resultdnafitness(i,1)/min(resultdnafitness(:,1)),resultdnafitness(i,2)/min(resultdnafitness(:,2)),resultdnafitness(i,3)/min(resultdnafitness(:,3)),num2str(i));
hold on;    
end
grid on;
xlabel('航迹长度代价');
ylabel('安全性代价');
zlabel('隐蔽性代价');
title('最优非支配解集');
hold on;
figure(6);
for i=1:1:resultnum
plot3(resultdnafitness(i,1)/min(resultdnafitness(:,1)),resultdnafitness(i,2)/min(resultdnafitness(:,2)),resultdnafitness(i,3)/min(resultdnafitness(:,3)),'ro');
%text(resultdnafitness(i,1)/min(resultdnafitness(:,1)),resultdnafitness(i,2)/min(resultdnafitness(:,2)),resultdnafitness(i,3)/min(resultdnafitness(:,3)),num2str(i));
hold on;    
end
grid on;
xlabel('航迹长度代价');
ylabel('安全性代价');
zlabel('隐蔽性代价');
title('最优非支配解集');
hold on;
thrdmax=[20,16,16];
thrdmin=[10,8,8];
sita=[30,30,30]*pi/180;
thr(1,:)=[10,20,200];
thr(2,:)=[40,60,200];
thr(3,:)=[60,40,200];
thrt=0:pi/40:2*pi;
for i=1:1:resultnum
    figure(6+2*i-1);
    mesh(DEM.X,DEM.Y,DEM.Z');
    axis([0 100 0 100 hmin hmax*2]);
    colormap summer;
    grid off;
    xlabel('x/km');
    ylabel('y/km');
    zlabel('z/m');
    hold on;
   % for i=j::1:dnalength+1      
   % end
    stem3(resultdna(i,:,1),resultdna(i,:,2),resultdna(i,:,3),'fill');
    plot3(resultdna(i,:,1),resultdna(i,:,2),resultdna(i,:,3),'r');
    hold on;
    figure(6+2*i);
    mesh(DEM.X,DEM.Y,DEM.Z');
    axis([0 100 0 100 hmin hmax*2]);
    colormap summer;
    grid off;
    xlabel('x/km');
    ylabel('y/km');
    zlabel('z/m');
    hold on;
   % for i=j::1:dnalength+1      
   % end
    plot3(resultdna(i,:,1),resultdna(i,:,2),resultdna(i,:,3),'r');
    hold on;
    for k=1:1:3
    plot3(sin(thrt)*thrdmax(k)+thr(k,1),cos(thrt)*thrdmax(k)+thr(k,2),600*ones(1,size(thrt,2)),'r');  
    plot3(sin(thrt)*thrdmin(k)+thr(k,1),cos(thrt)*thrdmin(k)+thr(k,2),600*ones(1,size(thrt,2)),'r');
    end
    hold on;
end
