function shtime6 (j)
  %% created: 2002/04/04 by Bas Kooijman; modified 2009/09/29
  %% time_plots for 'endosym'
  %% State vector:
  %% (1-2)substrates S (3-4)products P
  %% (5,6)structure V, reserve density m of species 1
  %% (7,8)structure V, reserve density m of species 2 internal

  global istate6; % initial values of state variables set in 'pars'

  err = testpars; % set and test parameter values on consistency
  if err ~= 0 % inconsistent parameter values
    return
  end

  tmax = 100; nt = 100; t = linspace(0, tmax, nt); % set time points
  [t, X_t]  = ode23s ('dstate6', t, istate6);
 
  if exist('j','var')==1 % single plot mode
    clf;
    switch j
	
      case 1
        plot (t, X_t(:,1), 'b', t, X_t(:,2), 'r');
        xlabel('time'); ylabel('substrates'); 

      case 2
        plot (t, X_t(:,3), 'b', t, X_t(:,4), 'r');
        xlabel('time'); ylabel('products');

      case 3
        plot (t, X_t(:,5), 'b', t, X_t(:,7), 'r');
        xlabel('time'); ylabel('structures');

      case 4
        plot (t, X_t(:,6), 'b',t, X_t(:,8), 'r');
        xlabel('time'); ylabel('res densities');

      case 5
        plot (t, X_t(:,8)./X_t(:,6), 'g');
        xlabel('time'); ylabel('ratio structure 2/1');

      otherwise
	return;

    end
  else % multiple plot mode
    
        subplot (2, 2, 1);
        plot (t, X_t(:,1), 'b', t, X_t(:,2), 'r');
        xlabel('time'); ylabel('substrates'); 

        subplot (2, 2, 2);
        plot (t, X_t(:,3), 'b', t, X_t(:,4), 'r');
        xlabel('time'); ylabel('products'); 

        subplot (2, 2, 3);
        plot (t, X_t(:,5), 'b', t, X_t(:,7), 'r');
        xlabel('time'); ylabel('structures');

        subplot (2, 2, 4);
        plot (t, X_t(:,6), 'b', t, X_t(:,8), 'r');
        xlabel('time'); ylabel('res densities');

  end
