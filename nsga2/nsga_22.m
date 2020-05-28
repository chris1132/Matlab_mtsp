% function nsga_2
%% function nsga_2(pop,gen)
%% 算法参数设置
clc
clear
close all
pop=1000; % 初始种群数量
gen=20; % 迭代次数

%% 问题参数设置
M=3; % 目标函数个数
V=19; % 自 变量个数
min_range=zeros(1,19);  % 自变量取值低阶
max_range=ones(1,19);   % 自变量取值高阶


%% Initialize the population
% Population is initialized with random values which are within the
% specified range. Each chromosome consists of the decision variables. Also
% the value of the objective functions, rank and crowding distance
% information is also added to the chromosome vector but only the elements
% of the vector which has the decision variables are operated upon to
% perform the genetic operations like corssover and mutation.
chromosome = initialize_variables(pop, M, V, min_range, max_range);


%% Sort the initialized population
% Sort the population using non-domination-sort. This returns two columns
% for each individual which are the rank and the crowding distance
% corresponding to their position in the front they belong. At this stage
% the rank and the crowding distance for each chromosome is added to the
% chromosome vector for easy of computation.
chromosome = non_domination_sort_mod(chromosome, M, V);

%% Start the evolution process
% The following are performed in each generation
% * Select the parents which are fit for reproduction
% * Perfrom crossover and Mutation operator on the selected parents
% * Perform Selection from the parents and the offsprings
% * Replace the unfit individuals with the fit individuals to maintain a
%   constant population size.

for i = 1 : gen
    % Select the parents
    % Parents are selected for reproduction to generate offspring. The
    % original NSGA-II uses a binary tournament selection based on the
    % crowded-comparision operator. The arguments are
    % pool - size of the mating pool. It is common to have this to be half the
    %        population size.
    % tour - Tournament size. Original NSGA-II uses a binary tournament
    %        selection, but to see the effect of tournament size this is kept
    %        arbitary, to be choosen by the user.
    pool = round(pop/2);
    tour = 2;
    % Selection process
    % A binary tournament selection is employed in NSGA-II. In a binary
    % tournament selection process two individuals are selected at random
    % and their fitness is compared. The individual with better fitness is
    % selcted as a parent. Tournament selection is carried out until the
    % pool size is filled. Basically a pool size is the number of parents
    % to be selected. The input arguments to the function
    % tournament_selection are chromosome, pool, tour. The function uses
    % only the information from last two elements in the chromosome vector.
    % The last element has the crowding distance information while the
    % penultimate element has the rank information. Selection is based on
    % rank and if individuals with same rank are encountered, crowding
    % distance is compared. A lower rank and higher crowding distance is
    % the selection criteria.
    parent_chromosome = tournament_selection(chromosome, pool, tour);
    
    % Perfrom crossover and Mutation operator
    % The original NSGA-II algorithm uses Simulated Binary Crossover (SBX) and
    % Polynomial  mutation. Crossover probability pc = 0.9 and mutation
    % probability is pm = 1/n, where n is the number of decision variables.
    % Both real-coded GA and binary-coded GA are implemented in the original
    % algorithm, while in this program only the real-coded GA is considered.
    % The distribution indeices for crossover and mutation operators as mu = 20
    % and mum = 20 respectively.
    mu = 20;
    mum = 20;
    offspring_chromosome = ...
        genetic_operator(parent_chromosome, ...
        M, V, mu, mum, min_range, max_range);
    
    % Intermediate population
    % Intermediate population is the combined population of parents and
    % offsprings of the current generation. The population size is two
    % times the initial population.
    
    [main_pop,temp] = size(chromosome);
    [offspring_pop,temp] = size(offspring_chromosome);
    % temp is a dummy variable.
    clear temp
    % intermediate_chromosome is a concatenation of current population and
    % the offspring population.
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = ...
        offspring_chromosome;
    
    % Non-domination-sort of intermediate population
    % The intermediate population is sorted again based on non-domination sort
    % before the replacement operator is performed on the intermediate
    % population.
    intermediate_chromosome = ...
        non_domination_sort_mod(intermediate_chromosome, M, V);
    % Perform Selection
    % Once the intermediate population is sorted only the best solution is
    % selected based on it rank and crowding distance. Each front is filled in
    % ascending order until the addition of population size is reached. The
    % last front is included in the population based on the individuals with
    % least crowding distance
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop);
    if ~mod(i,100)
        clc
        fprintf('%d generations completed\n',i);
    end
    
    figure(1);
    set(gcf,'Color',[1 1 1]);
    hold off
    plot3( -chromosome(:,V + 1) ,chromosome(:,V + 2),chromosome(:,V + 3),'*');
    grid on
    
    str = sprintf('多目标遗传算法帕累托求解第%d次迭代',i);
    title(   str,'fontsize',13)
    xlabel('目标函数1（max）','fontsize',13,'fontname','Times new roman');
    ylabel('目标函数2（min）','fontsize',13,'fontname','Times new roman');
    zlabel('目标函数3（min）','fontsize',13,'fontname','Times new roman');
    set(gca, 'FontName','Times New Roman');
    set(gca, 'Fontsize',13);
    set(gca, 'LineWidth',2)
end




%% Result display
% Save the result in ASCII text format.
% save solution.txt chromosome -ASCII
figure('NumberTitle', 'off', 'Name', '最终帕累托前沿');

set(gcf,'Color',[1 1 1]);
% 坐标轴格式参数设置
set(gca, 'FontName','Times New Roman');
set(gca, 'Fontsize',12);
set(gca, 'LineWidth',2)

x=linspace( min(-chromosome(:,V + 1)) , max(-chromosome(:,V + 1)) ,100);
y=  linspace( min(chromosome(:,V + 2)) , max(chromosome(:,V + 2))  , 100);
[XI,YI] = meshgrid(x,y);
ZI = griddata(  -chromosome(:,V + 1),  chromosome(:,V + 2)  , chromosome(:,V + 3) ,XI,YI);

mesh( XI,YI,ZI )%, 'FaceColor',[153 153 153]/255 ,'EdgeColor',[153 153 153]/255   );
title('最终帕累托前沿','fontsize',13)
xlabel('目标函数1','fontsize',13,'fontname','Times new roman');
ylabel('目标函数2','fontsize',13,'fontname','Times new roman');
zlabel('目标函数3','fontsize',13,'fontname','Times new roman');
axis( [  min(-chromosome(:,V + 1))  max(-chromosome(:,V + 1))...
    min(chromosome(:,V + 2)) max(chromosome(:,V + 2))...
    min(chromosome(:,V + 3)) max(chromosome(:,V + 3))]); % 设置坐标轴在指定的区间
%%  Result load
temp=[];
for i=1:size(chromosome,1)
    kk=chromosome(i,V+1:V+3);
    if  -kk(1)>3 && kk(2)<10000 &&  kk(3)<100000
        indvid=chromosome(i,1:(M+V));
        indvid(V+1 )=- indvid(V+1 );
        temp=[ temp; indvid];
        
    end
end
if length( temp)==0
    fprintf('未找到符合要求的解，请重新输入初始种群数和迭代次数，重新计算\n');
else
    kkk=' ';
    xlswrite('result.xlsx',kkk,'A1:Z100000')
    xlswrite('result.xlsx',temp);  % 将结果记录在result.xlsx中
     
    coeff=[ 11.34, 3.62 ,19.35 ,7.87,2.7, 18.95, 7.2, 8.9, 7.28, 10.5, 2.34 , 1, 0.93, 7.14, 2 , 2.32, 1.96, 2.30 ,2.79]; % 系数
    kkk=' ';
    xlswrite('resultHD.xlsx',kkk,'A1:Z100000');
    tempp=zeros(size(temp,1),19);
    for j=1:size(temp,1)
        tempp(j,:)= ( temp(j,1:19)* temp(j,20) /1000  ) ./ coeff;
    end
    
    xlswrite('resultHD.xlsx',tempp);  % 将结果记录在resultHD.xlsx中
    
end


