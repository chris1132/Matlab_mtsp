function f = evaluate_objective(x, M, V)
%% function f = evaluate_objective(x, M, V)
% Function to evaluate the objective functions for the given input vector
% x. x is an array of decision variables and f(1), f(2), etc are the
% objective functions. The algorithm always minimizes the objective
% function hence if you would like to maximize the function then multiply
% the function by negative one. M is the numebr of objective functions and
% V is the number of decision variables. 
%
% This functions is basically written by the user who defines his/her own
% objective function. Make sure that the M and V matches your initial user
% input. Make sure that the 
%
% An example objective function is given below. It has two six decision
% variables are two objective functions.

% f = [];
% %% Objective function one
% % Decision variables are used to form the objective function.
% f(1) = 1 - exp(-4*x(1))*(sin(6*pi*x(1)))^6;
% sum = 0;
% for i = 2 : 6
%     sum = sum + x(i)/4;
% end
% %% Intermediate function
% g_x = 1 + 9*(sum)^(0.25);
% 
% %% Objective function two
% f(2) = g_x*(1 - ((f(1))/(g_x))^2);

%% Kursawe proposed by Frank Kursawe.
% Take a look at the following reference
% A variant of evolution strategies for vector optimization.
% In H. P. Schwefel and R. M鋘ner, editors, Parallel Problem Solving from
% Nature. 1st Workshop, PPSN I, volume 496 of Lecture Notes in Computer 
% Science, pages 193-197, Berlin, Germany, oct 1991. Springer-Verlag. 
%
% Number of objective is two, while it can have arbirtarly many decision
% variables within the range -5 and 5. Common number of variables is 3.
%{
f = [];
% Objective function one
sum = 0;
for i = 1 : V - 1
    sum = sum - 10*exp(-0.2*sqrt((x(i))^2 + (x(i + 1))^2));
end
% Decision variables are used to form the objective function.
f(1) = sum;

% Objective function two
sum = 0;
for i = 1 : V
    sum = sum + (abs(x(i))^0.8 + 5*(sin(x(i)))^3);
end
% Decision variables are used to form the objective function.
f(2) = sum;

%% Check for error
if length(f) ~= M
    error('The number of decision variables does not match you previous input. Kindly check your objective function');
end
%}
f = [];
% 目标函数 1
f(1)= -( x(1)*5.549+x(2)*2.195+x(3)*4.437+x(4)*0.3717+x(5)*0.1704+x(6)*1.955+...
    x(7)*0.3166+x(8)*0.4585+x(9)*1.677+x(10)*1.47+x(11)*0.1391+x(12)*0.1707...
    +x(13)*0.1719+x(14)*0.4973+x(15)*0.1514+x(16)*0.1835+x(17)*0.202+x(18)*0.1725+x(19)*0.183  );

% 目标函数 2
f(2)=(x(1)*11.34+x(2)*3.62+x(3)*19.35+x(4)*7.87+x(5)*2.7+x(6)*18.95+x(7)*7.2...
    +x(8)*8.9+x(9)*7.28+x(10)*10.5+x(11)*2.34+x(12)*1+x(13)*0.93+x(14)*7.14...
    +x(15)*2+x(16)*2.32+x(17)*1.96+x(18)*2.30+x(19)*2.79)*1000;

% 目标函数 3
f(3)=f(2)*(x(1)*13.15+x(2)*4.5+x(3)*210+x(4)*3+x(5)*10.93+x(6)*420+x(7)*58+...
    x(8)*36.2+x(9)*95.5+x(10)*32.1+x(11)*7+x(12)*0.003+x(13)*9.8+x(14)*12.95+...
    x(15)*7.4+x(16)*10.9+x(17)*1.5+x(18)*0.14+x(19)*0.03);




