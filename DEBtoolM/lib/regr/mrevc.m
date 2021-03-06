%% mrevc
% Calculates mean relative error for constant variation coefficients 

%%
function [merr rerr] = mrevc(func, p, varargin)
  %  created: 2010/10/31 by Bas Kooijman, modified 2011/05/02
  
  %% Syntax
  % [merr rerr] = <../mrevc.m *mrevc*>(func, p, varargin)
  
  %% Description
  % Calculates the mean absolute relative error, used in add_my_pet for ML criterion
  %
  % Input
  %
  % * func: character string with name of user-defined function;
  %    see <nrregr.html *nrregr*>
  % * p: (np,nc) matrix with p(:,1) parameter values
  % * xywi: (ni,3) matrix with
  %
  %     xywi(:,1) independent variable
  %     xywi(:,2) dependent variable
  %     xywi(:,3) weight coefficients (optional)
  %     The number of data matrices xyw1, xyw2, ... is optional
  %     The first data matrix is assumed to be zero-variate, 
  %       the others uni-variate, which are first reduced to zero-variate data
  %       if all weight coefficients in a uni-variate data-set are zero,
  %       that relative error gets weight zero
  %
  % Output
  %
  % * merr: scalar with mean absolute relative error
  % * rerr: vector with absolute relative error
  
  %% Remarks
  % Absolute relative errors are first computed for each of the uni-variate data matrices, using the weight coefficients in column 2.
  % The results are added to the collection of absolute relative errors for zero-variate data, with weight coefficients 1.
  % Finally the mean abosulte relative error is computed, where the weight coefficients for the zero-variate data are given in column 3 of the first data-matrix.
    
  %% Example of use
  % See <../mydata_animal.m *mydata_animal*>

  i = 1; 
  nxyw = nargin - 2; % number of data sets
  while (i <= nxyw) % loop across data sets
    ci = num2str(i); % character string with value of i
    eval(['xyw', ci, ' = varargin{i};']); % assing unnamed arguments to xywi
    if size(eval(['xyw', ci]),2) < 3 % append weights if absent
        eval(['xyw', ci,' = [xyw', ci, ', ones(size(xyw', ci, ',1),1)];'])
    end
    if i == 1
      listxyw = ['xyw', ci,',']; % initiate list xyw
      listf = ['f', ci,',']; % initiate list f
    else     
      listxyw = [listxyw, ' xyw', ci,',']; % append list xyw
      listf = [listf, ' f', ci,',']; % append list f
    end
    i = i + 1;
  end
  listxyw(end) = []; listf(end) = []; % remove last ','

  % get function values
  eval(['[', listf,'] = ', func, '(p(:,1),', listxyw,');']);
  % abs relative error for zero-variate data
  rerr = [abs(f1 - xyw1(:,2)) ./ max(1e-3, f1), xyw1(:,3)]; 
  if nxyw > 1 % append uni-variate data
    for i = 2:nxyw
      ci = num2str(i); % character string with value of i
      %rerr = [rerr; sum(abs(fi - xywi(:,2)) .* xywi(:,3) ./ max(1e-3, fi)), 1)/ sum(xywi(:,3)) 1];
      eval(['rerr = [rerr; sum(abs(f', ci, ' - xyw', ci, ...
          '(:,2)) .* xyw', ci, '(:,3) ./ max(1e-3, f', ci, ...
          '), 1)/ sum(max(1e-6, xyw', ci, '(:,3))) 1];']);
      eval(['rerr(end,2) = sum(xyw', ci, '(:,3)) ~= 0;']); % weight 0 if all 0 == xywi(:,3)
    end
  end	    
  merr = sum(prod(rerr,2))/ sum(rerr(:,2));