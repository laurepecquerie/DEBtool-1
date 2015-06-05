function X = findstatec0_mixo (X_t)
  %% routine called from gstate0_mixo
  %% Differential equations for closed 0-reserve mixotroph system

  global j_L_F Ctot Ntot j_V_Am j_L_FK K_C K_N K_NV K_D rho_A rho_H ...
    k_A k_H z_C z_CH z_N y_DV k_M h n_NV 

  %% unpack state vector for easy reference
  C = X_t(1); D = X_t(2);
  V = Ctot - C - D;
  N = Ntot - n_NV*D - n_NV*V;

  %% help variables 

  f_C = C/ (K_C + C);
  a = z_C * f_C; b = -j_L_F/ j_L_FK;
  f_CH = (1 + 1/z_C)/ (1 + 1/a + 1/b - 1/(a + b));

  f_N = N/ (K_N + N);
  a = z_N * f_N; b = z_CH * f_CH;
  j_VA_AA = j_V_Am * (1 + 1/z_N + 1/z_CH - 1/(z_N + z_CH))/ ...
  (1 + 1/a + 1/b - 1/(a + b));

  a = N/ K_NV; b = D/ K_D;
  j_VH_AH = j_V_Am/ (1 + 1/a + 1/b - 1/(a + b));

  a_A = 1/(1 + rho_H*j_VH_AH/(rho_A*j_VA_AA));
  k = a_A * k_A + (1 - a_A) * k_H;
  j_V_A = 1/ (1/ k + a_A/ (rho_A * j_VA_AA));
  
  %% organic fluxes
  j_V_AA = a_A * j_V_A;
  j_V_AH = (1 - a_A) * j_V_A;
  j_D_AH = - y_DV * j_V_AH;
  j_V_M = - k_M;
  j_V_G = j_V_A + j_V_M;
  j_V_H = -h;
  j_D_H = h;

  %% mineral fluxes
  j_C_AA = - j_V_AA;
  j_C_AH = - j_D_AH - j_V_AH;
  j_C_M = - j_V_M;
  j_N_AA = - n_NV * j_V_AA;
  j_N_AH = - n_NV * (j_D_AH + j_V_AH);
  j_N_M = - n_NV * j_V_M;
  
  X = zeros(2,1); % create 2-vector for output

  %% change in organic compounds that should be set equal to zero
  %% X() = j_C_AA + j_C_AH + j_C_M;      % DIC  
  %% X() = j_N_AA + j_N_AH + j_N_M;    % DIN
  X(1) = j_D_AH + j_D_H;               % D, Detritus
  X(2) = j_V_G + j_V_H;              % V, Structure 
