function [obj] = regConstraint(obj, funcs)
    % This method registers the information of a NLP function as
    % a constraint
    %
    % Parameters:
    %  funcs: a list of contraint functions @type NlpFunction
    %  
    % Parameters:
    %  funcs: new NLP variables @type NlpFunction 
    %
    % @note We always assume ''funcs'' to be a 2-D array or table consists
    % of cell or objects. It also covers 1-D array or scalar variables.
    %
    % @see NlpFunction
    
    
    if iscell(funcs)
        assert(all(cellfun(@(x)isa(x,'NlpFunction'), funcs(:))), ...
            'Each variable must be an object of ''NlpFunction'' class or inherited subclasses');
        
        obj.ConstrArray = [obj.ConstrArray; funcs(:)];
    
    elseif isa(funcs, 'NlpFunction')
        obj.ConstrArray = [obj.ConstrArray; arrayfun(@(x){x}, funcs(:))];
    elseif istable(funcs)
        
        tmp = table2cell(funcs);
        
        assert(all(cellfun(@(x)isa(x,'NlpFunction'), tmp(:))), ...
            'Each variable must be an object of ''NlpFunction'' class or inherited subclasses');
        
        obj.ConstrArray = [obj.ConstrArray; tmp(:)];
        
    else
        error('Unsupported variable type found: %s\n', class(funcs));
    end
    
end