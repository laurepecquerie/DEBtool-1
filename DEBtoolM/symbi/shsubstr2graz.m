function shsubstr2graz (j)
  %% created 2000/10/18 by Bas Kooijman
  %% called from 'symbi' to show substrate/grazing profiles
  %%  in symbiosis
  %% State vector:
  %%   X_t = [X; X_N; X_CH; X_VA; m_EC; m_EN; X_VH; m_E]
  %%   X: substrate        X_N: nitrogen      X_CH: carbo-hydrate
  %%   X_VA: struc autotr  m_EC: C-res dens   m_EN: N-res density
  %%   X_VH: struc hetero  m_E: res density

  global X_R X_RN;
  
  X_t = [X_R X_RN 0 1 1 1 1 1];
  [Xb_VA, X_Rv, b_VAv] = ...
     varpar2 ('dx', X_t, 'X_R', 100, 75, 12, 'b_VA', 1e-5, .0015, 12);

  rotate3d on
  clf;
   
  if exist('j')==1 % single plot mode
    switch j
      case 1
        mesh (X_Rv, b_VAv, Xb_VA(:,:,4));
        xlabel('substrate'); ylabel('grazing'); zlabel('X_{VA}');
        view(30,5);

      case 2
        mesh (X_Rv, b_VAv, Xb_VA(:,:,7));
        xlabel('substrate'); ylabel('grazing'); zlabel('X_{VH}');
        view(30,5);

      case 3
        mesh (X_Rv, b_VAv, Xb_VA(:,:,4) ./ Xb_VA(:,:,7));
        xlabel('substrate'); ylabel('grazing'); zlabel('X_{VA}/X_{VH}');
        view(30,5);

      otherwise
	      return;
	
    end
  else % multiple plot mode
    %% top_title('Equilibria of auto -and heterotrophs and their ratio')

    subplot (1, 3, 1);
    mesh (X_Rv, b_VAv, Xb_VA(:,:,4));
    xlabel('substrate'); ylabel('grazing'); zlabel('X_{VA}');
    view(30,5);

    subplot (1, 3, 2);
    mesh (X_Rv, b_VAv, Xb_VA(:,:,7));
    xlabel('substrate'); ylabel('grazing'); zlabel('X_{VH}');
    view(30,5);

    subplot (1, 3, 3);
    mesh (X_Rv, b_VAv, Xb_VA(:,:,4) ./ Xb_VA(:,:,7));
    xlabel('substrate'); ylabel('grazing'); zlabel('X_{VA}/X_{VH}');
    view(30,5);

  end
