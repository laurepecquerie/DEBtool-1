function m = trian  (r)
  %  Created: 2002/04/09 by  Bas Kooijman; modified 2007/08/08
  %
  %% Description
  %  wraps vector-argument into an upper triangular matrix
  %
  %% Input
  %  r: vector with upper triangular element
  %
  %% Output
  %
  %% Remarks
  %  Function itrian is inverse to function trian.
  %  Requires: -
  %
  %% Example of use
  %  trian([2 4 7]) and itrian(trian([2 4 7]))

  %% Code
  nr = length(r);
  n = sqrt(0.25 + 2*nr) - 0.5;
  if 0 == n - floor(n)
    m = zeros(n,n); c = 0;
    for i = 1:n
      m(i,i:n) = r(c + (i:n));
      c = c + n - i;
    end
  else
    m = [];
    fprintf('improper size of argument \n');
  end
