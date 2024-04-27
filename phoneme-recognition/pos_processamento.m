function [cat_predicoes, cat_classes] = pos_processamento(predicoes, classe)
    cat_predicoes = {};
    cat_classes = {};
    for i = 1:length(predicoes)
       if(predicoes(i) == 6)
            cat_predicoes(i) = {'DA'};
       elseif(predicoes(i) == 5)
            cat_predicoes(i) = {'QUER'};
       elseif(predicoes(i) == 4)
           cat_predicoes(i) = {'ES'};
       elseif(predicoes(i) == 3)
           cat_predicoes(i) = {'TA'};
       elseif(predicoes(i) == 2)
           cat_predicoes(i) = {'REI'};
       else
           cat_predicoes(i) = {'DI'};
       end
    
       if(classe(i) == 6)
            cat_classes(i) = {'DA'};
       elseif(classe(i) == 5)
           cat_classes(i) = {'QUER'};
       elseif(classe(i) == 4)
           cat_classes(i) = {'ES'};
       elseif(classe(i) == 3)
           cat_classes(i) = {'TA'};
       elseif(classe(i) == 2)
           cat_classes(i) = {'REI'};
       else
           cat_classes(i) = {'DI'};
       end
    end 
    cat_predicoes = cat_predicoes;
    cat_classes = cat_classes;
end