function [W100, W75, W44, W35] = fnv0_iso(p, tW100, tW75, tW44, tW35)
%% coded by Bas Kooijman, 2008/09/07
%% rat weight at constant (size independent) feeding at levels rho * ad lib
%% levels rho = 1, .75, .45 are set in this routine
%% W = dV * V * (1 + w * e); e = [E]/ [E_m]

global v kM g LT rho

dV = p(1); % g/cm^3, spec density
w =  p(2); % -, contribution of reserve to weight
V0 = p(3); % g, initial weight
v =  p(4); % cm/d, energy conductance
kM = p(5); % 1/d, somatic maintenance rate coefficient
g =  p(6); % -, energy investment ratio
LT = p(7); % cm, heating length

%% V0 = W0/ (1 + w)/ dV;
rho = 1; [t Ve100] = ode23('dv0_iso', tW100(:,1), [V0; 1]);
W100 = Ve100(:,1) * dV .* (1 + w * Ve100(:,2));
rho = .75; [t Ve75] = ode23('dv0_iso', tW75(:,1), [V0; 1]);
W75 = Ve75(:,1) * dV .* (1 + w * Ve75(:,2));
rho = .44; [t Ve44] = ode23('dv0_iso', tW44(:,1), [V0; 1]);
W44 = Ve44(:,1) * dV .* (1 + w * Ve44(:,2));
rho = .35; [t Ve35] = ode23('dv0_iso', tW35(:,1), [V0; 1]);
W35 = Ve35(:,1) * dV .* (1 + w * Ve35(:,2));