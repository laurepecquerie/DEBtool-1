%% fig:dir_effects
%% bib: Data from OECD ring test
%% out:m1l02c1,m2l02c1
%% Effect of cadmium on reproduction of Daphnia magna

t = (1:21)'; % d
c = [0 .2 .4 .8 1 2]'; % mug/l

%% c = 0; reproduction of 10 individuals
R0 = [0 0 0 0 0 0 4 0  0 24  0  0 32  0  0 22  0  0 27  0  0;
      0 0 0 0 0 0 5 0 11  0  0 29  0  0 27  0  0 26  0  0 26;
      0 0 0 0 0 0 0 0 14  0  0 17  0  0 23  0  0 26  0  0 25;
      0 0 0 0 0 0 0 0  0 22  0  0 26  0  0 24  0  0 25  0  0;
      0 0 0 0 0 0 5 0  0 26  0  0 25  0  0 25  0  0 20  0  0;
      0 0 0 0 0 0 0 0 24  0  0 18  0  0 21  0  0 18  0  0 11;
      0 0 0 0 0 0 0 0  0  6  0  0 12  0  0 24  0  0 23  0  0;
      0 0 0 0 0 0 0 0 19  0  0 20  0  0 25  0  0 21  0  0 19;
      0 0 0 0 0 0 0 14 0  0 24  0  0 19  0  0 27  0  0 25  0;
      0 0 0 0 0 0 0  8 0 22 0   0  8  0  0 16  0  0 27  0  0];

%% c = 0; survival of 10 individuals
S0 = [1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1;
      1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1];

%% c = 0.2; reproduction of 10 individuals
R2 = [0 0 0 0 0 0 0 5 0 0 23 0 0 24 0 0 27 0 0 25 0;
      0 0 0 0 0 0 0 0 11 0 0 0 3 0 0 8 0 0 24 0 0;
      0 0 0 0 0 0 2 0 0 14 0 0 26 0 0 19 0 0 22 0 0;
      0 0 0 0 0 0 0 0 0 11 0 0 7 0 0 2 0 0 2 26 0;
      0 0 0 0 0 0 0 0 14 0 0 0 25 0 0 0 0 0 14 0 0;
      0 0 0 0 0 0 1 0 15 5 0 0 24 0 0 0 0 0 17 0 0;
      0 0 0 0 0 0 0 0 20 0 0 14 0 0 18 0 0 22 0 0 23;
      0 0 0 0 0 0 4 0 11 0 0 29 0 0 24 0 0 29 0 0 19;
      0 0 0 0 0 0 1 0 28 0 0 15 0 0 0 7 0 0 7 0 0;
      0 0 0 0 0 0 0 0 24 0 0 23 0 0 26 0 0 22 0 0 0];

%% c = 0.2; survival of 10 individuals
S2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

%% c = 0.4; reproduction of 10 individuals
R4 = [0 0 0 0 0 0 0 0 15 0 0 8 0 0 14 0 0 22 0 0 16;
      0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 14 15 0 0 23 0;
      0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 27 0 0 29;
      0 0 0 0 0 0 10 0 3 15 0 0 9 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 16 0 0 11 0 0 8 0 0 31 0 0;
      0 0 0 0 0 0 4 0 0 10 0 0 0 0 0 8 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 10 0 0 14 0 0 0 0 0 1 0 0;
      0 0 0 0 0 0 4 0 0 12 0 0 13 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 5 0 0 14 0 0 26 0 0 26 0 0;
      0 0 0 0 0 0 0 0 11 0 0 1 0 0 19 0 0 34 0 0 9];

%% c = 0.4; survival of 10 individuals
S4 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

%% c = 0.8; reproduction of 10 individuals
R8 = [0 0 0 0 0 0 0 0 0 10 0 0 0 0 0 12 0 0 23 0 0;
      0 0 0 0 0 0 0 9 0 0 14 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 8 0 15 11 0 0 0 0 0 0 0 0 3 0;
      0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 12 0 0 11 0 0 0 0 2 20 1 0;
      0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0];

%% c = 0.8; survival of 10 individuals
S8 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

%% c = 1; reproduction of 10 individuals
R10 = [0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 1 0 13 0 0 15 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 5 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 13 0 0 0 0;
       0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0];

%% c = 1; survival of 10 individuals
S10 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

%% c = 2; reproduction of 10 individuals
R20 = [0 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 4 0 0 0 0 0;
       0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0];

%% c = 2; survival of 10 individuals
S20 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
       1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

%% reformat data for parameter estimation
%% mean cumulated offspring per female; time (dim 1) versus conc (dim 2)
R = [sum(R0,1); sum(R2,1); sum(R4,1); sum(R8,1); sum(R10,1); sum(R20,1)]';
S = [sum(S0,1); sum(S2,1); sum(S4,1); sum(S8,1); sum(S10,1); sum(S20,1)]';
R = cumsum(R ./ S, 1);

par_txt = {'NEC'; 'tolerance conc'; 'elimination rate'; ...
	   'allocation fraction'; 'reprod efficiency'; 'investment ratio'; ...
	   'mat rate coeff'; 'som rate coeff'; 'energy conductance'; ...
           'scaled mat at birth'; 'scaled mat at puberty'; 'init body length'};

p_ha = [ .017 1;  .1003 1; 0.05 1;
	   .8 0;   .95 0;  .15 0;
	  3.6 0;   4.1 0; 1.62 0;
	 .002 1;  .119 1;  0.8 0];

nrregr_options('max_step_number',20)
nmregr_options('default')

p_ha = nmregr2('harep', p_ha, t, c, R);
[cov, cor, sd, ssq] = pregr2('harep', p_ha, t, c, R);
fprintf('hazard model \n');
printpar(par_txt, p_ha, sd);

shregr2_options('plotnr',1);

%% gset output 'm1l02c1.ps'

shregr2('harep',p_ha, t, c, R);
title('D. magna in cadmium; hazard model')

fprintf('hit a key to proceed \n');
pause;

p_co = [ .017 1; .023 1;.0138 1;
	   .8 0;  .95 0;  .15 0;
	  3.6 0;  4.1 0; 1.62 0;
	.0022 1; .126 1;  0.8 0];
p_co = nmregr2('corep', p_co, t, c, R);
[cov, cor, sd, ssq] = pregr2('corep', p_co, t, c, R);
fprintf('costs model \n');
printpar(par_txt, p_co, sd);

%% gset output 'm2l02c1.ps'
shregr2('corep',p_co, t, c, R);
title ('D. magna in cadmium; costs model')


