%% effect of increase in kM and kJ in cum reprod of D. magna at f=1
%% pars from fig_2_10

  z = 1; % zoom factor
  p = [.799; % 1, kap
       .950; % 2, kapR
       .1509; % 3, g
       3.569; % 4, kJ, d^-1
       4.063; % 5, kM, d^-1
       0; % 6, LT, mm
       z*1.6216; % 7, v, mm d^-1 (vol length)
       z^2*.00100; % 8, UHb, mm^2 d (vol length)
       z^2*.0491]; % 9, UHp, mm^2 d^-1 (vol length) 

   [crep, UE0, Lb, Lp, tp] = cum_reprod([0;21], 1, p);
   crep_vector = crep(2); Lb_vector = Lb; Lp_vector = Lp; kM_vector = p(5);
   UE0_vector = UE0; tp_vector = tp;
   Lm = p(7)/ p(3)/ p(5); R = reprod_rate(Lm, 1, p); R_vector = R;


   a = 1.02; % increment factor for kJ & kM
   while crep(2) > 1
     p(5) = a * p(5); Lm = Lm/ a;
     p(4) = a * p(4);
     [crep, UE0, Lb, Lp, tp, info] = cum_reprod([0;21], 1, p, Lb);
     crep_vector = [crep_vector; crep(2)];
     Lb_vector = [Lb_vector; Lb];
     Lp_vector = [Lp_vector; Lp];
     UE0_vector = [UE0_vector; UE0];
     kM_vector = [kM_vector;p(5)];
     tp_vector = [tp_vector; tp];
     R = reprod_rate(Lm, 1, p); R_vector = [R_vector; R];
   end
   n = length(UE0_vector); Lb_vector = Lb_vector(1:n); Lp_vector = Lp_vector(1:n);
   UE0_vector = UE0_vector(1:n); R_vector = R_vector(1:n); kM_vector = kM_vector(1:n);
   crep_vector = crep_vector(1:n); tp_vector = tp_vector(1:n);
   

   subplot(2,3,1)
   plot(kM_vector, crep_vector, 'r')
   xlabel('kM')
   ylabel('cum reproduction')
   
   subplot(2,3,2)
   plot(kM_vector, Lb_vector,'r')
   xlabel('kM')
   ylabel('Lb')

   subplot(2,3,3)
   plot(kM_vector, Lp_vector,'r')
   xlabel('kM')
   ylabel('Lp')

   subplot(2,3,4)
   plot(kM_vector, UE0_vector,'r')
   xlabel('kM')
   ylabel('UE0')

   subplot(2,3,5)
   plot(kM_vector, tp_vector,'r')
   xlabel('kM')
   ylabel('tp')

   subplot(2,3,6)
   plot(kM_vector, R_vector,'r')
   xlabel('kM')
   ylabel('Rm')