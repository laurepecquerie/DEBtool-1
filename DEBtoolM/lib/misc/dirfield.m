function f = dirfield(nm, x, y, d)
  %
  %% Description
  %  The direction field for a used-defined set of ode's for 2 variables. 
  %
  %% Input
  %  nm: name of user-defined function for [dx, dy]
  %      required structure: dxy = nm(xy)
  %  x: nx-vector of values for x-variable
  %  y: ny-vector of values for y-variable
  %  d: scalar with multiplier for [dx, dy]
  %
  %% Output
  %  f: (nx * ny), 4- matrix with (xi, yj, xi+ d * dxi, yj + d * dyi)
  %
  %% Example of use
  %  see fig_9_2 in domain fig. 

  nx = length(x); ny = length(y); f = zeros(nx * ny, 4);

  for i = 1:nx
    for j = 1:ny
      eval(['dxdy = d * ', nm, '([x(i); y(j)]);']);
      f(j + ny * (i - 1),:) = [x(i), y(j), dxdy(1), dxdy(2)]; 
    end
  end
