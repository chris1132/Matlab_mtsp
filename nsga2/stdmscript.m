%% 程序书写标准
%% 作图标准
figure('NumberTitle', 'off', 'Name', '这是个窗口啊');
set(gcf,'Color',[1 1 1]);
% 坐标轴格式参数设置
set(gca, 'FontName','Times New Roman');
set(gca, 'Fontsize',12);
set(gca, 'LineWidth',2)
%   plot 参数设置、legend 参数设置（包含上下标）
plot(1,2,'o','LineWidth',2, ...
    'MarkerEdgeColor','r', ...
    'MarkerFaceColor','g', ...
    'MarkerSize',10);
legend('x^1','x_2');  % 上下标
%  X  Y   标题标注
title('Transmission Spectrum','fontsize',13)
xlabel('x坐标(可任意写)','fontsize',13,'fontname','Times new roman');
ylabel('y坐标','fontsize',13,'fontname','Times new roman');

% txt 标注
txt=sprintf('p(%d,%d)=%d',n_bay_start(i)+1,n_job_id(i)+1,n_duration_time(i)); %标注字符
text(pi,0,' \leftarrow 正弦');   %带箭头的标注
axes('position', [0.45 0.3 0.4 0.5])  %画图中图
set(gca,'xaxislocation','top')   %吧x坐标轴设置在最上方
set(gca,'yaxislocation','top')   %吧y坐标轴显示在右边

% 坐标轴显示设置
axis on ;  % 显示坐标轴
axis off; % 关闭坐标轴
axis([xmin xmax ymin ymax]); % 设置坐标轴在指定的区间
axis auto; % 将当前绘图区的坐标轴范围设置为MATLAB自动调整的区间
axis manual; % 冻结当前坐标轴范围，以后叠加绘图都在当前坐标轴范围内显示
axis tight  ; %采用紧密模式设置当前坐标轴范围，即以用户数据范围为坐标轴范围比例：
axis equal  ; %等比例坐标轴
axis square ; % 以当前坐标轴范围为基础，将坐标轴区域调整为方格形
axis normal ; % 自动调整纵横轴比例，使当前坐标轴范围内的图形显示达到最佳效果
% 坐标轴范围、刻度设置、线宽字体
set(gca,'XLim',[0 1.5]);%X轴的数据显示范围
set(gca, 'XTick', [0 1 2]);  % X坐标轴刻度数据点位置
set(gca,'XTickL',[1 2 3 4 4] ,'XTickLabel',[0:0.1:1.5]); %修改标签
set(gca,'FontName','Times New Roman','FontSize',14,...
        'FontWeight','bold','FontAngle','italic'); %  设置坐标轴刻度字体名称，大小
% 填充 多边形区域
fill(X,Y,C) ; % C 用 short namen(k r b等) \或 [r g b]( [0.5 0.5 0.5])\或long name

axis ij  axis xy   % 坐标显示 reserve
(r>=-1)&(r<=1)
A(all(A==0,2),:)=[];  % 去掉 矩阵A的 0 行

%% 文本显示 、 文本嵌入数字、文本标注 text
%   display( )   用来显示 文本 或者  数组array
disp('第一列  第二列  第三列') ;  % 显示文本
disp( rand(5,3) );  % 显示数字
disp(sprintf('圆周率pi= %8.5f',pi));   %disp和sprintf混用

%  用于嵌入数字的一个办法 ： sprintf(formatSpec,A1,...,An);
formatSpec = 'The array is %dx%d.'; A1 = 2;  A2 = 3;
str = sprintf(formatSpec,A1,A2); % // 与下一个表达等价
str = sprintf('The array is %dx%d.',2,3);
%  用于嵌入数子的另一个办法  num2str() :把 numeric values转换为characters
%                            str2num() :把 characters转换为numeric values
name = 'Alice';   age = 12;
X = [name, ' will be ', num2str(age), ' this year.']; %利用[]连接多个字符
%  size(X)=  1,  27  \\一个字符一个位置，空格一个位置，共计27

% text 函数
text(x,y,z,'string','PropertyName',PropertyValue); 
% 箭头标注
annotation('textarrow', [.30 .25], [.8 .8], 'String' , 'sin(x)');
%%  设置显示精度  （不要混淆显示精度和计算精度）
% MATLAB  默认计算精度是 short  型
format long;    % long 精度
format short;   % short 精度

%%  分布
% unifrnd()   连续均匀分布
R = unifrnd(A,B); 
% returns an array R of random numbers generated from the  continuous uniform distributions ...
% with lower and upper endpoints specified by A and B, respectively. If A and B are
% arrays, R(i,j) is generated from the distribution specified by the corresponding elements of A and B.
% If either A or B is a scalar, it is expanded to the size of the other input.
R = unifrnd(A,B,m,n,...) ;
R = unifrnd(A,B,[m,n,...]) ;
% returns an m-by-n-by-... array. 
% If A and B are scalars, all elements of R are generated from the same distribution. 
% If either A or B is an array, they must be m-by-n-by-... 

% unidrnd()  离散均匀分布
% Discrete uniform random numbers
N=20;
R=unidrnd(N);
m=1;n=5;
R=unidrnd(N,m,n); % 等价于 R =unidrnd(N,[m,n])

%%  MATLAB matlab 流程控制
% 1. if- else -  end 
% 2. switch - case - otherwise -end 
% 3. for   end
% 4. while end
% 5. continue   break  
% 6. pause(n) 使程序暂停n  秒后运行；pause 暂停执行，等待用户按任意键运行

%% 匿名函数
fhandle=@(arglist) expr ;  %  匿名函数基本调用格式
% 按 自变量个数分为： 单变量匿名函数和多变量匿名函数
% 按 层数（即@的个数）分为：单重匿名函数和多重匿名函数


%%  常用函数
cumsum() ;  % 累加函数
norm(X,n);   % 向量 X  的  2   范数
A= xlsread('Points.xlsx');  %  excel 文件 read
xlswrite(filename,A,sheet,xlRange);  % 
annotation('textarrow', [.3 .5], [.6 .5], 'String' , 'Straight Line');  % 箭头标注