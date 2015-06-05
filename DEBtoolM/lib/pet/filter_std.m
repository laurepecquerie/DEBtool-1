%% filter_std
% filters for allowable parameters of standard DEB model without acceleration

%%
function [filter flag] = filter_std(par, chem)
% created 2014/01/22 by Bas Kooijman; modified 2015/03/17 by Goncalo Marques

%% Syntax
% [filter flag] = <../filter_std.m *filter_std*> (par, chem)

%% Description
% Checks if parameter values are in the allowable part of the parameter
%    space of standard DEB model without acceleration
% Meant to be run in the estimation procedure
%
% Input
%
% * par: structure with parameters (see below)
% * chem: structure with biochemical parameters
%  
% Output
%
% * filter: 0 for hold, 1 for pass
% * flag: indicator of reason for not passing the filter
%
%     0: parameters pass the filter
%     1: some parameter is negative
%     2: some kappa is larger than 1
%     3: growth efficiency is larger than 1
%     4: maturity levels do not increase during life cycle
%     5: puberty cannot be reached

%% Remarks
%  The theory behind boundaries is discussed in 
%    <http://www.bio.vu.nl/thb/research/bib/LikaAugu2013.html LikaAugu2013>.

  filter = 0; flag = 0; % default setting of filter and flag
  
  % unpack par, chem
  v2struct(par); v2struct(chem);

  parvec = [z; v; kap; p_M; E_G; k_J; E_Hb; E_Hp; kap_R; h_a; s_G];
  
  if sum(parvec <= 0) > 0 % all pars must be positive
    flag = 1;
    return;
  elseif p_T < 0
    flag = 1;
    return;
  end

  if E_Hb >= E_Hp % maturity at birth, puberty
    flag = 4;
    return;
  end

  if f > 1
    flag = 2;
    return;
  end

  parvec = [kap; kap_R];
  
  if sum(parvec >= 1) > 0 
    flag = 2;
    return;
  end

  % compute and unpack cpar (compound parameters)
  cpar = parscomp_st(par, chem);
  v2struct(cpar);

  if kap_G >= 1 % growth efficiency
    flag = 3;    
    return;
  end

  if k * v_Hp >= f^3 % constraint required for reaching puberty
    flag = 5;    
    return;
  end

  filter = 1;
