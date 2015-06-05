function dX = dstate4 (t, X_t)
  %% Differential equations for generalized reactor; obligate symbiosis
  %% Internal population of species 2 only; mantle still for conc gradient

  global h1_V h2_V h1_S h2_S h1_P h2_P h J1_Sr J2_Sr S1_r S2_r ...
      k1_E k2_E k1_M k2_M ... % res turnover, maintenance
      k1 k2 ... % max assimilation
      b1_S b2_S b1_P b2_P b1s_P ... % uptake
      b2_Sm b2_mS b2_Ss b2_sS ... % substrate transport
      b1_Pm b1_mP b2_Pm b2_mP b1_Ps b1_sP b2_Ps b2_sP ... % product transport 
      y1_EV y2_EV y1_es y2_es y1_ep y2_ep ... % y_es = y_Et/y_St; y_ep = y_Et/y_Pt
      y1_PS y2_PS y1_PP y2_PP y1_PM y2_PM y1_PG y2_PG ... % product yields
      istate; % initial values of state variables

  %% unpack state vector for easy reference
  %% Si, Sim, Sis: substrate i in free space, mantle, internal
  S1=X_t(1);  S2=X_t(2);  S2m=X_t(3);  S2s=X_t(4);
  %% Pi, Pim, Pis: product i in free space, mantle, internal
  P1=X_t(5); P1m=X_t(6); P1s=X_t(7);  P2=X_t(8); P2m=X_t(9); P2s=X_t(10);
  %% V1,m1: species 1; Vs,ms: internal species 2
  V1=X_t(11); m1=X_t(12); Vs=X_t(13); ms=X_t(14);

  %% help variables for internal species 2
  a1 = b2_S*S2s; a2 = b2_P*P1s;
  j2_Es = 1/(1/k2 + 1/a1 + 1/a2 - 1/(a1+a2));
  j2_Ss = j2_Es/y2_es;
  j21_Ps = j2_Es/y2_ep;
  rs = (k2_E*ms - k2_M*y2_EV)/(ms + y2_EV); % spec growth rate
  j2_Ps = y2_PS*j2_Ss + y2_PP*j21_Ps + y2_PM*k2_M + y2_PG*max(1e-4,rs);

  %% help variables for species 1
  a1 = b1_S*S1; a2 = b1_P*P2m + b1s_P*P2s; 
  j1_E = 1/(1/k1 + 1/a1 + 1/a2 - 1/(a1+a2));
  j1_S = j1_E/y1_es;
  j12_P = j1_E/y1_ep;
  j12_Pm = j12_P*b1_P*P2m/a2; j12_Ps = j12_P - j12_Pm;
  r1 = (k1_E*m1 - k1_M*y1_EV)/(m1 + y1_EV); % spec growth rate
  j1_Ps = y1_PS*j1_S + y1_PP*j12_P + y1_PM*k1_M + y1_PG*max(1e-4,r1);

  dX = zeros(14,1); % create 14-vector for output

  %% oscillating input
  %%  J1_Srt = J1_Sr*(0.5+sin(t/50)); J2_Srt = J2_Sr*(0.5+sin(t/50));
  
  %% conc substrate 
  dX(1) = J1_Sr - h1_S*S1 - j1_S*V1;  % substr 1
  dX(2) = J2_Sr - h2_S*S2 - b2_Sm*S2*V1 + b2_mS*S2m*V1;
				      % free substr 2
  dX(3) = - h2_S*S2m + b2_Sm*S2*V1 - b2_mS*S2m*V1 ...
     + b2_Ss*S2s*V1 - b2_sS*S2m*V1;    % mantle substr 2
  dX(4) = - h2_S*S2s - j2_Ss*Vs - b2_Ss*S2s*V1 + b2_sS*S2m*V1;
				      % internal substr 2

  %% conc product 
  dX(5) = - h1_P*P1 - b1_Pm*P1*V1 + b1_mP*P1m*V1;
				      % free product 1
  dX(6) = - h1_P*P1m + b1_Pm*P1*V1 - b1_mP*P1m*V1 ...
     - b1_Ps*P1m*V1 + b1_sP*P1s*V1;   % mantle product 1
  dX(7) = j1_Ps*V1 - j21_Ps*Vs - h1_P*P1s + b1_Ps*P1m*V1 - b1_sP*P1s*V1;
				      % internal product 1
  dX(8) = - h2_P*P2 - b2_Pm*P2*V1 + b2_mP*P2m*V1;
				      % free product 2
  dX(9) =  - j12_Pm*V1 - h2_P*P2m + b2_Pm*P2*V1 - b2_mP*P2m*V1 ...
     - b2_Ps*P2m*V1 + b2_sP*P2s*V1;   % mantle product 2
  dX(10) = j2_Ps*Vs - j12_Ps*V1 - h2_P*P2s + b2_Ps*P2m*V1 - b2_sP*P2s*V1;
				      % internal product 2

  %% conc structure, res density species 1
  dX(11) = (r1 - h1_V)*V1; 
  dX(12) = j1_E - k1_E*m1;

  %% conc structure, res density internal species 2
  dX(13) = (rs - h2_V)*Vs; 
  dX(14) = j2_Es - k2_E*ms;