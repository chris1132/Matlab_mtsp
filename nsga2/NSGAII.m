function NSGAII()
clc;
% format compact;
tic;
% hold on

%--初始化 参数设定
generations=100;        %迭代次数
popnum=100;             %种群大小（偶数）
poplength=30;           %个体长度
minvalue=repmat(zeros(1,poplength),popnum,1);   %个体最小值---B = repmat(A, m, n) %将矩阵A复制m*n块，即B由m*n块A平铺而成
maxvalue=repmat(ones(1,poplength),popnum,1);    %个体最大值
population=rand(popnum,poplength).*(maxvalue-minvalue)+minvalue;    %产生新的初始种群

    %--开始迭代进化
    for gene=1:generations      %开始迭代

        %--交叉
        newpopulation=zeros(popnum,poplength);  %子代种群
        for i=1:popnum/2                        %交叉产生子代
            k=randperm(popnum);                 %从种群中随机选择出两个父母，不采用二进制联赛方法
            beta=(-1).^round(rand(1,poplength)).*abs(randn(1,poplength))*1.481;     %采用正态分布交叉产生两个子代
            newpopulation(i*2-1,:)=(population(k(1),:)+population(k(2),:))/2+beta.*(population(k(1),:)-population(k(2),:))./2;  %产生第一个子代
            newpopulation(i*2,:)=(population(k(1),:)+population(k(2),:))/2-beta.*(population(k(1),:)-population(k(2),:))./2;    %产生第二个子代
        end
        %--变异
        k=rand(size(newpopulation));    %随机选择要变异的基因位
        miu=rand(size(newpopulation));  %采用多项式变异
        temp=k<1/poplength & miu<0.5;   %要变异的基因位
        newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*((2.*miu(temp)+(1-2.*miu(temp)).*(1-(newpopulation(temp)-minvalue(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21)-1);        %变异情况一
        newpopulation(temp)=newpopulation(temp)+(maxvalue(temp)-minvalue(temp)).*(1-(2.*(1-miu(temp))+2.*(miu(temp)-0.5).*(1-(maxvalue(temp)-newpopulation(temp))./(maxvalue(temp)-minvalue(temp))).^21).^(1/21));  %变异情况二

        %--越界处理/种群合并
        newpopulation(newpopulation>maxvalue)=maxvalue(newpopulation>maxvalue); %子代越上界处理
        newpopulation(newpopulation<minvalue)=minvalue(newpopulation<minvalue); %子代越下界处理
        newpopulation=[population;newpopulation];   %合并父子种群

        %--计算目标函数值
        functionvalue=zeros(size(newpopulation,1),2);   %合并后种群的各目标函数值，这里问题是ZDT1
        functionvalue(:,1)=newpopulation(:,1);   %计算第一维目标函数值
        g=1+9*sum(newpopulation(:,2:poplength),2)./(poplength-1);
        functionvalue(:,2)=g.*(1-(newpopulation(:,1)./g).^0.5); %计算第二维目标函数值

        %--非支配排序
        fnum=0;     %当前分配的前沿面编号
        cz=false(1,size(functionvalue,1));      %记录个体是否已被分配编号
        frontvalue=zeros(size(cz));             %每个个体的前沿面编号
        [functionvalue_sorted,newsite]=sortrows(functionvalue); %对种群按第一维目标值大小进行排序 则第一行个体p即为种群中支配个体p的数量为零的个体，Np=0
        while ~all(cz)      %开始迭代判断每个个体的前沿面，采用改进的deductive sort
            fnum=fnum+1;
            d=cz;
            for i=1:size(functionvalue,1) %：(1)找到种群中所有n=0的个体，并保存在当前集合F1中；
                if ~d(i)
                    for j=i+1:size(functionvalue,1) %判断i对应的所有集合里面的支配和非支配的解，被i支配则为1，不被i支配则为0
                        if ~d(j)
                            k=1;
                            for m=2:size(functionvalue,2) %判断是否支配，找到个体p不支配的个体，标记为k=0
                                if functionvalue_sorted(i,m)>functionvalue_sorted(j,m) %判断i,j是否支配，如果成立i,j互不支配
                                    k=0; %i,j互不支配
                                    break;
                                end
                            end
                            if k
                                d(j)=true;  %那么p所支配的个体k=1并记录在d里，则后面该个体已被支配就不能在这一层里进行判断
                            end
                        end
                    end
                    frontvalue(newsite(i))=fnum; %实际位置的非支配层赋值
                    cz(i)=true;
                end
            end
        end

        %--计算拥挤距离/选择出下一代个体
        fnum=0;     %当前前沿面
        while numel(frontvalue,frontvalue<=fnum+1)<=popnum  %判断前多少个面的个体能完全放入下一代种群
            fnum=fnum+1;
        end
        newnum=numel(frontvalue,frontvalue<=fnum);  %前面fnum个面的个体数
        population(1:newnum,:)=newpopulation(frontvalue<=fnum,:);   %将前fnum个面的个体复制入下一代
        popu=find(frontvalue==fnum+1);   %popu记录第fnum+1个面上的个体编号
        distancevalue=zeros(size(popu));    %popu各个体的拥挤距离
        fmax=max(functionvalue(popu,:),[],1);   %popu每维上的最大值
        fmin=min(functionvalue(popu,:),[],1);   %popu每维上的最小值
        for i=1:size(functionvalue,2)   %分目标计算每个目标上popu各个体的拥挤距离
            [~,newsite]=sortrows(functionvalue(popu,i)); %popu里对第一维排序之后的位置
            distancevalue(newsite(1))=inf;
            distancevalue(newsite(end))=inf;
            for j=2:length(popu)-1
                distancevalue(newsite(j))=distancevalue(newsite(j))+(functionvalue(popu(newsite(j+1)),i)-functionvalue(popu(newsite(j-1)),i))/(fmax(i)-fmin(i)); %
            end
        end
        popu=-sortrows(-[distancevalue;popu]')';    %按拥挤距离降序排序第fnum+1个面上的个体
        population(newnum+1:popnum,:)=newpopulation(popu(2,1:popnum-newnum),:); %将第fnum+1个面上拥挤距离较大的前popnum-newnum个个体复制入下一代
    end

%--程序输出
fprintf('已完成，耗时%4s秒\n',num2str(toc));    %程序最终耗时
output=sortrows(functionvalue(frontvalue==1,:));    %最终结果：种群中非支配解的函数值
plot(output(:,1),output(:,2),'*b');             %作图
axis([0,1,0,1]);
xlabel('F_1');
ylabel('F_2');
title('ZDT1');
    
        
        
        