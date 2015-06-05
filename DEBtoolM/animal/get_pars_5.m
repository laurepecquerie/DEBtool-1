%% get_pars_5
%  Obtains 5 DEB parameters from 5 data points at abundant food

%%
function par = get_pars_5(data, fixed_par, chem_par)
  % created 2015/01/18 by Bas Kooijman
  
  %% Syntax
  % par = <../get_pars_5.m *get_pars_5*>(data, fixed_par, chem_par)
  
  %% Description
  %  Obtains 5 DEB parameters from 5 data points at abundant food
  %
  % Input
  %
  % * data: 5-vector with zero-variate data
  % 
  %     d_V: g/cm^3 specific density of structure
  %     W_b: g, wet weight at birth
  %     W_p: g, wet weight at puberty
  %     W_m: g, maximum wet weight
  %     R_i: 1/d, maximum reprod rate
  %
  % * fixed_par: optional 5 vector with v, p_M, k_J, kap_R, kap_G
  % * chem_par: optional 4 vector with w_V, w_E, mu_V, mu_E
  %  
  % Output
  %
  % * par: 5-vector with DEB parameters
  %
  %     p_Am: J/d.cm^2,  {p_Am}, max specific assimilation rate
  %     kap: -, allocation fraction to soma 
  %     E_G: J/cm^3, [E_G] specific cost for structure
  %     E_Hb: J, E_H^b, maturity at birth 
  %     E_Hp: J, E_H^p, maturity at puberty 
  
  %% Remarks
  % Assumes absence of acceleration
  % The theory behind this mapping is discussed in 
  %    <http://www.bio.vu.nl/thb/research/bib/LikaAugu2014.html LikaAugu2014>.
  % See also 
  %  <get_pars_2a.html *get_pars_2a*>,
  %  <get_pars_3.html *get_pars_3*>,
  %  <get_pars_4.html *get_pars_4*>,
  %  <get_pars_5.html *get_pars_5*>,
  %  <get_pars_6.html *get_pars_6*>,
  %  <get_pars_6a.html *get_pars_6a*>,
  %  <get_pars_7.html *get_pars_7*>,
  %  <get_pars_8.html *get_pars_8*>,
  %  <get_pars_9.html *get_pars_9*>.

  %% Example of use
  %  See <../mydata_get_par_2_9.m *mydata_get_par_2_9*>

  %  assumptions:
  %  abundant food (f=1)
  %  absence of acceleration
  %  R_m is temp-corrected to T_ref = 293 K
  %  {p_T} = 0     % J/d.cm^2, surf-spec som maint
  if ~exist('fixed_par', 'var')
     v = 0.02;             % cm/d, energy conductance
     p_M = 18;             % J/d.cm^3, [p_M], vol-specific somatic maintenance
     k_J = 0.002;          % 1/d, mat maint rate coeff
     kap_R = 0.05;         % -, reprod efficiency
     kap_G = 0.80;         % -, growth efficiency
  else % 
     v    = fixed_par(1);  % cm/d, energy conductance
     p_M  = fixed_par(2);  % J/d.cm^3, [p_M], vol-specific somatic maintenance
     k_J  = fixed_par(3);  % 1/d, mat maint rate coeff
     kap_R= fixed_par(4);  % -, reprod efficiency
     kap_G= fixed_par(5);  % -, growth efficiency
  end
  
  if exist('chem_par', 'var') == 0
  %  C:H:O:N = 1:1.8:0.5:0.15
     w_V = 23.9;   % g/C-mol, molecular weight of structure
     w_E = 23.9;   % g/C-mol, molecular weight of reserve
     mu_V = 5E5;   % J/C-mol, chemical potential of structure
     mu_E = 5.5E5; % J/C-mol, chemical potential of reserve
  else
     w_V = chem_par(1); w_E = chem_par(2); mu_V = chem_par(3); mu_E = chem_par(4);
  end

  % unpack data
  d_V = data(1); % g/cm^3, specific density of structure
  W_b = data(2); % g, wet weight at birth
  W_p = data(3); % g, wet weight at puberty
  W_m = data(4); % g, maximum wet weight
  R_i = data(5); % 1/d, max reprod rate
  
  E_G = d_V * mu_V/ kap_G/ w_V;% J/cm^3, [E_G] cost for structure
  k_M = p_M/ E_G;              % 1/d, som maint rate coeff
  k = k_J/ k_M;                % -, maintenance ratio
  l_b = (W_b/ W_m)^(1/3);      % -, scaled length at birth
  l_p = (W_p/ W_m)^(1/3);      % -, scaled length at puberty

  E_G = d_V * mu_V/ kap_G/ w_V;% J/cm^3, [E_G] costs for structure
  B = w_E/ v/ d_V/ mu_E;       % d.cm^^2/J, temporary compound par
  kap = fzero(@fnget_kap, 0.8, [], l_b, l_p, W_m, R_i, v, p_M, E_G, k, kap_R, B);
  
  p_Am0 = W_m^(1/3) * p_M/ kap; % J/d.cm^2, starting value for p_Am
  A = p_M^3 * W_m/ kap^3; B = w_E/ v/ d_V/ mu_E; % set compound pars
  p_Am = fzero(@(p_Am) A - p_Am^3 * (1 + B * p_Am), p_Am0); % solve W_m = L_m^3 (1 + w)

  L_m = kap * p_Am/ p_M;  % cm, max structural length
  g = E_G * v/ p_Am/ kap; % -, energy investment ratio
  
  v_Hb = fzero(@(v_Hb) l_b - get_lb([g; k; v_Hb]), l_b^3); % -, scaled maturity at birth
  E_Hb = v_Hb * (1 - kap) * L_m^3 * E_G/ kap;              % J, maturity at birth
  
  v_Hp = fzero(@(v_Hp) l_p - get_lp([g; k; 0; v_Hb; v_Hp]), l_p^3); % -, scaled maturity at birth
  E_Hp = v_Hp * (1 - kap) * L_m^3 * E_G/ kap;                       % J, maturity at birth
    
  par = [p_Am; kap; E_G; E_Hb; E_Hp]; % pack output 

end

% subfunctions

function f = fnget_kap(kap, l_b, l_p, W_m, R_i, v, p_M, E_G, k, kap_R, B)

  k_M = p_M/ E_G;                                           % 1/d, som maint rate coeff
  p_Am0 = W_m^(1/3) * p_M/ kap;                             % J/d.cm^2, starting value for p_Am
  A = p_M^3 * W_m/ kap^3;                                   % set compound pars
  p_Am = fzero(@(p_Am) A - p_Am^3 * (1 + B * p_Am), p_Am0); % solve W_m = L_m^3 (1 + w)
  g = E_G * v/ p_Am/ kap;                                   % -, energy investment ratio  
  v_Hb = fzero(@(v_Hb) l_b - get_lb([g; k; v_Hb]), l_b^3);  % -, scaled maturity at birth  
  v_Hp = fzero(@(v_Hp) l_p - get_lp([g; k; 0; v_Hb; v_Hp]), l_p^3); % -, scaled maturity at birth  
  u_E0 = get_ue0([g; k; v_Hb]);
  f = R_i - kap_R * k_M * (1 - k * v_Hp) * (1 - kap)/ u_E0; % 1/d, max reprod rate eqn (2.58) of DEB3
end
