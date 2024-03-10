%% Fibonacci Bees Algorithm (BAF) for Travelling Salesman Problem
% by Natalia Hartono
% This code accompanied the article:
% 'A Comparative Study of Reduced Parameter Versions of the Bees Algorithm 
% for Traveling Salesman Problem'
% Natalia Hartono, Hamid Suluova, Fatih M Eker, Sultan Zeybek, Mario Caterino
% doi
%
% This code is modified from basic bees algorithm in TSP problem, article:
% 'Using the Bees Algorithm to solve combinatorial optimisation problems for
% TSPLIB' (Ismail et al., 2020), doi:10.1088/1757-899X/1/012027
% 
% To cite this code: 
% [The code is available for testing by reviewers/users but will be made fully 
% accessible after acceptance.]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;

%% Problem Definition
% User choice
typeOfFunction = getUserChoice();

% Create an instance
Instance = Tsplib(typeOfFunction);
Dims=Instance.dim;                              % dim = decision variables
ObjFunction=@(x) Instance.evaluation( x );      % Objective Function
VarSize=[1 Dims];                                     

%% Stopping Criterion
MaxEval = input('Enter the maximum number of function evaluations (recommendation 2000000): ');

%% Fibonacci Bees Algorithm Parameters
% There are four parameters to set:
% 1. Number of Scout Bees (in the article it was explained to have the same 
%    number of population with the basic bees algorithm and other version
nScoutBee =96;       

% 2. Selected sites (m) for local search
nSelectedSite=20;      

% 3. Number of bees recruited for selected sites following Fibonacci sequence
%    note: max_nr following Fibonacci sequence, in this article, max_nr=144, 
%    with 20 m sites, therefore the nr following Fibonacci sequence as below.
nrpersite = [144,89,55,34,21,13,8,5,3,2,1,1,1,1,1,1,1,1,1,1];  

% 4. Maximum number of re-visits before the nr is set to zero
max_rv = 100;                    

%% Run the BAF
FibonacciBeesAlgorithm;
