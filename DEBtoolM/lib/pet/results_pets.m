%% results_pets
% Computes model predictions and handles them

%%
function results_pets(txt_par, par_pets, metapar, chem, txt_data, data,  metadata) 
% created 2015/01/17 by Goncalo Marques, 2015/03/21 by Bas Kooijman
% modified 2015/03/30 by Goncalo Marques, 2015/04/01 by Bas Kooijman, 2015/04/14 by Goncalo Marques, 2015/04/27 by Goncalo Marques, 2015/05/05 by Goncalo Marques

%% Syntax
% <../results_pets.m *results_pets*>(txt_par, par_pets, chem, txt_data, data,  metadata) 

%% Description
% Computes model predictions and handles them (by plotting, saving or publishing)
%
% Input
% 
% * txt_par: information on the parameters
% * par_pets: structure with parameters of species
% * chem: structure with chemical parameters for species
% * txt_data: structure with information on the data
% * data: structure with data for species
% * metadata: structure with information on the entry

%% Remarks
% Depending on <estim_options.html *estim_options*> settings:
% writes to results_my_pet.mat an/or results_my_pet.html, 
% plots to screen

global pets results_output pseudodata_pets 

close all

% get (mean) relative errors
data_mre = data;  % define a data structure with weight 1 for every data point and 0 for the pseudodata 
nmweight = fieldnm_wtxt(data_mre, 'weight');
nmwst = strrep(nmweight, '.weight', '');
for i = 1:length(nmweight)
  eval(['dtsets = fieldnames(data_mre.', nmweight{i},');']);
  for j = 1:length(dtsets)
    if strcmp(dtsets{j}, 'psd')
      eval(['psdsets = fieldnames(data_mre.', nmweight{i},'.psd);']);
      for j = 1:length(psdsets)
        eval(['data_mre.', nmweight{i}, '.psd.', psdsets{j}, ' = zeros(length(data_mre.', nmweight{i}, '.psd.', psdsets{j}, '), 1);']);
      end
    else
      eval(['data_mre.', nmweight{i}, '.', dtsets{j}, ' = ones(length(data_mre.', nmweight{i}, '.', dtsets{j}, '), 1);']);
    end
  end
end

[MRE, RE] = mre_st('predict_pets', par_pets, chem, metapar.T_ref, data_mre); % WLS-method
metapar.MRE = MRE;
metapar.RE = RE;

datapl = rmfield_wtxt(data, 'weight');

for i = 1:length(pets)
  ci = num2str(i);
  eval(['[nm nst] = fieldnmnst_st(data.pet', ci,');']);  % nst: number of data sets for pet i
  for j = 1:nst  % replace univariate data by plot data 
    eval(['[aux, k] = size(data.pet', ci, '.', nm{j}, ');']); % number of data points per set
    if k >= 2 && isempty(strfind(nm{j}, 'temp.'))
      eval(['datavec = data.pet', ci, '.', nm{j}, '(:,1);']);
      xaxis = linspace(min(datavec), max(datavec), 100)';
      eval(['datapl.pet', ci, '.', nm{j}, ' = xaxis;']);
      if k >= 3
        yaxis = zeros(length(xaxis), 1);
        eval(['yaxis(1) = data.pet', ci, '.', nm{j}, '(1,2);']);
        eval(['datapl.pet', ci, '.', nm{j}, '(:,2) = yaxis;']);
        for l = 3:k
          eval(['datavec = [data.pet', ci, '.', nm{j}, '(:,1), data.pet', ci, '.', nm{j}, '(:,l)];']);
          extra_dependent_var = spline1(xaxis, datavec);
          eval(['datapl.pet', ci, '.', nm{j}, '(:,l) = extra_dependent_var;']); 
        end
      end
    end
  end
end

Prd_data = predict_pets(par_pets, chem, metapar.T_ref, datapl);

RE_pointer = 1; %auxiliary pointer for the printing of the relative errors

if results_output == 0 || results_output == 1

  for i = 1:length(pets)
    % produce par for species
    par = par_pets;   % for the case with no zoom factor transformation
    
    % unpack par
    v2struct(par);
  
    ci = num2str(i);
    fprintf([pets{i}, ' \n']); % print the species name
    eval(['fprintf(''COMPLETE = %3.1f \n'', metadata.pet', ci, '.COMPLETE);']);
    fprintf('MRE = %8.3f \n\n', MRE)
    
    fprintf('\n');
    eval(['printprd_st(txt_data.pet', ci, ', data.pet', ci, ', Prd_data.pet', ci, ', RE);']);  
    printpar_st(txt_par, par);

    if exist(['results_', pets{i}, '.m'], 'file')
      par = par_pets;   % for the case with no zoom factor transformation
      eval(['results_', pets{i}, '(txt_par, par, chem, metapar, txt_data.pet', ci, ', data.pet', ci, ');']);
    else
    
      eval(['[nm nst] = fieldnmnst_st(datapl.pet', ci, ');']);
      for j = 1:nst
        eval(['[aux, k] = size(data.pet', ci, '.', nm{j}, ');']); % number of data points per set
        if k >= 2 && isempty(strfind(nm{j}, 'temp.'))
          figure;
          eval(['xdata = data.pet', ci, '.', nm{j}, '(:,1);']);
          eval(['ydata = data.pet', ci, '.', nm{j}, '(:,2);']);
          eval(['xpred = datapl.pet', ci, '.', nm{j}, '(:,1);']);
          eval(['ypred = Prd_data.pet', ci, '.', nm{j}, ';']);
          plot(xdata, ydata, '.r', xpred, ypred, 'g')
          eval(['lblx = [char(txt_data.pet', ci, '.label.', nm{j},'(1)), '', '', char(txt_data.pet', ci, '.units.', nm{j},'(1))];']);
          xlabel(lblx);
          eval(['lbly = [char(txt_data.pet', ci, '.label.', nm{j},'(2)), '', '', char(txt_data.pet', ci, '.units.', nm{j},'(2))];']);
          ylabel(lbly);
        end
      end
    end
    fprintf('\n')
  end
end

if results_output == 1 || results_output == 2
  par = par_pets;
  filenm = ['results_', pets{1}, '.mat'];
  metadata = metadata.pet1;
  save(filenm, 'txt_par', 'par', 'metapar', 'chem', 'metadata');
end

if results_output == 2

  for i = 1:length(pets)
    % produce par for species
    par = par_pets;   % for the case with no zoom factor transformation
    
    % unpack par
    v2struct(par);
  
    ci = num2str(i);
    graphnm = ['results_', pets{i}, '_'];
    
    if ~exist(['results_', pets{i}, '.m'], 'file')
      eval(['[nm nst] = fieldnmnst_st(datapl.pet', ci, ');']);
      counter = 1;
      for j = 1:nst
        eval(['[aux, k] = size(data.pet', ci, '.', nm{j}, ');']); % number of data points per set
        if k >= 2
          figure;
          eval(['xdata = data.pet', ci, '.', nm{j}, '(:,1);']);
          eval(['ydata = data.pet', ci, '.', nm{j}, '(:,2);']);
          eval(['xpred = datapl.pet', ci, '.', nm{j}, ';']);
          eval(['ypred = Prd_data.pet', ci, '.', nm{j}, ';']);
          plot(xdata, ydata, '.r', xpred, ypred, 'g')
          eval(['lblx = [char(txt_data.pet', ci, '.label.', nm{j},'(1)), '', '', char(txt_data.pet', ci, '.units.', nm{j},'(1))];']);
          xlabel(lblx);
          eval(['lbly = [char(txt_data.pet', ci, '.label.', nm{j},'(2)), '', '', char(txt_data.pet', ci, '.units.', nm{j},'(2))];']);
          ylabel(lbly);
          if counter < 10
            eval(['print -dpng ', graphnm, '0', num2str(counter),'.png']);
          else
            eval(['print -dpng ', graphnm, num2str(counter), '.png']);
          end
          counter = counter + 1;
        end
      end
    end
    fprintf('\n')
  end
end
