%% mydata_my_pet
% Sets referenced data

%%
function [data, txt_data, metadata] = mydata_my_pet 
  % created by Starrlight Augustine, Bas Kooijman, Dina Lika, Goncalo Marques and Laure Pecquerie 2015/03/31
  
  %% Syntax
  % [data, txt_data, metadata] = <../mydata_my_pet.m *mydata_my_pet*>
  
  %% Description
  % Sets data, pseudodata, metadata, explanatory text, weight coefficients.
  % Meant to be a template in add_my_pet
  %
  % Output
  %
  % * data: structure with data
  % * txt_data: text vector for the presentation of results
  % * metadata: structure with info about this entry
  
  %% To do (remove these remarks after editing this file)
  % * copy this template; replace 'my_pet' by the name of your species
  % * fill in metadata fields with the proper information
  % * insert references for the data (an example is given)
  % * edit fact-list for your species, where you can add species and/or data properties
  % * edit real data; remove all data that to not belong to your pet
  % * complete reference list
  % * OPTIONAL : add discussion points / comments before the reference list

%% set metadata

T_C = 273.15; % K, temperature at 0 degrees C (used in T_typical)

metadata.phylum     = 'phylum'; 
metadata.class      = 'class'; 
metadata.order      = 'order'; 
metadata.family     = 'family';
metadata.species    = 'my_pet'; 
metadata.species_en = 'my_pet_english_name'; 
metadata.T_typical  = T_C + 20; % K
metadata.data_0     = {'ab'; 'ap'; 'am'; 'Lb'; 'Lp'; 'Li'; 'Wdb'; 'Wdp'; 'Wdi'; 'Ri'};  % tags for different types of zero-variate data
metadata.data_1     = {'t-L', 'L-W'}; % tags for different types of uni-variate data

metadata.COMPLETE = 2.5; % using criteria of LikaKear2011

metadata.author   = {'author1'};                              % put names as authors as separate strings:  {'author1','author2'} , with corresponding author in first place 
metadata.date_acc = [2015 04 20];                             % [year month day], date of entry is accepted into collection
metadata.email    = {'myname@myuniv.univ'};                   % e-mail of corresponding author
metadata.address  = {'affiliation, zipcode, country'};        % affiliation, postcode, country of the corresponding author

% uncomment and fill in the following fields when the entry is updated:
% metadata.author_mod_1  = {'author2'};                       % put names as authors as separate strings:  {'author1','author2'} , with corresponding author in first place 
% metadata.date_mod_1    = [2017 09 18];                      % [year month day], date modified entry is accepted into the collection
% metadata.email_mod_1   = {'myname@myuniv.univ'};            % e-mail of corresponding author
% metadata.address_mod_1 = {'affiliation, zipcode, country'}; % affiliation, postcode, country of the corresponding author

%% set data
% zero-variate data;
% typically depend on scaled functional response f.
% here assumed to be equal for all real data; the value of f is specified in pars_init_my_pet.

% age 0 is at onset of embryo development
data.ab = 15;      units.ab = 'd';    label.ab = 'age at birth';                bibkey.ab = 'MollCano2015';    
  temp.ab = T_C + 20;  % K, temperature 
  % observed age at birth is frequently larger than ab, because of diapauzes during incubation
data.ap = 261;     units.ap = 'd';    label.ap = 'age at puberty';              bibkey.ap = 'Anon2015';
  temp.ap = T_C + 20;  % K, temperature 
  % observed age at puberty is frequently larger than ap, 
  %   because allocation to reproduction starts before first eggs appear
data.am = 591;     units.am = 'd';    label.am = 'life span';                   bibkey.am = 'Wiki';   
  temp.am = T_C + 20;  % K, temperature 
% (accounting for aging only) 

% Please specify what type of length measurement is used for your species.
% We put here snout-to-vent length, but you should change this depending on your species:
data.Lb  = 0.45;   units.Lb  = 'cm';   label.Lb  = 'snout to vent length at birth';    bibkey.Lb  = 'Anon2015';
data.Lp  = 2.36;   units.Lp  = 'cm';   label.Lp  = 'snout to vent length at puberty';  bibkey.Lp  = {'Anon2015';'Wiki'};
data.Li  = 6.25;   units.Li  = 'cm';   label.Li  = 'ultimate snout to vent length';    bibkey.Li  = 'Wiki';
data.Wdb = 5.8e-5; units.Wdb = 'g';    label.Wdb = 'dry weight at birth';              bibkey.Wdb = 'Anon2015';
data.Wdp = 8e-3;   units.Wdp = 'g';    label.Wdp = 'dry weight at puberty';            bibkey.Wdp = 'Anon2015';
data.Wdi = 0.15;   units.Wdi = 'g';    label.Wdi = 'ultimate dry weight';              bibkey.Wdi = 'Wiki';
data.Ri  = 2.3;    units.Ri  = '#/d';  label.Ri  = 'maximum reprod rate';              bibkey.Ri  = 'Wiki';   
  % for an individual of ultimate length Li 
  temp.Ri = T_C + 20;  % K, temperature 
 
% uni-variate data

% uni-variate data at f = 0.8 (this value should be added in pars_init_my_pet as a parameter f_tL) 
% snout-to-vent length and wet weight were measured at the same time
data.tL = [0     50  100 200 300 400 500 600;    % d, time since birth
           0.45  1.1 1.7 2.7 3.4 4.0 4.5 4.9]';  % cm, snout-to-vent length at f and T
units.tL = {'d', 'cm'};     label.tL = {'time since birth', 'snout to vent length'};  bibkey.tL = 'Anon2015';
  temp.tL = T_C + 25;  % K, temperature

data.LW = [0.9 1.8 3.2 4.3 5.0;      % cm, snout-to-vent length at f
           0.004 0.03 0.20 0.55 1.1]';   % g, wet weight at f and T
units.LW = {'cm', 'g'};     label.LW = {'snout to vent length', 'wet weight'};  bibkey.LW = 'Anon2015';

%% set weights for all real data
weight = setweights(data, []);

%% overwriting weights (remove these remarks after editing the file)
% the weights were set automatically with the function setweigths,
% if one wants to ovewrite one of the weights it should always present an explanation example:
%
% zero-variate data:
% weight.Wdi = 100 * weight.Wdi; % Much more confidence in the ultimate dry
%                                % weight than the other data points
% uni-variate data: 
% weight.tL = 2 * weight.tL;

%% set pseudodata and respective weights
% (pseudo data are in data.psd and weights are in weight.psd)
[data, units, label, weight] = addpseudodata(data, units, label, weight);

%% overwriting pseudodata and respective weights (remove these remarks after editing the file)
% the pseudodata and respective weights were set automatically with the function setpseudodata
% if one wants to ovewrite one of the values it should always present an explanation
% example:
% data.psd.p_M = 1000;                    % my_pet belongs to a group with high somatic maint 
% weight.psd.kap = 10 * weight.psd.kap;   % I need to give this pseudo data a higher weight

%% pack data and txt_data for output
data.weight = weight;
data.temp = temp;
txt_data.units = units;
txt_data.label = label;
txt_data.bibkey = bibkey;

%% References
  bibkey = 'Wiki'; type = 'Misc'; bib = ...
  'URL = {http://en.wikipedia.org/wiki/my_pet}';   % replace my_pet by latin species name
  eval(['metadata.biblist.' bibkey, '= ''@', type, '{', bibkey, ', ' bib, '}'';']);
  %
  bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
  'author = {Kooijman, S.A.L.M.}, ' ...
  'year = {2010}, ' ...
  'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
  'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
  'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
  'URL = {http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}'];
  eval(['metadata.biblist.' bibkey, '= ''@', type, '{', bibkey, ', ' bib, '}'';']);
  %
  bibkey = 'MollCano2010'; type = 'Article'; bib = [ ... % meant as example; replace this and further bib entries
  'author = {M{\o}ller, L. F. and Canon, J. M. and Tiselius, P.}, ' ... 
  'year = {2010}, ' ...
  'title = {Bioenergetics and growth in the ctenophore Pleurobrachia pileus}, ' ...
  'journal = {Hydrobiologia}, ' ...
  'volume = {645}, ' ...
  'pages = {167--178}'];
  eval(['metadata.biblist.' bibkey, '= ''@', type, '{', bibkey, ', ' bib, '}'';']);
  %
  bibkey = 'Anon2015'; type = 'Misc'; bib = [ ...
  'author = {Anonymous}, ' ...
  'year = {2015}, ' ...
  'URL = {http://www.fishbase.org/summary/Rhincodon-typus.html}'];
  eval(['metadata.biblist.' bibkey, '= ''@', type, '{', bibkey, ', ' bib, '}'';']);

%% Facts
% * Standard model with egg (not foetal) development and no acceleration
  
%% Discussion points
pt1 = 'Author_mod_1: I found information on the number of eggs per female as a function of length in Anon2013 that was much higher than in Anon2015 but chose to not include it as the temperature was not provided';
pt2 = 'Author_mod_1: I was surprised to observe that the weight coefficient for ab changed so much the parameter values';     
metadata.discussion = {pt1; pt2}; 

