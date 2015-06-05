%% fig:gut
%% bib:Gell75,EverKooy89
%% out:gutvl,gutrl,gutri

%% gut size and gut residence time

%% Daphnia pulex: food (mg C/l), gut residence time (min); bib:Gell75
food_time = [0.09266115296 63.45412827;
	     0.3044269105 24.11004105;
	     0.5155149223 18.46348423;
	     0.9100437563 16.91927658;
	     3.198656165 12.03470168;
	     4.613825787 7.95809493];

%% Daphnia magna: length (mm), gut residence time (min); bib:EverKooy89
length_time = [1.029851558 12.203208;
	       1.335380882 9.948019454;
	       1.468760329 9.757821289;
	       1.796891082 9.889115343;
	       2.416567859 17.08559509;
	       3.124344808 20.18481961;
	       3.220896325 19.74215261;
	       3.946585726 28.65055989;
	       4.073536466 31.71259818];

%% Daphnia magna: length (mm), gut volume (10^6 cells): bib:EverKooy89
length_vol = [0.9382268263 0.4878910005;
	      0.9444947332 0.3913827233;
	      0.9023371182 0.01891696468;
	      0.9414451607 0.05510512628;
	      0.995988099 0.0781361052;
	      1.09135359 0.03045506648;
	      1.158921436 0.368828724;
	      1.19443241 0.4441502256;
	      1.254332074 0.3680731529;
	      1.257763603 0.1568797648;
	      1.294953973 0.08880350127;
	      1.450575289 0.3352351902;
	      1.589657399 0.3914875645;
	      1.665918189 0.3204949062;
	      1.649235303 0.9254487671;
	      1.676377601 0.8027052797;
	      1.732983686 1.081204968;
	      1.921581293 0.6573790093;
	      2.158927976 0.8458097164;
	      2.459818333 1.912292939;
	      2.480788035 1.985122604;
	      2.52571753 1.460761753;
	      2.662153883 1.600458769;
	      3.012660064 2.291142475;
	      3.099438668 1.81859002;
	      3.244326467 2.242382049;
	      3.183987158 2.805969787;
	      3.368751214 3.119952437;
	      3.06688375 2.926818699;
	      2.981766984 3.237724596;
	      3.030087163 3.40418932;
	      3.241334948 4.799863211;
	      3.963773134 3.894730466;
	      4.014666332 3.902148406;
	      4.06938735 4.110274285;
	      4.091443091 5.311922145;
	      3.946296236 5.563342652;
	      4.202742605 5.769871038;
	      4.166805607 8.085163004;
	      4.166187882 8.387578769;
	      4.101404822 9.999211793;
	      4.087765778 11.8789598];

nrregr_options('report',0)
pvol = nrregr('vol', 1, length_vol);
ptL =  nrregr('timeL', 1, length_time);
ptX =  nrregr('timeX',[5 .5]', food_time);
nrregr_options('report',1)

%% gset term postscript color solid  'Times-Roman' 35

subplot(1,3,1);
%% gset output 'gutvl.ps'
L = linspace(0,4.5,100)';
plot(length_vol(:,1), length_vol(:,2),'og', ...
     L, vol(pvol, L),'r')
xlabel('length, mm');
ylabel('gut volume, 10^6 cells');
		    
subplot(1,3,2);
%% gset output 'gutrl.ps'
L = linspace(0,4.5,100)';
plot(length_time(:,1), length_time(:,2), 'og', ...
     L, timeL(ptL, L), 'r');
xlabel('length, mm');
ylabel('gut residence time, min');

subplot(1,3,3);
%% gset output 'gutri.ps'
X = linspace(0.09,5,100)';
plot(food_time(:,1), food_time(:,2),'og', X, timeX(ptX, X),'r')
xlabel('food density, mg C/l');
ylabel('gut residence time, min');
