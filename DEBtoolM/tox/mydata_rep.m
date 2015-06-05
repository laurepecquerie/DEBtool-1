%  Created at 2002/02/15 by Bas Kooijman
% Toxic effects on reproduction; five modes of action
%   asrep: assimilation capacity
%   marep: maintenance costs
%   grrep: growth costs
%   corep: costs per offspring
%   harep: survival per offspring
% Data from DEBtox example 4: OECD ring test 1996

t = [1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21]'; % days
c = [0.00  0.20  0.40  0.80  1.00  2.00]';          % cadmium mM
N = [0.000   0.000   0.000   0.000   0.000   0.000; % Daphnia magna 
     0.000   0.000   0.000   0.000   0.000   0.000; % offspring per female
     0.000   0.000   0.000   0.000   0.000   0.000; 
     0.000   0.000   0.000   0.000   0.000   0.000;
     0.000   0.000   0.000   0.000   0.000   0.000;
     0.000   0.000   0.000   0.000   0.000   0.000;
     1.400   0.800   1.800   0.000   0.900   0.000;
     3.600   1.300   2.300   2.600   2.800   2.600;
     10.400  13.600   7.000   5.100   5.400   3.900;
     20.400  16.600  13.800  12.000   7.800   4.800;
     22.800  18.900  13.800  14.500   7.800   4.800;
     31.200  27.000  14.700  14.500   7.800   4.800;
     41.500  35.500  20.800  15.600   9.300   4.800;
     43.400  37.900  20.800  15.600   9.300   4.800;
     53.000  44.700  24.100  15.600   9.300   4.800;
     64.100  48.300  29.700  16.800  10.000   5.244;
     66.800  51.000  31.200  16.800  11.300   5.244;
     75.900  58.300  39.500  17.000  11.300   5.244;
     88.100  66.900  45.300  21.300  11.300   5.244;
     90.600  72.000  47.600  21.700  11.300   5.244;
     98.700  76.200  53.000  21.700  11.300   5.244];

path(path,'../lib/regr/');

shregr2_options('plotnr',1);

 par = [1e-3 10.6 1e-1 14.7 .1 0.13 0.42 1; 1 1 1 1 0 0 0 0]';
 p = nmregr2('asrep',par,t,c,N);
 shregr2('asrep',p,t,c,N);
 [cov cor sd] = pregr2('asrep',p,t,c,N);

% par = [1e-6 0.87 0.33 14.04 .1 0.13 0.42 1; 0 1 1 0 0 0 0 0]';
% p = nmregr2('marep',par,t,c,N);
% shregr2('marep',p,t,c,N);
% [cov cor sd] = pregr2('marep',p,t,c,N);

% par = [1e-6 2.27 1e-6 14.14 .1 0.13 0.42 1; 0 1 1 0 0 0 0 0]';
% p = nmregr2('grrep',par,t,c,N);
% shregr2('grrep',p,t,c,N);
% [cov cor sd] = pregr2('grrep',p,t,c,N);

% par = [1e-6 1e-6 1e-6 14.4 .1 0.13 0.42 1; 1 1 1 1 0 0 0 0]';
% p = nmregr2('corep',par,t,c,N);
% shregr2('corep',p,t,c,N);
% [cov cor sd] = pregr2('corep',p,t,c,N);

% par = [1e-6 1e-6 1e-6 14.4 .1 0.13 0.42 1; 1 1 1 1 0 0 0 0]';
% p = nmregr2('harep',par,t,c,N);
% shregr2('harep',p,t,c,N);
% [cov cor sd] = pregr2('harep',p,t,c,N);

[p(:,1) sd]
