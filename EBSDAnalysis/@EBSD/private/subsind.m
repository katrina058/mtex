function ind = subsind(ebsd,subs)
% subindexing of EBSD data
%

if numel(subs)==2 && all(cellfun(@isnumeric, subs))
  ind = ebsd.findByLocation([subs{:}]);
  return
else
  ind = true(1,length(ebsd));
end
  
for i = 1:length(subs)

  % ebsd('mineralname') or ebsd({'mineralname1','mineralname2'})
  if ischar(subs{i}) || iscellstr(subs{i})
    
    mineralsSubs = ensurecell(subs{i});
    phaseNumbers = cellfun(@num2str,num2cell(ebsd.phaseMap(:)'),'Uniformoutput',false);
    
    phases = false(1,numel(ebsd.allCS));
    
    for k=1:numel(mineralsSubs)
      phases = phases ...
        | ~cellfun('isempty',regexpi(ebsd.allMinerals,mineralsSubs{k})) ...
        | strcmpi(phaseNumbers,mineralsSubs{k});
    end
    
    ind = ind & phases(ebsd.phaseId(:).');
    
  elseif isa(subs{i},'symmetry')
    
    phases = false(1,length(ebsd.allCS));
    for k=1:length(ebsd.allCS)
      if isa(ebsd.allCS{k},'symmetry') && ebsd.CS{k} == subs{i} && ...
          (isempty(subs{i}.mineral) || strcmp(ebsd.CS{k}.mineral,subs{i}.mineral))
        phases(k) = true;
      end
    end
    ind = ind & phases(ebsd.phaseId(:).');
    
  elseif isa(subs{i},'grain')
    
    ind = ind & ismember(ebsd.options.grain_id,subs{i}.id)';
    
  elseif isa(subs{i},'logical')
    
    sub = any(subs{i}, find(size(subs{i}')==max(size(ind)),1));
    
    ind = ind & reshape(sub,size(ind));
    
  elseif isnumeric(subs{i})
    
    iind = false(size(ind));
    iind(subs{i}) = true;
    ind = ind & iind;
    
    %   elseif isa(subs{i},'polygon')
    
    %     ind = ind & inpolygon(ebsd,subs{i})';
    
  end
end